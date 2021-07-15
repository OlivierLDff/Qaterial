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

#include <Qaterial/Theme/TextTheme.hpp>

namespace qaterial {

TextTheme::TextTheme(QObject* parent)
    : QObject(parent)
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
    _overline.setPixelSize(12);
    _overline.setWeight(QFont::Weight::Normal);
    _overline.setCapitalization(QFont::Capitalization::AllUppercase);
    _overline.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 1.5);

    _hint1.setFamily("Roboto");
    _hint1.setPixelSize(11);
    _hint1.setWeight(QFont::Weight::Medium);
    _hint1.setCapitalization(QFont::Capitalization::MixedCase);
    _hint1.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 0);

    _hint2.setFamily("Roboto");
    _hint2.setPixelSize(11);
    _hint2.setWeight(QFont::Weight::Normal);
    _hint2.setCapitalization(QFont::Capitalization::MixedCase);
    _hint2.setLetterSpacing(QFont::SpacingType::AbsoluteSpacing, 0);
}

}
