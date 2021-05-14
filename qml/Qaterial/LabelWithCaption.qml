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

Item
{
  id: root

  property alias text: textLabel.text
  property alias textFont: textLabel.font
  property color textColor: Qaterial.Style.colorTheme.primaryText

  property alias caption: captionLabel.text
  property alias captionFont: captionLabel.font
  property color captionColor: Qaterial.Style.colorTheme.secondaryText

  implicitWidth: Math.max(textLabel.implicitWidth, captionLabel.implicitWidth)
  implicitHeight: (text ? textLabel.implicitHeight : 0) + (caption ? captionLabel.implicitHeight : 0) + (text && caption ? spacing : 0)

  property int horizontalAlignment: Qt.AlignLeft
  property int verticalAlignment: Qt.AlignVCenter
  property int elide: Text.ElideRight
  property int wrapMode: Text.WordWrap
  property int maximumLineCount: 1
  property int spacing: 0

  Qaterial.Label
  {
    id: textLabel

    anchors
    {
      right: parent.right
      left: parent.left
    }

    y:
    {
      if(root.verticalAlignment === Qt.AlignVCenter)
        return Math.floor((root.height - root.implicitHeight) / 2)
      if(root.verticalAlignment === Qt.AlignBottom)
        return root.height - root.implicitHeight
      return 0
    }
    height: text ? implicitHeight : 0

    font: Qaterial.Style.textTheme.body1
    color: enabled ? root.textColor : Qaterial.Style.colorTheme.disabledText
    elide: root.elide
    horizontalAlignment: root.horizontalAlignment
  }

  Qaterial.Label
  {
    id: captionLabel

    anchors
    {
      right: parent.right
      left: parent.left
    }

    y: textLabel.y + textLabel.height + (textLabel.text ? root.spacing : 0)
    height: text ? implicitHeight : 0

    font: Qaterial.Style.textTheme.caption
    color: enabled ? root.captionColor : Qaterial.Style.colorTheme.disabledText
    elide: root.elide
    horizontalAlignment: root.horizontalAlignment
    wrapMode: root.wrapMode
    maximumLineCount: root.maximumLineCount
  }
}
