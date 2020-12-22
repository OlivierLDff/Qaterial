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

import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Qaterial.IconLabelImpl
{
  id: root

  enum Display
  {
    IconOnly,
    TextOnly,
    TextBesideIcon,
    TextUnderIcon
  }

  property int radius: 0
  property int fillMode: Image.PreserveAspectFit
  property string text
  property color color: root.enabled ? Qaterial.Style.primaryTextColor() : Qaterial.Style.disabledTextColor()
  property font font: Qaterial.Style.textTheme.body2
  property int elide: Text.ElideRight
  property int wrapMode: Text.NoWrap
  property int maximumLineCount: Number.MAX_SAFE_INTEGER

  horizontalAlignment: Qt.AlignHCenter
  verticalAlignment: Qt.AlignVCenter
  display: IconLabel.Display.TextBesideIcon
  spacing: 8
  mirrored: false

  icon.color: root.color
  icon.width: 24
  icon.height: 24

  iconItem: Qaterial.ClipRRect
  {
    id: clipper

    radius: root.radius

    Image
    {
      anchors.fill: parent

      source: root.icon.source
      fillMode: root.fillMode
    }
  }

  labelItem: Qaterial.Label
  {
    text: root.text
    font: root.font
    color: root.color
    elide: root.elide
    wrapMode: root.wrapMode
    maximumLineCount: root.maximumLineCount
  }
}
