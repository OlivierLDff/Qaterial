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

import QtQuick 2.0
import QtQuick.Controls 2.0

import Qaterial 1.0 as Qaterial

Row
{
  Column
  {
    Label
    {
      font: Qaterial.Style.textTheme.headline1
      text: "headline1"
    }

    Label
    {
      font: Qaterial.Style.textTheme.headline2
      text: "headline2"
    }

    Label
    {
      font: Qaterial.Style.textTheme.headline3
      text: "headline3"
    }

    Label
    {
      font: Qaterial.Style.textTheme.headline4
      text: "headline4"
    }

    Label
    {
      font: Qaterial.Style.textTheme.headline5
      text: "headline5"
    }

    Label
    {
      font: Qaterial.Style.textTheme.headline6
      text: "headline6"
    }

    Label
    {
      font: Qaterial.Style.textTheme.subtitle1
      text: "subtitle1"
    }

    Label
    {
      font: Qaterial.Style.textTheme.subtitle2
      text: "subtitle2"
    }

    Label
    {
      font: Qaterial.Style.textTheme.body1
      text: "body1"
    }

    Label
    {
      font: Qaterial.Style.textTheme.body2
      text: "body2"
    }

    Label
    {
      font: Qaterial.Style.textTheme.button
      text: "button"
    }

    Label
    {
      font: Qaterial.Style.textTheme.overline
      text: "overline"
    }

    Label
    {
      font: Qaterial.Style.textTheme.caption
      text: "caption"
    }

    Label
    {
      font: Qaterial.Style.textTheme.hint1
      text: "hint1"
    }

    Label
    {
      font: Qaterial.Style.textTheme.hint2
      text: "hint2"
    }
  }

  Column
  {
    Qaterial.LabelHeadline1
    {
      text: "headline1"
    }

    Qaterial.LabelHeadline2
    {
      text: "headline2"
    }

    Qaterial.LabelHeadline3
    {
      text: "headline3"
    }

    Qaterial.LabelHeadline4
    {
      text: "headline4"
    }

    Qaterial.LabelHeadline5
    {
      text: "headline5"
    }

    Qaterial.LabelHeadline6
    {
      text: "headline6"
    }

    Qaterial.LabelSubtitle1
    {
      text: "subtitle1"
    }

    Qaterial.LabelSubtitle2
    {
      text: "subtitle2"
    }

    Qaterial.LabelBody1
    {
      text: "body1"
    }

    Qaterial.LabelBody2
    {
      text: "body2"
    }

    Qaterial.LabelButton
    {
      text: "button"
    }

    Qaterial.LabelOverline
    {
      text: "overline"
    }

    Qaterial.LabelCaption
    {
      text: "caption"
    }

    Qaterial.LabelHint1
    {
      text: "hint1"
    }

    Qaterial.LabelHint2
    {
      text: "hint2"
    }
  }
}
