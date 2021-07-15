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

#include <Qaterial/Display/IconLabelPositioner.hpp>

namespace qaterial {

IconLabelPositioner::IconLabelPositioner(QObject* parent)
    : QObject(parent)
{
    connect(this, &IconLabelPositioner::horizontalAlignmentChanged, this, &IconLabelPositioner::computeRects);
    connect(this, &IconLabelPositioner::verticalAlignmentChanged, this, &IconLabelPositioner::computeRects);
    connect(this, &IconLabelPositioner::displayChanged, this, &IconLabelPositioner::computeRects);
    connect(this, &IconLabelPositioner::spacingChanged, this, &IconLabelPositioner::computeRects);
    connect(this, &IconLabelPositioner::mirroredChanged, this, &IconLabelPositioner::computeRects);
    connect(this, &IconLabelPositioner::iconImplicitSizeChanged, this, &IconLabelPositioner::computeRects);
    connect(this, &IconLabelPositioner::labelImplicitSizeChanged, this, &IconLabelPositioner::computeRects);
    connect(this, &IconLabelPositioner::containerSizeChanged, this, &IconLabelPositioner::computeRects);
}

void IconLabelPositioner::computeRects()
{
    if(!_enabled || !isContainerSizeValid())
        return;

    switch(Display(display()))
    {
    case IconOnly:
        computeIconOnlyRect();
        break;
    case TextOnly:
        computeTextOnlyRect();
        break;
    case TextBesideIcon:
        computeTextBesideIcon();
        break;
    case TextUnderIcon:
        computeTextUnderIcon();
        break;
    default:
        break;
    }
}

bool IconLabelPositioner::isIconImplicitWidthValid() const
{
    return _iconImplicitSize.width() >= 0 && _iconImplicitSize.height() >= 0;
}

bool IconLabelPositioner::isLabelImplicitWidthValid() const
{
    return _labelImplicitSize.width() >= 0 && _labelImplicitSize.height() >= 0;
}

bool IconLabelPositioner::isContainerSizeValid() const
{
    return _containerSize.width() >= 0 && _containerSize.height() >= 0;
}

void IconLabelPositioner::computeIconOnlyRect()
{
    if(!isIconImplicitWidthValid())
        return;

    const auto iconX = [&]() -> qreal
    {
        if(_horizontalAlignment & Qt::AlignLeft)
            return 0;
        if(_horizontalAlignment & Qt::AlignRight)
            return _containerSize.width() - _iconImplicitSize.width();
        if(_horizontalAlignment & Qt::AlignHCenter)
            return (_containerSize.width() - _iconImplicitSize.width()) / 2;
        return 0;
    }();

    const auto iconY = [&]() -> qreal
    {
        if(_verticalAlignment & Qt::AlignTop)
            return 0;
        if(_verticalAlignment & Qt::AlignBottom)
            return _containerSize.height() - _iconImplicitSize.height();
        if(_verticalAlignment & Qt::AlignVCenter)
            return (_containerSize.height() - _iconImplicitSize.height()) / 2;
        return 0;
    }();

    const auto iconWidth = _iconImplicitSize.width();
    const auto iconHeight = _iconImplicitSize.height();

    setIconRect(QRectF(iconX, iconY, iconWidth, iconHeight));
    setLabelRect(QRectF());
    setImplicitSize(_iconImplicitSize);
}

void IconLabelPositioner::computeTextOnlyRect()
{
    if(!isLabelImplicitWidthValid())
        return;

    const auto labelImplicitWidthFitInContainer = _containerSize.width() >= _labelImplicitSize.width();
    const auto labelX = [&]() -> qreal
    {
        if(!labelImplicitWidthFitInContainer)
            return 0;

        if(_horizontalAlignment & Qt::AlignLeft)
            return 0;
        if(_horizontalAlignment & Qt::AlignRight)
            return _containerSize.width() - _labelImplicitSize.width();
        if(_horizontalAlignment & Qt::AlignHCenter)
            return (_containerSize.width() - _labelImplicitSize.width()) / 2;
        return 0;
    }();

    const auto labelY = [&]() -> qreal
    {
        if(_verticalAlignment & Qt::AlignTop)
            return 0;
        if(_verticalAlignment & Qt::AlignBottom)
            return _containerSize.height() - _labelImplicitSize.height();
        if(_verticalAlignment & Qt::AlignVCenter)
            return (_containerSize.height() - _labelImplicitSize.height()) / 2;
        return 0;
    }();

    const auto labelWidth = labelImplicitWidthFitInContainer ? _labelImplicitSize.width() : _containerSize.width();
    const auto labelHeight = _labelImplicitSize.height();

    setIconRect(QRectF());
    setLabelRect(QRectF(labelX, labelY, labelWidth, labelHeight));
    setImplicitSize(_labelImplicitSize);
}

void IconLabelPositioner::computeTextBesideIcon()
{
    if(!isLabelImplicitWidthValid() && !isIconImplicitWidthValid())
        return;

    const auto effectiveSpacing = _iconImplicitSize.width() > 0 && _labelImplicitSize.width() > 0 ? _spacing : 0;
    const auto effectiveLabelImplicitHeight = _labelImplicitSize.width() > 0 ? _labelImplicitSize.height() : 0;

    const auto implicitSizeWidth = _labelImplicitSize.width() + _iconImplicitSize.width() + effectiveSpacing;
    const auto implicitSizeHeight = std::max(effectiveLabelImplicitHeight, _iconImplicitSize.height());

    const auto labelImplicitWidthFitInContainer = _containerSize.width() >= implicitSizeWidth;
    const auto xAlignmentOffset = [&]() -> qreal
    {
        if(!labelImplicitWidthFitInContainer)
            return 0;

        if(_horizontalAlignment & Qt::AlignLeft)
            return 0;
        if(_horizontalAlignment & Qt::AlignRight)
            return _containerSize.width() - implicitSizeWidth;
        if(_horizontalAlignment & Qt::AlignHCenter)
            return (_containerSize.width() - implicitSizeWidth) / 2;
        return 0;
    }();

    const auto iconX = [&]() -> qreal
    {
        if(mirrored())
            return (labelImplicitWidthFitInContainer ? implicitSizeWidth : _containerSize.width()) - _iconImplicitSize.width()
                   + xAlignmentOffset;
        return xAlignmentOffset;
    }();

    const auto iconY = [&]() -> qreal
    {
        if(_verticalAlignment & Qt::AlignTop)
            return (implicitSizeHeight - _iconImplicitSize.height()) / 2;
        if(_verticalAlignment & Qt::AlignBottom)
            return _containerSize.height() - _iconImplicitSize.height() - (implicitSizeHeight - _iconImplicitSize.height()) / 2;
        if(_verticalAlignment & Qt::AlignVCenter)
            return (_containerSize.height() - _iconImplicitSize.height()) / 2;
        return 0;
    }();

    const auto iconWidth = _iconImplicitSize.width();
    const auto iconHeight = _iconImplicitSize.height();

    const auto labelX = [&]() -> qreal
    {
        if(mirrored())
            return xAlignmentOffset;
        return _iconImplicitSize.width() + effectiveSpacing + xAlignmentOffset;
    }();

    const auto labelWidth = [&]() -> qreal
    {
        if(mirrored())
            return std::min(_containerSize.width() - _iconImplicitSize.width() - effectiveSpacing, _labelImplicitSize.width());

        return std::min(_containerSize.width() - labelX, _labelImplicitSize.width());
    }();

    const auto labelY = [&]() -> qreal
    {
        if(_verticalAlignment & Qt::AlignTop)
            return (implicitSizeHeight - _labelImplicitSize.height()) / 2;
        if(_verticalAlignment & Qt::AlignBottom)
            return _containerSize.height() - _labelImplicitSize.height() - (implicitSizeHeight - _labelImplicitSize.height()) / 2;
        if(_verticalAlignment & Qt::AlignVCenter)
            return (_containerSize.height() - _labelImplicitSize.height()) / 2;
        return 0;
    }();

    const auto labelHeight = _labelImplicitSize.height();

    setIconRect(QRectF(iconX, iconY, iconWidth, iconHeight));
    setLabelRect(QRectF(labelX, labelY, labelWidth, labelHeight));
    setImplicitSize(QSizeF(implicitSizeWidth, implicitSizeHeight));
}

void IconLabelPositioner::computeTextUnderIcon()
{
    if(!isLabelImplicitWidthValid() || !isIconImplicitWidthValid())
        return;

    const auto effectiveSpacing = _iconImplicitSize.width() > 0 && _labelImplicitSize.width() > 0 ? _spacing : 0;
    const auto effectiveLabelImplicitHeight = _labelImplicitSize.width() > 0 ? _labelImplicitSize.height() : 0;

    const auto implicitWidth = std::max(_labelImplicitSize.width(), _iconImplicitSize.width());
    const auto implicitHeight = effectiveLabelImplicitHeight + _iconImplicitSize.height() + effectiveSpacing;

    const auto implicitSizeFitInContainer = _containerSize.width() >= implicitWidth;

    const auto iconX = [&]() -> qreal
    {
        if(_horizontalAlignment & Qt::AlignLeft)
            return 0;
        if(_horizontalAlignment & Qt::AlignRight)
            return _containerSize.width() - _iconImplicitSize.width();
        if(_horizontalAlignment & Qt::AlignHCenter)
            return (_containerSize.width() - _iconImplicitSize.width()) / 2;
        return 0;
    }();

    const auto iconY = [&]() -> qreal
    {
        if(mirrored())
        {
            if(_verticalAlignment & Qt::AlignTop)
                return implicitHeight - _iconImplicitSize.height();
            if(_verticalAlignment & Qt::AlignBottom)
                return _containerSize.height() - _iconImplicitSize.height();
            if(_verticalAlignment & Qt::AlignVCenter)
                return (_containerSize.height() + implicitHeight) / 2 - _iconImplicitSize.height();
        }
        else
        {
            if(_verticalAlignment & Qt::AlignTop)
                return 0;
            if(_verticalAlignment & Qt::AlignBottom)
                return _containerSize.height() - implicitHeight;
            if(_verticalAlignment & Qt::AlignVCenter)
                return (_containerSize.height() - implicitHeight) / 2;
        }
        return 0;
    }();

    const auto iconWidth = _iconImplicitSize.width();
    const auto iconHeight = _iconImplicitSize.height();

    const auto labelWidth = implicitSizeFitInContainer ? _labelImplicitSize.width() : _containerSize.width();
    const auto labelX = [&]() -> qreal
    {
        if(_horizontalAlignment & Qt::AlignLeft)
            return 0;
        if(_horizontalAlignment & Qt::AlignRight)
            return _containerSize.width() - labelWidth;
        if(_horizontalAlignment & Qt::AlignHCenter)
            return (_containerSize.width() - labelWidth) / 2;
        return 0;
    }();

    const auto labelY = [&]() -> qreal
    {
        if(mirrored())
            return iconY - effectiveSpacing - _labelImplicitSize.height();
        return iconY + effectiveSpacing + _iconImplicitSize.height();
    }();

    const auto labelHeight = _labelImplicitSize.height();

    setIconRect(QRectF(iconX, iconY, iconWidth, iconHeight));
    setLabelRect(QRectF(labelX, labelY, labelWidth, labelHeight));
    setImplicitSize(QSizeF(implicitWidth, implicitHeight));
}

}
