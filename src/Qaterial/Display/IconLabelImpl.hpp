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

#ifndef __QATERIAL_ICON_LABEL_IMPL_HPP__
#define __QATERIAL_ICON_LABEL_IMPL_HPP__

#include <Qaterial/Details/Export.hpp>
#include <Qaterial/Details/Property.hpp>
#include <Qaterial/Display/IconLabelPositioner.hpp>
#include <Qaterial/Display/IconDescription.hpp>

#include <QtQuick/QQuickItem>

namespace qaterial {

class QATERIAL_API_ IconLabelImpl : public QQuickItem
{
    Q_OBJECT
    QATERIAL_REGISTER_TO_QML(IconLabelImpl);

    // ──── CONSTRUCTOR ────
public:
    IconLabelImpl(QQuickItem* parent = nullptr);

    // ──── PROPERTY ────
private:
    IconLabelPositioner* _positioner = nullptr;

    // ──── POSITIONNER PROXY ────
public:
    Q_PROPERTY(Qt::Alignment horizontalAlignment READ horizontalAlignment WRITE setHorizontalAlignment RESET resetHorizontalAlignment NOTIFY
            horizontalAlignmentChanged);
    Q_PROPERTY(Qt::Alignment verticalAlignment READ verticalAlignment WRITE setVerticalAlignment RESET resetVerticalAlignment NOTIFY
            verticalAlignmentChanged);
    Q_PROPERTY(int display READ display WRITE setDisplay RESET resetDisplay NOTIFY displayChanged);
    Q_PROPERTY(qreal spacing READ spacing WRITE setSpacing RESET resetSpacing NOTIFY spacingChanged);
    Q_PROPERTY(bool mirrored READ mirrored WRITE setMirrored RESET resetMirrored NOTIFY mirroredChanged);

public:
    Qt::Alignment horizontalAlignment() const
    {
        return _positioner->horizontalAlignment();
    }
    Qt::Alignment verticalAlignment() const
    {
        return _positioner->verticalAlignment();
    }
    int display() const
    {
        return _positioner->display();
    }
    qreal spacing() const
    {
        return _positioner->spacing();
    }
    bool mirrored() const
    {
        return _positioner->mirrored();
    }

    void setHorizontalAlignment(const Qt::Alignment& value) const
    {
        _positioner->setHorizontalAlignment(value);
    }
    void setVerticalAlignment(const Qt::Alignment& value) const
    {
        _positioner->setVerticalAlignment(value);
    }
    void setDisplay(const int& value) const
    {
        _positioner->setDisplay(IconLabelPositioner::Display(value));
    }
    void setSpacing(const qreal& value) const
    {
        _positioner->setSpacing(value);
    }
    void setMirrored(const bool& value) const
    {
        _positioner->setMirrored(value);
    }

    void resetHorizontalAlignment() const
    {
        _positioner->resetHorizontalAlignment();
    }
    void resetVerticalAlignment() const
    {
        _positioner->resetVerticalAlignment();
    }
    void resetDisplay() const
    {
        _positioner->resetDisplay();
    }
    void resetSpacing() const
    {
        _positioner->resetSpacing();
    }
    void resetMirrored() const
    {
        _positioner->resetMirrored();
    }

Q_SIGNALS:
    void horizontalAlignmentChanged(const Qt::Alignment& value);
    void verticalAlignmentChanged(const Qt::Alignment& value);
    void displayChanged(const int& value);
    void spacingChanged(const qreal& value);
    void mirroredChanged(const bool& value);

    // ──── PROPERTY ────
public:
    // fixme : Use QQuickIcon when it will turn public API.
    QATERIAL_PTR_WITH_CONNECTION(IconDescription, icon, Icon);
    QATERIAL_PTR_WITH_CONNECTION(QQuickItem, iconItem, IconItem);
    QATERIAL_PTR_WITH_CONNECTION(QQuickItem, labelItem, LabelItem);

private:
    void connectToIcon() const;
    void disconnectFromIcon();

    void connectToIconItem();
    void disconnectFromIconItem();

    void connectToLabelItem();
    void disconnectFromLabelItem() const;

    void updateIconItemVisible() const;
    void updateLabelItemVisible() const;

private Q_SLOTS:
    void updateIconImplicitSize() const;
    void updateLabelImplicitSize() const;
    void updateContainerSize() const;
    void updateImplicitSize();
    void updateIconRect() const;
    void updateLabelRect() const;

protected:
    void componentComplete() override;
};

}

#endif
