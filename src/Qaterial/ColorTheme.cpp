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
#include <Qaterial/ColorTheme.hpp>

// Dependencies Headers

// ──── DECLARATION ────

// ──── FUNCTIONS ────

namespace qaterial {

template<typename T>
static T lerp(T a, T b, T f)
{
    if(qFuzzyCompare(a, b))
        return a;
    return a + f * (b - a);
}
template<typename T>
static T dotProduct(T a, T b, T f)
{
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

    const auto overlayRatio = dotProduct(qreal(fromKey), qreal(toKey), qreal(elevation));

    return lerp(fromOverlay, toOverlay, overlayRatio);
}

ColorTheme::ColorTheme(QObject* parent) : QObject(parent)
{
    computeTextColors();
    computeBackgroundColors();

    // realBrandedBackgroundChanged

    connect(this,
        &ColorTheme::backgroundChanged,
        this,
        [this]()
        {
            if(!useBrandedBackground())
                Q_EMIT realBrandedBackgroundChanged();
        });
    connect(this,
        &ColorTheme::brandedBackgroundChanged,
        this,
        [this]()
        {
            if(useBrandedBackground())
                Q_EMIT realBrandedBackgroundChanged();
        });
    connect(this, &ColorTheme::useBrandedBackgroundChanged, this, &ColorTheme::realBrandedBackgroundChanged);

    // computeColors

    connect(this, &ColorTheme::darkChanged, this, &ColorTheme::computeColors);
    connect(this, &ColorTheme::primaryChanged, this, &ColorTheme::computeColors);
    connect(this, &ColorTheme::backgroundChanged, this, &ColorTheme::computeColors);
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

    return QColor::fromRgbF(lerp(color1.redF(), color2.redF(), alpha),
        lerp(color1.greenF(), color2.greenF(), alpha),
        lerp(color1.blueF(), color2.blueF(), alpha),
        lerp(color1.alphaF(), color2.alphaF(), alpha));
}

QColor ColorTheme::getElevatedColor(const QColor& color, const int& elevation)
{
    return blendedColor(color, QColor(Qt::white), getOverlayForElevation(elevation));
}

qreal ColorTheme::getOverlayForElevation(const int& elevation) { return elevationToOverlay(elevation); }

void ColorTheme::computeColors()
{
    computeBackgroundColors();
    computeTextColors();
}

void ColorTheme::computeBackgroundColors() { setBrandedBackground(blendedColor(background(), primary(), 0.08)); }

void ColorTheme::computeTextColors()
{
    if(dark())
    {
        QColor white(Qt::white);
        setPrimaryText(blendedColor(realBrandedBackground(), white, 1));
        setSecondaryText(blendedColor(realBrandedBackground(), white, 0.7));
        setDisabledText(blendedColor(realBrandedBackground(), white, 0.38));
    }
    else
    {
        // https://material.io/design/color/text-legibility.html#text-backgrounds
        QColor black(Qt::black);
        setPrimaryText(blendedColor(realBrandedBackground(), black, 0.87));
        setSecondaryText(blendedColor(realBrandedBackground(), black, 0.60));
        setDisabledText(blendedColor(realBrandedBackground(), black, 0.38));
    }
}

void ColorTheme::computeToolTipColors()
{
    if(dark())
    {
        setPrimaryText(blendedColor(toolTip(), QColor(Qt::white), 1));
    }
    else
    {
        setPrimaryText(blendedColor(toolTip(), QColor(Qt::black), 0.87));
    }
}

}
