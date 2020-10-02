// ──── INCLUDE ────

// Library Headers
#include <Qaterial/Layout.hpp>

// Dependencies Headers

// Qt Headers

// Stl Headers
#include <cmath>

// ──── DECLARATION ────

using namespace qaterial;

// ──── FUNCTIONS ────

LayoutAttached::LayoutAttached(QObject* object) :
    _extraLarge(Layout::defaultPreferredFill(Layout::ExtraLarge)), _large(Layout::defaultPreferredFill(Layout::Large)),
    _medium(Layout::defaultPreferredFill(Layout::Medium)), _small(Layout::defaultPreferredFill(Layout::Small)),
    _extraSmall(Layout::defaultPreferredFill(Layout::ExtraSmall))
{
}

Layout::Layout(QObject* parent) : QObject(parent)
{
    // Reevaluate no matter if horizontal or vertical layout
    connect(this, &Layout::itemsChanged, this, &Layout::computeChildItemsSize, Qt::QueuedConnection);
    connect(this, &Layout::spacingChanged, this, &Layout::computeChildItemsSize);
    connect(this, &Layout::layoutDirectionChanged, this, &Layout::computeChildItemsSize);
    connect(this, &Layout::flowChanged, this,
        [this]()
        {
            _flowChanged = true;
            computeChildItemsSize();
        });

    // Reevaluate only horizontal
    connect(this, &Layout::widthChanged, this, &Layout::triggerHorizontalReevaluate);
    connect(this, &Layout::leftPaddingChanged, this, &Layout::triggerHorizontalReevaluate);
    connect(this, &Layout::rightPaddingChanged, this, &Layout::triggerHorizontalReevaluate);

    // Reevaluate only vertical
    connect(this, &Layout::heightChanged, this, &Layout::triggerVerticalReevaluate);
    connect(this, &Layout::topPaddingChanged, this, &Layout::triggerVerticalReevaluate);
    connect(this, &Layout::bottomPaddingChanged, this, &Layout::triggerVerticalReevaluate);
}

void Layout::setItems(QQmlListReference value)
{
    resetItemsWidth();
    resetItemsHeight();

    _itemListRef = value;
    _items.clear();

    // Recreate std::vector<QQuickItem*> from the QQmlListReference to cast only here.
    if(value.canAt() && value.canCount())
    {
        const auto itemCount = value.count();
        for(int i = 0; i < itemCount; ++i)
        {
            if(const auto item = qobject_cast<QQuickItem*>(value.at(i)))
            {
                _items.push_back(item);
            }
        }
    }

    Q_EMIT itemsChanged();
}

bool Layout::setColumns(int value)
{
    if(value <= 0)
        return false;

    if(_columns == value)
        return false;

    _columns = value;
    Q_EMIT columnsChanged();
    return true;
}

void Layout::setUserColumns(int value)
{
    if(setColumns(value))
        _userSetColumns = true;
}

void Layout::resetUserColumns()
{
    _userSetColumns = false;
    computeColumnsFromType();
}

void Layout::forceUpdate() { computeChildItemsSize(); }

void Layout::triggerHorizontalReevaluate()
{
    if(flowIsLeftToRight())
        computeChildItemsSize();
}

void Layout::triggerVerticalReevaluate()
{
    if(flowIsTopToBottom())
        computeChildItemsSize();
}

void Layout::computeChildItemsSize()
{
    // Optionally reset item width or height if the flow direction changed
    resetItemsSize();

    // Compute layout type based on width/height depending on flow
    evaluateType();

    // Should be called after type evaluation, since it depends on it
    computeColumnsFromType();

    // Resize every item, in 'layoutDirection' order
    doForeachItem(
        [this](QQuickItem* item)
        {
            const auto size = getPreferredSize(item);

            if(flowIsLeftToRight())
                item->setWidth(size);
            else
                item->setHeight(size);
        });

    // Keep track if width or height have been set, for later reset if flow direction change
    if(flowIsLeftToRight() && !_widthForcedOnce)
        _widthForcedOnce = true;
    if(flowIsTopToBottom() && !_heightForcedOnce)
        _heightForcedOnce = true;
}

void Layout::resetItemsWidth()
{
    if(!_widthForcedOnce)
        return;
    for(const auto item: _items) { item->resetWidth(); }
    _widthForcedOnce = false;
}

void Layout::resetItemsHeight()
{
    if(!_heightForcedOnce)
        return;
    for(const auto item: _items) { item->resetHeight(); }
    _heightForcedOnce = false;
}

void Layout::resetItemsSize()
{
    if(!_flowChanged)
        return;

    resetItemsWidth();
    resetItemsHeight();

    _flowChanged = false;
}

void Layout::evaluateType()
{
    if(flowIsLeftToRight())
        setType(sizeToType(width()));
    else if(flowIsTopToBottom())
        setType(sizeToType(height()));
}

void Layout::doForeachItem(const std::function<void(QQuickItem*)>& callback)
{
    if(!callback)
        return;

    if(_items.empty())
        return;

    if(layoutDirection() == Qt::LeftToRight)
    {
        for(auto it = _items.begin(); it != _items.end(); ++it) { callback(*it); }
    }
    else
    {
        for(auto it = _items.rbegin(); it != _items.rend(); ++it) { callback(*it); }
    }
}

Layout::LayoutFill Layout::getPreferredFill(QQuickItem* item) const
{
    const auto attached = qobject_cast<LayoutAttached*>(qmlAttachedPropertiesObject<Layout>(item, false));
    if(!attached)
        return defaultPreferredFill();

    switch(LayoutBreakpoint(type()))
    {
    case ExtraLarge: return LayoutFill(attached->extraLarge());
    case Large: return LayoutFill(attached->large());
    case Medium: return LayoutFill(attached->medium());
    case Small: return LayoutFill(attached->small());
    case ExtraSmall: return LayoutFill(attached->extraSmall());
    default: return FillParent;
    }
}

Layout::LayoutFill Layout::defaultPreferredFill() const { return defaultPreferredFill(type()); }

int Layout::fillToRealBlockCount(LayoutFill fill) const
{
    const auto ratio = qreal(fill)/12.f;
    return std::ceil(qreal(columns())*ratio);
}

qreal Layout::getPreferredSize(QQuickItem* item) const
{
    const auto consumedSpace = fillToRealBlockCount(getPreferredFill(item));
    if(consumedSpace <= 0)
        return 0;

    Q_ASSERT(columns() > 0);

    const auto allSpacingSize = qreal(columns() - 1) * spacing();
    const auto oneBlockSize = std::floor(paddingLessSize() - allSpacingSize) / qreal(columns());
    const auto blockSize = oneBlockSize * consumedSpace;
    const auto overlappedSpacingSize = (consumedSpace - 1) * spacing();

    return std::floor(blockSize + overlappedSpacingSize);
}

void Layout::computeColumnsFromType()
{
    if(_userSetColumns)
        return;

    switch(LayoutBreakpoint(type()))
    {
    case ExtraLarge:
    case Large: setColumns(12); break;
    case Medium: setColumns(8); break;
    case Small:
    case ExtraSmall: setColumns(4); break;
    default: setColumns(12);
    }
}
