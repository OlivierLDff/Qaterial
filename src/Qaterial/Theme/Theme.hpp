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

#ifndef __QATERIAL_THEME_HPP__
#define __QATERIAL_THEME_HPP__

#include <Qaterial/Theme/TextTheme.hpp>
#include <Qaterial/Theme/ColorTheme.hpp>

namespace qaterial {

class ThemeAttached : public QObject
{
    Q_OBJECT
    QML_ANONYMOUS
    QATERIAL_REGISTER_ANONYMOUS_TO_QML(ThemeAttached);

    // ──── CONSTRUCTOR ────
public:
    ThemeAttached(QObject* parent = nullptr)
        : QObject(parent)
    {
    }

    // ──── PROPERTY ────
public:
    QATERIAL_PROPERTY(int, elevation, Elevation);
};

class QATERIAL_API_ Theme : public QObject
{
    Q_OBJECT
    QATERIAL_REGISTER_TO_QML(Theme);
    QML_ATTACHED(ThemeAttached)

    // ──── CONSTRUCTOR ────
public:
    Theme(QObject* parent = nullptr);

    // ──── PROPERTY ────
public:
    QATERIAL_PTR(TextTheme, textTheme, TextTheme);
    QATERIAL_PROPERTY_D(bool, dark, Dark, true);
    QATERIAL_PTR(ColorTheme, darkColorTheme, DarkColorTheme);
    QATERIAL_PTR(ColorTheme, lightColorTheme, LightColorTheme);

protected:
    Q_PROPERTY(qaterial::ColorTheme* colorTheme READ colorTheme NOTIFY colorThemeChanged);

public:
    ColorTheme* colorTheme() const
    {
        return _dark ? _darkColorTheme : _lightColorTheme;
    }

Q_SIGNALS:
    void colorThemeChanged();

    // ──── ATTACHED ────
public:
    static ThemeAttached* qmlAttachedProperties(QObject* parent)
    {
        return new ThemeAttached(parent);
    }
};

}

#endif
