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

// ──── INCLUDE ────

// Library Headers
#include <Qaterial/Export.hpp>
#include <Qaterial/Property.hpp>

// Dependencies Headers
#include <QtGui/QColor>

// ──── DECLARATION ────

// ──── CLASS ────

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
    // In dark mode, primary color is overlayed on top of background
    QATERIAL_PROPERTY_D(bool, useBrandedBackground, UseBrandedBackground, true);

    // ──── TEXT COLORS ────
public:
    QATERIAL_PROPERTY_RO(QColor, primaryText, PrimaryText);
    QATERIAL_PROPERTY_RO(QColor, secondaryText, SecondaryText);
    QATERIAL_PROPERTY_RO(QColor, disabledText, DisabledText);

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
    QATERIAL_PROPERTY_RO(QColor, brandedBackground, BrandedBackground);

protected:
    Q_PROPERTY(QColor realBrandedBackground READ realBrandedBackground NOTIFY realBrandedBackgroundChanged)
public:
    QColor realBrandedBackground() const { return _useBrandedBackground ? _brandedBackground : _background; }
Q_SIGNALS:
    void realBrandedBackgroundChanged();

    // ──── TOOLTIP COLORS ────
public:
    QATERIAL_PROPERTY_D(QColor, toolTip, ToolTip, "#F0F0F0");
    QATERIAL_PROPERTY_RO(QColor, toolTipText, ToolTipText);

    // ──── ELEVATED COLORS ────
public:
    // Surface is 1dp
    QATERIAL_PROPERTY_RO(QColor, surface, Surface);
    // Button is 2dp
    QATERIAL_PROPERTY_RO(QColor, button, Button);
    // AppBar is 4dp
    QATERIAL_PROPERTY_RO(QColor, appBar, AppBar);
    // AppBar is 6dp
    QATERIAL_PROPERTY_RO(QColor, fab, Fab);
    // NavDrawer is 16dp
    QATERIAL_PROPERTY_RO(QColor, navDrawer, NavDrawer);
    // Dialog is 24dp
    QATERIAL_PROPERTY_RO(QColor, dialog, Dialog);

protected:
    Q_PROPERTY(QColor surfaceDisabled READ surfaceDisabled NOTIFY surfaceChanged);
    Q_PROPERTY(QColor buttonDisabled READ buttonDisabled NOTIFY buttonChanged);
    Q_PROPERTY(QColor appBarDisabled READ appBarDisabled NOTIFY appBarChanged);
    Q_PROPERTY(QColor fabDisabled READ fabDisabled NOTIFY fabChanged);
    Q_PROPERTY(QColor navDrawerDisabled READ navDrawerDisabled NOTIFY navDrawerChanged);
    Q_PROPERTY(QColor dialogDisabled READ dialogDisabled NOTIFY dialogChanged);

public:
    QColor surfaceDisabled() const { return getElevatedColor(_surface, 1); }
    QColor buttonDisabled() const { return getElevatedColor(_button, 2); }
    QColor appBarDisabled() const { return getElevatedColor(_appBar, 4); }
    QColor fabDisabled() const { return getElevatedColor(_fab, 6); }
    QColor navDrawerDisabled() const { return getElevatedColor(_navDrawer, 16); }
    QColor dialogDisabled() const { return getElevatedColor(_dialog, 24); }

    // ──── API ────
public Q_SLOTS:
    static QColor blendedColor(const QColor& color1, const QColor& color2, const qreal& alpha);
    static QColor getElevatedColor(const QColor& color, const int& elevation);
    static qreal getOverlayForElevation(const int& elevation);

private Q_SLOTS:
    void computeColors();

private:
    void computeBackgroundColors();
    void computeTextColors();
    void computeToolTipColors();
};

}

Q_DECLARE_METATYPE(qaterial::ColorTheme*)

#endif
