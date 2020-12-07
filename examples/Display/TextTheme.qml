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

import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Column
{
  property Qaterial.TextTheme textTheme: Qaterial.TextTheme {}

  Qaterial.Label
  {
    font: textTheme.headline1
    text: "headline1"
  }
  Qaterial.Label
  {
    font: textTheme.headline2
    text: "headline2"
  }
  Qaterial.Label
  {
    font: textTheme.headline3
    text: "headline3"
  }
  Qaterial.Label
  {
    font: textTheme.headline4
    text: "headline4"
  }
  Qaterial.Label
  {
    font: textTheme.headline5
    text: "headline5"
  }
  Qaterial.Label
  {
    font: textTheme.headline6
    text: "headline6"
  }
  Qaterial.Label
  {
    font: textTheme.subtitle1
    text: "subtitle1"
  }
  Qaterial.Label
  {
    font: textTheme.subtitle2
    text: "subtitle2"
  }
  Qaterial.Label
  {
    font: textTheme.body1
    text: "body1"
  }
  Qaterial.Label
  {
    font: textTheme.body2
    text: "body2"
  }
  Qaterial.Label
  {
    font: textTheme.button
    text: "button"
  }
  Qaterial.Label
  {
    font: textTheme.overline
    text: "overline"
  }
  Qaterial.Label
  {
    font: textTheme.caption
    text: "caption"
  }
  Qaterial.Label
  {
    font: textTheme.hint1
    text: "hint1"
  }
  Qaterial.Label
  {
    font: textTheme.hint2
    text: "hint2"
  }
}
