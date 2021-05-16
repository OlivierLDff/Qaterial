// Copyright 2021 Olivier Le Doeuff
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Qaterial.IconLabelImpl
{
  id: root

  property string text
  property font textFont: Qaterial.Style.textTheme.body1
  property color textColor: Qaterial.Style.colorTheme.primaryText

  property string caption
  property font captionFont: Qaterial.Style.textTheme.caption
  property color captionColor: Qaterial.Style.colorTheme.secondaryText

  property int wrapMode: Text.WordWrap
  property int maximumLineCount: 1

  icon.color: Qaterial.Style.colorTheme.primaryText
  icon.width: Qaterial.Style.largeIcon
  icon.height: Qaterial.Style.largeIcon

  spacing: Qaterial.Style.smallSpacing

  display: Qaterial.IconLabel.TextBesideIcon

  horizontalAlignment: mirrored ? Qt.AlignRight : Qt.AlignLeft

  iconItem: Qaterial.Icon
  {
    icon: root.icon.source
    width: root.icon.width
    height: root.icon.height
    color: root.icon.color
  }

  labelItem: Qaterial.LabelWithCaption
  {
    text: root.text
    textFont: root.textFont
    textColor: root.textColor

    caption: root.caption
    captionFont: root.captionFont
    captionColor: root.captionColor

    horizontalAlignment:
    {
      if(root.mirrored)
      {
        if(root.horizontalAlignment === Qt.AlignLeft)
          return Qt.AlignRight
        else if(root.horizontalAlignment === Qt.AlignRight)
          return Qt.AlignLeft
        return Qt.AlignHCenter
      }
      else
      {
        return root.horizontalAlignment
      }
    }
    elide: root.mirrored ? Text.ElideLeft : Text.ElideRight
    maximumLineCount: root.maximumLineCount
  }
}
