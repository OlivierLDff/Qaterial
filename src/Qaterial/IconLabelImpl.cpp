// MIT License
//
// Copyright (c) 2020 Olivier Le Doeuff
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

// ──── INCLUDE ────

// Library Headers
#include <Qaterial/IconLabelImpl.hpp>

// Dependencies Headers

// ──── DECLARATION ────

// ──── FUNCTIONS ────

namespace qaterial {

IconLabelImpl::IconLabelImpl(QQuickItem* parent) :
    QQuickItem(parent), _positionner(new IconLabelPositionner(this)), _icon(new IconDescription(this))
{
    _positionner->setEnabled(false);

    connect(_positionner, &IconLabelPositionner::horizontalAlignmentChanged, this, &IconLabelImpl::horizontalAlignmentChanged);
    connect(_positionner, &IconLabelPositionner::verticalAlignmentChanged, this, &IconLabelImpl::verticalAlignmentChanged);
    connect(_positionner, &IconLabelPositionner::displayChanged, this, &IconLabelImpl::displayChanged);
    connect(_positionner, &IconLabelPositionner::spacingChanged, this, &IconLabelImpl::spacingChanged);
    connect(_positionner, &IconLabelPositionner::mirroredChanged, this, &IconLabelImpl::mirroredChanged);

    connect(_positionner, &IconLabelPositionner::implicitSizeChanged, this, &IconLabelImpl::updateImplicitSize);
    connect(_positionner, &IconLabelPositionner::iconRectChanged, this, &IconLabelImpl::updateIconRect);
    connect(_positionner, &IconLabelPositionner::labelRectChanged, this, &IconLabelImpl::updateLabelRect);

    connect(this, &IconLabelImpl::widthChanged, this, &IconLabelImpl::updateContainerSize);
    connect(this, &IconLabelImpl::heightChanged, this, &IconLabelImpl::updateContainerSize);

    _positionner->setContainerSize(size());
}

void IconLabelImpl::connectToIcon() const
{
    if(!isComponentComplete())
        return;

    if(_icon)
    {
        connect(_icon, &IconDescription::sourceChanged, this, &IconLabelImpl::updateIconImplicitSize);
        connect(_icon, &IconDescription::heightChanged, this, &IconLabelImpl::updateIconImplicitSize);
        connect(_icon, &IconDescription::widthChanged, this, &IconLabelImpl::updateIconImplicitSize);
    }

    updateIconImplicitSize();
}

void IconLabelImpl::disconnectFromIcon()
{
    if(!_icon)
        return;

    disconnect(_icon, nullptr, this, nullptr);

    if(_icon->parent() == this)
        _icon->deleteLater();
}

void IconLabelImpl::connectToIconItem()
{
    if(_iconItem)
        _iconItem->setParentItem(this);

    if(!isComponentComplete())
        return;

    if(_iconItem)
    {
        updateIconItemVisible();
    }

    updateIconImplicitSize();
}

void IconLabelImpl::disconnectFromIconItem()
{
    if(!_iconItem)
        return;

    disconnect(_iconItem, nullptr, this, nullptr);

    if(_iconItem->parent() == this)
    {
        _iconItem->setParentItem(nullptr);
        // fixme : Delete the _iconItem somehow when qt quick will expose public api to do it correctly during object creation
    }
}

void IconLabelImpl::connectToLabelItem()
{
    if(_labelItem)
        _labelItem->setParentItem(this);

    if(!isComponentComplete())
        return;

    if(_labelItem)
    {
        updateLabelItemVisible();

        connect(_labelItem, &QQuickItem::implicitWidthChanged, this, &IconLabelImpl::updateLabelImplicitSize);
        connect(_labelItem, &QQuickItem::implicitHeightChanged, this, &IconLabelImpl::updateLabelImplicitSize);
    }

    updateLabelImplicitSize();
}

void IconLabelImpl::disconnectFromLabelItem() const
{
    if(!_labelItem)
        return;

    disconnect(_labelItem, nullptr, this, nullptr);

    if(_labelItem->parent() == this)
    {
        _labelItem->setParentItem(nullptr);
        // fixme : Delete the _labelItem somehow when qt quick will expose public api to do it correctly during object creation
    }
}

void IconLabelImpl::updateIconItemVisible() const
{
    if(_iconItem)
        _iconItem->setVisible(display() != IconLabelPositionner::TextOnly);
}

void IconLabelImpl::updateLabelItemVisible() const
{
    if(_labelItem)
        _labelItem->setVisible(display() != IconLabelPositionner::IconOnly);
}

void IconLabelImpl::updateIconImplicitSize() const
{
    Q_CHECK_PTR(_positionner);

    if(display() == IconLabelPositionner::TextOnly || !_iconItem || !_icon || _icon->source().isEmpty())
    {
        _positionner->resetIconImplicitSize();
    }
    else
    {
        _positionner->setIconImplicitSize(QSizeF(_icon->width(), _icon->height()));
    }
}

void IconLabelImpl::updateLabelImplicitSize() const
{
    if(display() == IconLabelPositionner::IconOnly || !_labelItem || !(_labelItem->implicitWidth() > 0 && _labelItem->implicitHeight() > 0))
    {
        _positionner->resetLabelImplicitSize();
    }
    else
    {
        _positionner->setLabelImplicitSize(QSizeF(_labelItem->implicitWidth(), _labelItem->implicitHeight()));
    }
}

void IconLabelImpl::updateContainerSize() const { _positionner->setContainerSize(size()); }

void IconLabelImpl::updateImplicitSize()
{
    if(!isComponentComplete())
        return;

    setImplicitSize(_positionner->implicitSize().width(), _positionner->implicitSize().height());
}

void IconLabelImpl::updateIconRect() const
{
    if(!_iconItem || !isComponentComplete())
        return;

    _iconItem->setPosition(_positionner->iconRect().topLeft());
    _iconItem->setSize(_positionner->iconRect().size());
}

void IconLabelImpl::updateLabelRect() const
{
    if(!_labelItem || !isComponentComplete())
        return;

    _labelItem->setPosition(_positionner->labelRect().topLeft());
    _labelItem->setWidth(_positionner->labelRect().width());
}

void IconLabelImpl::componentComplete()
{
    QQuickItem::componentComplete();

    connect(this,
        &IconLabelImpl::displayChanged,
        this,
        [this]()
        {
            updateIconItemVisible();
            updateLabelItemVisible();
            updateIconImplicitSize();
            updateLabelImplicitSize();
        });

    connectToIcon();
    connectToIconItem();
    connectToLabelItem();
    _positionner->setEnabled(true);
}

}
