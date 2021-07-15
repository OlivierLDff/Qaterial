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

#ifndef __QATERIAL_COLOR_THEME_HPP__
#define __QATERIAL_COLOR_THEME_HPP__

#include <Qaterial/Details/Export.hpp>
#include <Qaterial/Details/Property.hpp>

#include <QtGui/QColor>

namespace qaterial {

class QATERIAL_API_ ColorTheme : public QObject
{
    Q_OBJECT
    QATERIAL_REGISTER_TO_QML(ColorTheme);

    // ──── CONSTRUCTOR ────
public:
    ColorTheme(QObject* parent = nullptr);

    // ──── VARIANT ────
public:
    // Define text colors, background, etc...
    QATERIAL_PROPERTY_D(bool, dark, Dark, true);

    // ──── TEXT COLORS ────
public:
    QATERIAL_PROPERTY_RO(QColor, primaryText, PrimaryText);
    QATERIAL_PROPERTY_RO(QColor, secondaryText, SecondaryText);
    QATERIAL_PROPERTY_RO(QColor, disabledText, DisabledText);
    QATERIAL_PROPERTY_RO(QColor, errorText, ErrorText);

    // ──── PRIMARY COLORS ────
public:
    QATERIAL_PROPERTY(QColor, primary, Primary);
    QATERIAL_PROPERTY_RO(QColor, primaryLight, PrimaryLight);
    QATERIAL_PROPERTY_RO(QColor, primaryDark, PrimaryDark);
    QATERIAL_PROPERTY(QColor, onPrimaryText, OnPrimaryText);

    // ──── ACCENT COLORS ────
public:
    QATERIAL_PROPERTY(QColor, accent, Accent);
    QATERIAL_PROPERTY_RO(QColor, accentLight, AccentLight);
    QATERIAL_PROPERTY_RO(QColor, accentDark, AccentDark);
    QATERIAL_PROPERTY(QColor, onAccentText, OnAccentText);

    // ──── BACKGROUND COLORS ────
public:
    QATERIAL_PROPERTY_D(QColor, background, Background, "#121212");

private:
    Q_PROPERTY(QColor background0 READ background0 NOTIFY backgroundChanged);
    Q_PROPERTY(QColor background1 READ background1 NOTIFY backgroundChanged);
    Q_PROPERTY(QColor background2 READ background2 NOTIFY backgroundChanged);
    Q_PROPERTY(QColor background4 READ background4 NOTIFY backgroundChanged);
    Q_PROPERTY(QColor background6 READ background6 NOTIFY backgroundChanged);
    Q_PROPERTY(QColor background8 READ background8 NOTIFY backgroundChanged);
    Q_PROPERTY(QColor background12 READ background12 NOTIFY backgroundChanged);
    Q_PROPERTY(QColor background16 READ background16 NOTIFY backgroundChanged);
    Q_PROPERTY(QColor background24 READ background24 NOTIFY backgroundChanged);

private:
    QColor getBrandedBackground() const;

public:
    QColor background0() const;
    QColor background1() const;
    QColor background2() const;
    QColor background4() const;
    QColor background6() const;
    QColor background8() const;
    QColor background12() const;
    QColor background16() const;
    QColor background24() const;

    // ──── TOOLTIP COLORS ────
public:
    QATERIAL_PROPERTY_D(QColor, toolTip, ToolTip, "#F0F0F0");
    QATERIAL_PROPERTY_RO(QColor, toolTipText, ToolTipText);

    // ──── ELEVATED COLORS ────
public:
    Q_PROPERTY(QColor surface READ background1 NOTIFY backgroundChanged);
    Q_PROPERTY(QColor button READ background2 NOTIFY backgroundChanged);
    Q_PROPERTY(QColor appBar READ background4 NOTIFY backgroundChanged);
    Q_PROPERTY(QColor fab READ background6 NOTIFY backgroundChanged);
    Q_PROPERTY(QColor navDrawer READ background16 NOTIFY backgroundChanged);
    Q_PROPERTY(QColor dialog READ background24 NOTIFY backgroundChanged);

    // ──── API ────
public Q_SLOTS:
    static QColor blendedColor(const QColor& color1, const QColor& color2, const qreal& alpha);
    static QColor getElevatedColor(const QColor& color, const int& elevation);
    static qreal getOverlayForElevation(const int& elevation);

private Q_SLOTS:
    void computeColors();
};

}

Q_DECLARE_METATYPE(qaterial::ColorTheme*)

#endif
