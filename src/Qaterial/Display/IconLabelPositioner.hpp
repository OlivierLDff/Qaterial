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

#ifndef __QATERIAL_ICON_LABEL_POSITIONNER_HPP__
#define __QATERIAL_ICON_LABEL_POSITIONNER_HPP__

#include <Qaterial/Details/Export.hpp>
#include <Qaterial/Details/Property.hpp>

#include <QtCore/QRect>
#include <QtCore/QSize>

namespace qaterial {

class QATERIAL_API_ IconLabelPositioner : public QObject
{
    Q_OBJECT
    QATERIAL_REGISTER_TO_QML(IconLabelPositioner);

    // ──── CONSTRUCTOR ────
public:
    IconLabelPositioner(QObject* parent = nullptr);

public:
    enum Display
    {
        IconOnly,
        TextOnly,
        TextBesideIcon,
        TextUnderIcon
    };
    Q_ENUM(Display)

    // ──── PROPERTY IN ────
public:
    QATERIAL_PROPERTY_D(Qt::Alignment, horizontalAlignment, HorizontalAlignment, Qt::AlignHCenter);
    QATERIAL_PROPERTY_D(Qt::Alignment, verticalAlignment, VerticalAlignment, Qt::AlignVCenter);
    QATERIAL_PROPERTY(Display, display, Display);
    QATERIAL_PROPERTY(qreal, spacing, Spacing);
    QATERIAL_PROPERTY(bool, mirrored, Mirrored);
    QATERIAL_PROPERTY(QSizeF, iconImplicitSize, IconImplicitSize);
    QATERIAL_PROPERTY(QSizeF, labelImplicitSize, LabelImplicitSize);
    QATERIAL_PROPERTY(QSizeF, containerSize, ContainerSize);

private:
    bool _enabled = true;

public:
    void setEnabled(bool value)
    {
        if(value != _enabled)
        {
            _enabled = value;
            if(_enabled)
                computeRects();
        }
    }

    // ──── PROPERTY OUT ────
public:
    QATERIAL_PROPERTY_D(QSizeF, implicitSize, ImplicitSize, QSizeF(0, 0));
    QATERIAL_PROPERTY_RO_D(QRectF, iconRect, IconRect, QRectF(0, 0, 0, 0));
    QATERIAL_PROPERTY_RO_D(QRectF, labelRect, LabelRect, QRectF(0, 0, 0, 0));

    // ──── LAYOUTING ────
private Q_SLOTS:
    // Compute implicitSize/iconRect/labelRect from alignment/display/spacing/mirrored/iconImplicitSize/labelImplicitSize/containerSize
    void computeRects();

private:
    bool isIconImplicitWidthValid() const;
    bool isLabelImplicitWidthValid() const;
    bool isContainerSizeValid() const;

    void computeIconOnlyRect();
    void computeTextOnlyRect();
    void computeTextBesideIcon();
    void computeTextUnderIcon();
};

}

#endif
