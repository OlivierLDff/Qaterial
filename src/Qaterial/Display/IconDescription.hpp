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

#ifndef __QATERIAL_ICON_DESCRIPTION_HPP__
#define __QATERIAL_ICON_DESCRIPTION_HPP__

#include <Qaterial/Details/Export.hpp>
#include <Qaterial/Details/Property.hpp>

#include <QtCore/QUrl>
#include <QtGui/QColor>

namespace qaterial {

// Behave like QQuickIcon (that is private)
class QATERIAL_API_ IconDescription : public QObject
{
    Q_OBJECT
    QATERIAL_REGISTER_TO_QML(IconDescription);

    // ──── CONSTRUCTOR ────
public:
    IconDescription(QObject* parent = nullptr)
        : QObject(parent)
    {
    }

    // ──── PROPERTY ────
public:
    // This property holds the name of the icon to use.
    // The icon will be loaded as a regular image.
    QATERIAL_PROPERTY(QUrl, source, Source);

    // This property holds the width of the icon.
    // The icon's width will never exceed this value, though it will shrink when necessary.
    QATERIAL_PROPERTY_D(int, width, Width, 24);

    // This property holds the height of the icon.
    // The icon's height will never exceed this value, though it will shrink when necessary.
    QATERIAL_PROPERTY_D(int, height, Height, 24);

    // This property holds the color of the icon.
    // The icon is tinted with the specified color, unless the color is set to "transparent".
    QATERIAL_PROPERTY(QColor, color, Color);

    // This property specifies whether the icon should be cached.
    // The default value is true.
    QATERIAL_PROPERTY_D(bool, cache, Cache, true);
};

}

#endif
