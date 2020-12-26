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
import QtQuick.Controls 2.12 as QQC2
import Qaterial 1.0 as Qaterial

Column
{
  id: root

  spacing: 8

  property int display:
  {
    if(iconOnlyRadio.checked)
      return QQC2.AbstractButton.IconOnly
    if(textOnlyRadio.checked)
      return QQC2.AbstractButton.TextOnly
    if(textBesideIconRadio.checked)
      return QQC2.AbstractButton.TextBesideIcon
    if(textUnderIconRadio.checked)
      return QQC2.AbstractButton.TextUnderIcon
  }

  Row
  {
    id: customizationRow

    spacing: 8

    Qaterial.GroupBox
    {
      title: "Icon Label"

      width: 200
      height: customizationBox.height

      Column
      {
        anchors.centerIn: parent
        width: parent.width

        spacing: 16

        Qaterial.IconLabel
        {
          id: iconLabel

          mirrored: mirroredButton.checked

          enabled: enabledButton.checked
          text: textField.text
          icon.source: Qaterial.Icons.rocketLaunchOutline

          icon.width: iconSizeSlider.value
          icon.height: iconSizeSlider.value

          spacing: spacingSlider.value
          display: root.display

          Qaterial.DebugRectangle
          {
            anchors.fill: parent
          }
        }

        Qaterial.IconLabel
        {
          mirrored: mirroredButton.checked

          enabled: enabledButton.checked
          text: textField.text
          icon.source: Qaterial.Icons.rocketLaunchOutline

          icon.width: iconSizeSlider.value
          icon.height: iconSizeSlider.value

          width: Math.min(100, implicitWidth)

          spacing: spacingSlider.value
          display: root.display

          Qaterial.DebugRectangle
          {
            anchors.fill: parent
          }
        }

        Qaterial.IconLabel
        {
          id: imageLabel

          mirrored: mirroredButton.checked

          enabled: enabledButton.checked
          text: "Custom Image"

          icon.width: iconSizeSlider.value
          icon.height: iconSizeSlider.value
          icon.source: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Qt_logo_2016.svg/langfr-1280px-Qt_logo_2016.svg.png"

          iconItem: Qaterial.ClipRRect
          {
            id: clipper

            radius: 0

            Image
            {
              source: imageLabel.icon.source
              fillMode: Image.PreserveAspectFit
              anchors.centerIn: parent

              width: parent.width
              height: parent.height
            }
          }

          spacing: spacingSlider.value
          display: root.display

          Qaterial.DebugRectangle
          {
            anchors.fill: parent
          }
        }

        Qaterial.IconLabel
        {
          id: customLabel

          mirrored: mirroredButton.checked

          enabled: enabledButton.checked
          text: "Custom Label"

          icon.width: iconSizeSlider.value
          icon.height: iconSizeSlider.value

          labelItem: Qaterial.LabelOverline
          {
            text: customLabel.text
            Qaterial.DebugRectangle
            {
              anchors.fill: parent
              border.color: Qaterial.Colors.green
            }
          }

          spacing: spacingSlider.value
          display: root.display

          Qaterial.DebugRectangle
          {
            anchors.fill: parent
          }
        }
      }
    }

    Qaterial.GroupBox
    {
      id: customizationBox
      title: "Customization"

      Row
      {
        Column
        {
          Qaterial.SwitchButton
          {
            id: enabledButton

            text: "enabled"
            checked: true
          }

          Qaterial.SwitchButton
          {
            id: mirroredButton

            text: "mirrored"
            checked: false
          }

          Qaterial.Frame
          {
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

        Column
        {
          Qaterial.TextField
          {
            id: textField
            text: `Icon Label`
            maximumLengthCount: 32
          }

          Qaterial.LabelBody2 { text: "Spacing" }

          Qaterial.Slider
          {
            id: spacingSlider
            from: 0
            to: 16
            stepSize: 1
            value: 8
          }

          Qaterial.LabelBody2 { text: "icon size" }

          Qaterial.Slider
          {
            id: iconSizeSlider
            from: 0
            to: 64
            stepSize: 1
            value: 24
          }
        }
      }

    }
  }

  Qaterial.GroupBox
  {
    width: customizationRow.width
    title: "Showcase Implicit Size"

    Column
    {
      anchors.horizontalCenter: parent.horizontalCenter
      Row
      {
        spacing: 8
        Qaterial.IconLabel
        {
          anchors.verticalCenter: parent.verticalCenter
          mirrored: false

          text: `IconOnly`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.IconOnly

          Qaterial.DebugRectangle { anchors.fill: parent }
        }

        Qaterial.IconLabel
        {
          anchors.verticalCenter: parent.verticalCenter
          mirrored: false

          text: `TextOnly`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.TextOnly

          Qaterial.DebugRectangle { anchors.fill: parent }
        }

        Qaterial.IconLabel
        {
          anchors.verticalCenter: parent.verticalCenter
          mirrored: false

          text: `TextBesideIcon`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.TextBesideIcon

          Qaterial.DebugRectangle { anchors.fill: parent }
        }

        Qaterial.IconLabel
        {
          anchors.verticalCenter: parent.verticalCenter
          mirrored: false

          text: `TextUnderIcon`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.TextUnderIcon

          Qaterial.DebugRectangle { anchors.fill: parent }
        }
      }

      Row
      {
        spacing: 8
        Qaterial.IconLabel
        {
          anchors.verticalCenter: parent.verticalCenter
          mirrored: true

          text: `IconOnly`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.IconOnly

          Qaterial.DebugRectangle { anchors.fill: parent }
        }

        Qaterial.IconLabel
        {
          anchors.verticalCenter: parent.verticalCenter
          mirrored: true

          text: `TextOnly`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.TextOnly

          Qaterial.DebugRectangle { anchors.fill: parent }
        }

        Qaterial.IconLabel
        {
          anchors.verticalCenter: parent.verticalCenter
          mirrored: true

          text: `TextBesideIcon`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.TextBesideIcon

          Qaterial.DebugRectangle { anchors.fill: parent }
        }

        Qaterial.IconLabel
        {
          anchors.verticalCenter: parent.verticalCenter
          mirrored: true

          text: `TextUnderIcon`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.TextUnderIcon

          Qaterial.DebugRectangle { anchors.fill: parent }
        }
      }

    }
  }
  Qaterial.GroupBox
  {
    width: customizationRow.width
    title: "Showcase Explicit Size"

    Column
    {
      anchors.horizontalCenter: parent.horizontalCenter

      Qaterial.Slider
      {
        id: widthSlider

        anchors.horizontalCenter: parent.horizontalCenter

        from: 10
        to: 150
        value: 100
      }

      Row
      {
        anchors.horizontalCenter: parent.horizontalCenter

        spacing: 8
        Qaterial.IconLabel
        {
          width: widthSlider.value
          anchors.verticalCenter: parent.verticalCenter
          mirrored: false

          text: `IconOnly`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.IconOnly

          Qaterial.DebugRectangle { anchors.fill: parent }
        }

        Qaterial.IconLabel
        {
          width: widthSlider.value
          anchors.verticalCenter: parent.verticalCenter
          mirrored: false

          text: `TextOnly`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.TextOnly

          Qaterial.DebugRectangle { anchors.fill: parent }
        }

        Qaterial.IconLabel
        {
          width: widthSlider.value
          anchors.verticalCenter: parent.verticalCenter
          mirrored: false

          text: `TextBesideIcon`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.TextBesideIcon

          Qaterial.DebugRectangle { anchors.fill: parent }
        }

        Qaterial.IconLabel
        {
          width: widthSlider.value
          anchors.verticalCenter: parent.verticalCenter
          mirrored: false

          text: `TextUnderIcon`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.TextUnderIcon

          Qaterial.DebugRectangle { anchors.fill: parent }
        }
      }

      Row
      {
        anchors.horizontalCenter: parent.horizontalCenter

        spacing: 8
        Qaterial.IconLabel
        {
          width: widthSlider.value
          anchors.verticalCenter: parent.verticalCenter
          mirrored: true

          text: `IconOnly`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.IconOnly

          Qaterial.DebugRectangle { anchors.fill: parent }
        }

        Qaterial.IconLabel
        {
          width: widthSlider.value
          anchors.verticalCenter: parent.verticalCenter
          mirrored: true

          text: `TextOnly`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.TextOnly

          Qaterial.DebugRectangle { anchors.fill: parent }
        }

        Qaterial.IconLabel
        {
          width: widthSlider.value
          anchors.verticalCenter: parent.verticalCenter
          mirrored: true

          text: `TextBesideIcon`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.TextBesideIcon

          Qaterial.DebugRectangle { anchors.fill: parent }
        }

        Qaterial.IconLabel
        {
          width: widthSlider.value
          anchors.verticalCenter: parent.verticalCenter
          mirrored: true

          text: `TextUnderIcon`
          icon.source: Qaterial.Icons.rocketLaunchOutline
          display: QQC2.AbstractButton.TextUnderIcon

          Qaterial.DebugRectangle { anchors.fill: parent }
        }
      }

    }
  }
}
