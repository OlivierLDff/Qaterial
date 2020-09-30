#ifndef __QATERIAL_LAYOUT_HPP__
#define __QATERIAL_LAYOUT_HPP__

// ──── INCLUDE ────

// Library Headers
#include <Qaterial/Export.hpp>
#include <Qaterial/Property.hpp>

// Dependencies Headers
#include <QQuickItem>

// Standard Header

// ──── DECLARATION ────

namespace qaterial {

// ──── CLASS ────

class LayoutAttached : public QObject
{
    Q_OBJECT
    QML_ANONYMOUS

public:
    LayoutAttached(QObject* object);

    QATERIAL_PROPERTY(int, extraLarge, ExtraLarge);
    QATERIAL_PROPERTY(int, large, Large);
    QATERIAL_PROPERTY(int, medium, Medium);
    QATERIAL_PROPERTY(int, small, Small);
    QATERIAL_PROPERTY(int, extraSmall, ExtraSmall);
};

// A Layout resize its target's children width to follow the Material Grid's system.
// todo : Inherit from QQuickFlow
// This is not possible since QQuickFlow isn't public API for now.
// The trick is to copy to Layout everything it needs to know from Flow
// \code
// // Grid.qml
//
// import QtQuick 2.15
// import Qaterial 1.0 as Qaterial
//
// Flow
// {
//   id: root
//
//   Qaterial.Layout
//   {
//     items: root.children
//
//     width: root.width
//     height: root.height
//
//     spacing: root.spacing
//
//     leftPadding: root.leftPadding
//     rightPadding: root.rightPadding
//     topPadding: root.topPadding
//     bottomPadding: root.bottomPadding
//
//     layoutDirection: root.layoutDirection
//     flow: root.flow
//   }
// }
// \endcode
class QATERIAL_API_ Layout : public QObject
{
    Q_OBJECT
    QATERIAL_REGISTER_TO_QML(Layout);
    QML_ATTACHED(LayoutAttached)

    // ──── CONSTRUCTOR ────
public:
    Layout(QObject* parent = nullptr);

    // ──── CONSTANTS ────
public:
    enum LayoutType
    {
        ExtraLarge,
        Large,
        Medium,
        Small,
        ExtraSmall,
    };
    Q_ENUM(LayoutType);

    static constexpr int GRID_SIZE() { return 12; }

    enum LayoutFill
    {
        FillParent = 12,
        FillNinth = 9,
        FillHalf = 6,
        FillThird = 4,
        FillQuarter = 3,
        FillSixth = 2,
        FillTwelfth = 1,
    };
    Q_ENUM(LayoutFill);

public:
    static constexpr qreal EXTRA_SIZE() { return 1280.f; }
    static constexpr qreal LARGE_SIZE() { return 960.f; }
    static constexpr qreal MEDIUM_SIZE() { return 600.f; }
    static constexpr qreal SMALL_SIZE() { return 360.f; }

    static constexpr int sizeToType(qreal size)
    {
        if(size >= EXTRA_SIZE())
            return LayoutType::ExtraLarge;
        if(size >= LARGE_SIZE())
            return LayoutType::Large;
        if(size >= MEDIUM_SIZE())
            return LayoutType::Medium;
        if(size >= SMALL_SIZE())
            return LayoutType::Small;
        return LayoutType::ExtraSmall;
    }
    static constexpr LayoutFill defaultPreferredFill(int type)
    {
        switch(LayoutType(type))
        {
        case ExtraLarge: return FillTwelfth;
        case Large: return FillSixth;
        case Medium: return FillQuarter;
        case Small: return FillHalf;
        case ExtraSmall: return FillParent;
        default: return FillParent;
        }
    }

    // ──── ATTRIBUTES ────
private:
    // Any Of:
    // - Layout.ExtraLarge
    // - Layout.Large
    // - Layout.Medium
    // - Layout.Small
    // - Layout.ExtraSmall
    // This property is evaluated each time width/height/padding/spacing/flow change
    QATERIAL_PROPERTY_RO(int, type, Type);

    QATERIAL_PROPERTY(qreal, width, Width);
    QATERIAL_PROPERTY(qreal, height, Height);

    QATERIAL_PROPERTY(qreal, spacing, Spacing);

    QATERIAL_PROPERTY(qreal, leftPadding, LeftPadding);
    QATERIAL_PROPERTY(qreal, rightPadding, RightPadding);
    QATERIAL_PROPERTY(qreal, topPadding, TopPadding);
    QATERIAL_PROPERTY(qreal, bottomPadding, BottomPadding);

    // Qt.LeftToRight | Qt.RightToLeft
    QATERIAL_PROPERTY(int, layoutDirection, LayoutDirection);

    // Flow.LeftToRight | Flow.TopToBottom
    QATERIAL_PROPERTY(int, flow, Flow);

    Q_PROPERTY(QQmlListReference items READ items WRITE setItems);

public:
    QQmlListReference items() const { return _itemListRef; }
    void setItems(QQmlListReference value);

Q_SIGNALS:
    void itemsChanged();

public:
    static LayoutAttached* qmlAttachedProperties(QObject* parent) { return new LayoutAttached(parent); }

private:
    QQmlListReference _itemListRef;
    std::vector<QQuickItem*> _items;
    QQuickItem* _previousTarget = nullptr;
    bool _widthForcedOnce = false;
    bool _heightForcedOnce = false;
    bool _flowChanged = false;

    // ──── PUBLIC API ────
public Q_SLOTS:
    void forceUpdate();

    // ──── PRIVATE API ────
private Q_SLOTS:
    void triggerHorizontalReevaluate();
    void triggerVerticalReevaluate();
    void computeChildItemsSize();

private:
    // Flow.LeftToRight == 0 (In private API for now, THIS CODE MIGHT BREAK)
    bool flowIsLeftToRight() const { return flow() == 0; }
    // Flow.TopToBottom == 1 (In private API for now, THIS CODE MIGHT BREAK)
    bool flowIsTopToBottom() const { return flow() == 1; }

    void resetItemsWidth();
    void resetItemsHeight();
    void resetItemsSize();

    void evaluateType();

    qreal paddingLessWidth() const { return width() - leftPadding() - rightPadding(); }
    qreal paddingLessHeight() const { return height() - topPadding() - bottomPadding(); }
    qreal paddingLessSize() const { return flowIsLeftToRight() ? paddingLessWidth() : paddingLessHeight(); }

    void doForeachItem(const std::function<void(QQuickItem*)>& callback);
    LayoutFill getPreferredFill(QQuickItem* item) const;
    LayoutFill defaultPreferredFill() const;

    qreal getPreferredSize(QQuickItem* item) const;
};

}

#endif
