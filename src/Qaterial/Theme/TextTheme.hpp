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

#ifndef __QATERIAL_TEXT_THEME_HPP__
#define __QATERIAL_TEXT_THEME_HPP__

#include <Qaterial/Details/Export.hpp>
#include <Qaterial/Details/Property.hpp>

#include <QtCore/QObject>
#include <QtGui/QFont>

namespace qaterial {

class QATERIAL_API_ TextTheme : public QObject
{
    Q_OBJECT
    QATERIAL_REGISTER_TO_QML(TextTheme);

    // ──── CONSTRUCTOR ────
public:
    TextTheme(QObject* parent = nullptr);

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

}

#endif
