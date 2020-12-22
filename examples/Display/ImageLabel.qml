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
import Qaterial 1.0 as Qaterial

Row
{
  id: root

  spacing: 16

  property int display:
  {
    if(iconOnlyRadio.checked)
      return Qaterial.ImageLabel.IconOnly
    if(textOnlyRadio.checked)
      return Qaterial.ImageLabel.TextOnly
    if(textBesideIconRadio.checked)
      return Qaterial.ImageLabel.TextBesideIcon
    if(textUnderIconRadio.checked)
      return Qaterial.ImageLabel.TextUnderIcon
  }

  Column
  {
    spacing: 8

    Qaterial.LabelHeadline6
    {
      text: "ImageLabel"
    }

    Qaterial.ImageLabel
    {
      icon.source: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Qt_logo_2016.svg/langfr-1280px-Qt_logo_2016.svg.png"
      icon.width: 32
      icon.height: 32

      text: "Image Label"
      mirrored: mirroredButton.checked
      display: root.display
    }

    Qaterial.ImageLabel
    {
      icon.source: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Qt_logo_2016.svg/langfr-1280px-Qt_logo_2016.svg.png"
      icon.width: 32
      icon.height: 32

      text: "Rounded Image Label"
      radius: 16
      fillMode: Image.PreserveAspectCrop
      mirrored: mirroredButton.checked
      display: root.display
    }

    Qaterial.ImageLabel
    {
      icon.source: "https://www.flaticon.com/svg/static/icons/svg/119/119574.svg"
      icon.width: 48
      icon.height: 48

      text: "Multi Line\n" +
        "Image Label"
      mirrored: mirroredButton.checked
      display: root.display
    }

    Qaterial.ImageLabel
    {
      icon.source: "https://www.flaticon.com/svg/static/icons/svg/119/119575.svg"
      icon.width: 48
      icon.height: 48

      width: 200

      text: "Some long text being elided"
      mirrored: mirroredButton.checked
      display: root.display
    }

    Qaterial.ImageLabel
    {
      icon.source: "https://www.flaticon.com/svg/static/icons/svg/119/119597.svg"
      icon.width: 48
      icon.height: 48

      width: 200

      text: "Some long text being wrapped on the next line. Whaou this text is very long."
      wrapMode: Text.WordWrap

      mirrored: mirroredButton.checked
      display: root.display
    }

    Qaterial.ImageLabel
    {
      icon.source: "https://www.flaticon.com/svg/static/icons/svg/119/119592.svg"
      icon.width: 48
      icon.height: 48

      width: 200

      text: "Some long text being wrapped on 2 lines that should be elided"
      wrapMode: Text.WordWrap
      maximumLineCount: 2
      mirrored: mirroredButton.checked
      display: root.display
    }
  }

  Qaterial.VerticalLineSeparator
  {
    anchors.top: parent.top
    anchors.bottom: parent.bottom
  }

  Column
  {
    spacing: 8

    Qaterial.LabelHeadline6
    {
      text: "Controls"
    }

    Qaterial.SwitchButton
    {
      id: mirroredButton

      text: "mirrored"
      checked: false
    }

    Column
    {
      Qaterial.RadioButton
      {
        id: iconOnlyRadio
        text: "IconOnly"
      }
      Qaterial.RadioButton
      {
        id: textOnlyRadio
        text: "TextOnly"
      }
      Qaterial.RadioButton
      {
        id: textBesideIconRadio
        text: "TextBesideIcon"
        checked: true
      }
      Qaterial.RadioButton
      {
        id: textUnderIconRadio
        text: "TextUnderIcon"
      }
    }
  }
}
