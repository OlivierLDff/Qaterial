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

#include <Qaterial/Theme/ColorTheme.hpp>

namespace qaterial {

template<typename T>
static T lerp(T a, T b, T f)
{
    if(qFuzzyCompare(a, b))
        return a;
    return a + f * (b - a);
}
template<typename T>
static T invLerp(T a, T b, T f)
{
    if(qFuzzyCompare(a, b))
        return 0;
    return (f - a) / (b - a);
}

static qreal elevationToOverlay(const int& elevation)
{
    // Values from https://material.io/design/color/dark-theme.html#properties
    static const std::map<int, qreal> elevationToOverlay = {
        {0, 0},
        {1, 0.05},
        {2, 0.07},
        {3, 0.08},
        {4, 0.09},
        {6, 0.11},
        {8, 0.12},
        {12, 0.14},
        {16, 0.15},
        {24, 0.16},
    };

    const auto iterator = elevationToOverlay.lower_bound(elevation);
    if(iterator == elevationToOverlay.end())
    {
        return elevationToOverlay.rbegin()->second;
    }

    if(iterator == elevationToOverlay.begin() || iterator->first == elevation)
    {
        return iterator->second;
    }

    const auto [fromKey, fromOverlay] = *std::prev(iterator);
    const auto [toKey, toOverlay] = *iterator;

    const auto overlayRatio = invLerp(qreal(fromKey), qreal(toKey), qreal(elevation));

    return lerp(fromOverlay, toOverlay, overlayRatio);
}

ColorTheme::ColorTheme(QObject* parent)
    : QObject(parent)
{
    computeColors();

    connect(this,
        &ColorTheme::primaryChanged,
        this,
        [this]()
        {
            // In Dark mode, background is branded with primary color.
            // The result is that when primary changed, all the dependent background color change too
            if(dark())
                Q_EMIT backgroundChanged(_background);
        });

    // computeColors
    connect(this, &ColorTheme::darkChanged, this, &ColorTheme::computeColors);
    connect(this, &ColorTheme::primaryChanged, this, &ColorTheme::computeColors);
    connect(this, &ColorTheme::backgroundChanged, this, &ColorTheme::computeColors);
}

QColor ColorTheme::getBrandedBackground() const
{
    // Only brand the color in dark mode
    if(!_dark)
        return _background;

    static const double brandingRatio = 0.08;
    return blendedColor(_background, _primary, brandingRatio);
}

QColor ColorTheme::background0() const
{
    return getElevatedColor(getBrandedBackground(), 0);
}

QColor ColorTheme::background1() const
{
    return getElevatedColor(getBrandedBackground(), 1);
}

QColor ColorTheme::background2() const
{
    return getElevatedColor(getBrandedBackground(), 2);
}

QColor ColorTheme::background4() const
{
    return getElevatedColor(getBrandedBackground(), 4);
}

QColor ColorTheme::background6() const
{
    return getElevatedColor(getBrandedBackground(), 6);
}

QColor ColorTheme::background8() const
{
    return getElevatedColor(getBrandedBackground(), 8);
}

QColor ColorTheme::background12() const
{
    return getElevatedColor(getBrandedBackground(), 12);
}

QColor ColorTheme::background16() const
{
    return getElevatedColor(getBrandedBackground(), 16);
}

QColor ColorTheme::background24() const
{
    return getElevatedColor(getBrandedBackground(), 24);
}

QColor ColorTheme::blendedColor(const QColor& color1, const QColor& color2, const qreal& alpha)
{
    Q_ASSERT(alpha >= 0 && alpha <= 1);

    if(qFuzzyIsNull(alpha))
        return color1;

    if(qFuzzyCompare(alpha, 1))
        return color2;

    if(color1 == color2)
        return color1;

    return QColor::fromRgbF(lerp<double>(color1.redF(), color2.redF(), alpha),
        lerp<double>(color1.greenF(), color2.greenF(), alpha),
        lerp<double>(color1.blueF(), color2.blueF(), alpha),
        lerp<double>(color1.alphaF(), color2.alphaF(), alpha));
}

QColor ColorTheme::getElevatedColor(const QColor& color, const int& elevation)
{
    return blendedColor(color, QColor(Qt::white), getOverlayForElevation(elevation));
}

qreal ColorTheme::getOverlayForElevation(const int& elevation)
{
    return elevationToOverlay(elevation);
}

void ColorTheme::computeColors()
{
    // Color plays an important role in text legibility.
    // https://material.io/design/color/text-legibility.html#text-backgrounds

    if(dark())
    {
        static const QColor white(Qt::white);

        static double primaryRatio = 1;
        static double secondaryRatio = 0.70;
        static double disabledRatio = 0.38;

        setPrimaryText(blendedColor(getBrandedBackground(), white, primaryRatio));
        setSecondaryText(blendedColor(getBrandedBackground(), white, secondaryRatio));
        setDisabledText(blendedColor(getBrandedBackground(), white, disabledRatio));

        setErrorText(blendedColor(getBrandedBackground(), QColor("#EF5350"), primaryRatio));
        setToolTipText(blendedColor(toolTip(), QColor(Qt::black), primaryRatio));
    }
    else
    {
        static const QColor black(Qt::black);

        static double primaryRatio = 0.87;
        static double secondaryRatio = 0.60;
        static double disabledRatio = 0.38;

        setPrimaryText(blendedColor(getBrandedBackground(), black, primaryRatio));
        setSecondaryText(blendedColor(getBrandedBackground(), black, secondaryRatio));
        setDisabledText(blendedColor(getBrandedBackground(), black, disabledRatio));

        setErrorText(blendedColor(getBrandedBackground(), QColor("#F44336"), primaryRatio));
        setToolTipText(blendedColor(toolTip(), QColor(Qt::white), primaryRatio));
    }
}

}
