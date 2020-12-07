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

// ──── INCLUDE ────

// Library Headers
#include <Qaterial/Export.hpp>
#include <Qaterial/Property.hpp>

// Dependencies Headers
#include <QtCore/QObject>
#include <QtGui/QFont>

// ──── DECLARATION ────

// ──── CLASS ────

namespace qaterial {

class QATERIAL_API_ TextTheme : public QObject
{
    Q_OBJECT
    QATERIAL_REGISTER_TO_QML(TextTheme);

    // ──── CONSTRUCTOR ────
public:
    TextTheme(QObject* parent = nullptr) : QObject(parent)
    {
        _headline1.setFamily("Roboto");
        _headline1.setPixelSize(96);
        _headline1.setWeight(QFont::Weight::Thin);
        _headline1.setCapitalization(QFont::Capitalization::MixedCase);
        _headline1.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, -1.5);

        _headline2.setFamily("Roboto");
        _headline2.setPixelSize(60);
        _headline2.setWeight(QFont::Weight::Thin);
        _headline2.setCapitalization(QFont::Capitalization::MixedCase);
        _headline2.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, -0.5);

        _headline3.setFamily("Roboto");
        _headline3.setPixelSize(48);
        _headline3.setWeight(QFont::Weight::Normal);
        _headline3.setCapitalization(QFont::Capitalization::MixedCase);
        _headline3.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 0);

        _headline4.setFamily("Roboto");
        _headline4.setPixelSize(34);
        _headline4.setWeight(QFont::Weight::Normal);
        _headline4.setCapitalization(QFont::Capitalization::MixedCase);
        _headline4.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 0.25);

        _headline5.setFamily("Roboto");
        _headline5.setPixelSize(24);
        _headline5.setWeight(QFont::Weight::Normal);
        _headline5.setCapitalization(QFont::Capitalization::MixedCase);
        _headline5.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 0);

        _headline6.setFamily("Roboto");
        _headline6.setPixelSize(20);
        _headline6.setWeight(QFont::Weight::Medium);
        _headline6.setCapitalization(QFont::Capitalization::MixedCase);
        _headline6.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 0.15);

        _subtitle1.setFamily("Roboto");
        _subtitle1.setPixelSize(16);
        _subtitle1.setWeight(QFont::Weight::Normal);
        _subtitle1.setCapitalization(QFont::Capitalization::MixedCase);
        _subtitle1.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 0.15);

        _subtitle2.setFamily("Roboto");
        _subtitle2.setPixelSize(14);
        _subtitle2.setWeight(QFont::Weight::Medium);
        _subtitle2.setCapitalization(QFont::Capitalization::MixedCase);
        _subtitle2.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 0.1);

        _body1.setFamily("Roboto");
        _body1.setPixelSize(16);
        _body1.setWeight(QFont::Weight::Normal);
        _body1.setCapitalization(QFont::Capitalization::MixedCase);
        _body1.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 0.5);

        _body2.setFamily("Roboto");
        _body2.setPixelSize(14);
        _body2.setWeight(QFont::Weight::Normal);
        _body2.setCapitalization(QFont::Capitalization::MixedCase);
        _body2.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 0.25);

        _button.setFamily("Roboto");
        _button.setPixelSize(14);
        _button.setWeight(QFont::Weight::Medium);
        _button.setCapitalization(QFont::Capitalization::AllUppercase);
        _button.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 1.25);

        _caption.setFamily("Roboto");
        _caption.setPixelSize(12);
        _caption.setWeight(QFont::Weight::Normal);
        _caption.setCapitalization(QFont::Capitalization::MixedCase);
        _caption.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 0.4);

        _overline.setFamily("Roboto");
        _overline.setPixelSize(10);
        _overline.setWeight(QFont::Weight::Normal);
        _overline.setCapitalization(QFont::Capitalization::AllUppercase);
        _overline.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 1.5);

        _hint1.setFamily("Roboto");
        _hint2.setPixelSize(11);
        _hint1.setWeight(QFont::Weight::Medium);
        _hint1.setCapitalization(QFont::Capitalization::MixedCase);
        _hint1.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 0);

        _hint2.setFamily("Roboto");
        _hint2.setPixelSize(11);
        _hint2.setWeight(QFont::Weight::Normal);
        _hint2.setCapitalization(QFont::Capitalization::MixedCase);
        _hint2.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 0);
    }

    // ──── PROPERTY ────
public:
    enum Type
    {
        // Material 2018
        Headline1,
        Headline2,
        Headline3,
        Headline4,
        Headline5,
        Headline6,
        Subtitle1,
        Subtitle2,
        Body1,
        Body2,
        Button,
        Caption,
        Overline,

        // Qaterial Extra
        Hint1,
        Hint2,

        // Material 2014 mapping
        Display4 = Headline1,
        Display3 = Headline2,
        Display2 = Headline3,
        Display1 = Headline4,
        Heading = Headline5,
        Title = Headline6,
        Subheading = Subtitle1,
        Subhead = Subtitle1,
        Body2_2014 = Body1,
        Body1_2014 = Body2,
    };
    Q_ENUM(Type);

public:
    QATERIAL_PROPERTY(QFont, headline1, Headline1);
    QATERIAL_PROPERTY(QFont, headline2, Headline2);
    QATERIAL_PROPERTY(QFont, headline3, Headline3);
    QATERIAL_PROPERTY(QFont, headline4, Headline4);
    QATERIAL_PROPERTY(QFont, headline5, Headline5);
    QATERIAL_PROPERTY(QFont, headline6, Headline6);
    QATERIAL_PROPERTY(QFont, subtitle1, Subtitle1);
    QATERIAL_PROPERTY(QFont, subtitle2, Subtitle2);
    QATERIAL_PROPERTY(QFont, body1, Body1);
    QATERIAL_PROPERTY(QFont, body2, Body2);
    QATERIAL_PROPERTY(QFont, button, Button);
    QATERIAL_PROPERTY(QFont, caption, Caption);
    QATERIAL_PROPERTY(QFont, overline, Overline);
    QATERIAL_PROPERTY(QFont, hint1, Hint1);
    QATERIAL_PROPERTY(QFont, hint2, Hint2);
};

class QATERIAL_API_ Theme : public QObject
{
    Q_OBJECT
    QATERIAL_REGISTER_TO_QML(Theme);

    // ──── CONSTRUCTOR ────
public:
    Theme(QObject* parent = nullptr) : QObject(parent) {}

    // ──── PROPERTY ────
public:
    QATERIAL_PTR(TextTheme, textTheme, TextTheme);
};

}

#endif
