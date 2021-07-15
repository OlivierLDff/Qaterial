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
  spacing: 8

  Qaterial.IconLabelPositioner
  {
    id: positioner

    display:
    {
      if(iconOnlyRadio.checked)
        return Qaterial.IconLabelPositioner.IconOnly
      if(textOnlyRadio.checked)
        return Qaterial.IconLabelPositioner.TextOnly
      if(textBesideIconRadio.checked)
        return Qaterial.IconLabelPositioner.TextBesideIcon
      if(textUnderIconRadio.checked)
        return Qaterial.IconLabelPositioner.TextUnderIcon
    }
    horizontalAlignment: Qt.AlignHCenter
    verticalAlignment: Qt.AlignVCenter
    spacing: 8
    mirrored: mirroredButton.checked
    iconImplicitSize: Qt.size(iconSizeSlider.value, iconSizeSlider.value)
    labelImplicitSize: Qt.size(labelWidthSlider.value, 20)
    containerSize: Qt.size(containerWidthSlider.value, 100)
  }

  Item
  {
    anchors.horizontalCenter: parent.horizontalCenter

    width: 300
    height: 100

    Qaterial.DebugRectangle
    {
      id: container

      anchors.centerIn: parent

      width: positioner.containerSize.width
      height: positioner.containerSize.height

      Qaterial.DebugRectangle
      {
        id: implicitContainer

        x:
        {
          if(positioner.horizontalAlignment & Qt.AlignRight)
            return parent.width - width
          if(positioner.horizontalAlignment & Qt.AlignHCenter)
            return (parent.width - width) / 2
          return 0
        }

        y:
        {
          if(positioner.verticalAlignment & Qt.AlignBottom)
            return parent.height - height
          if(positioner.verticalAlignment & Qt.AlignVCenter)
            return (parent.height - height) / 2
          return 0
        }

        border.color: Qaterial.Colors.green

        width: positioner.implicitSize.width
        height: positioner.implicitSize.height
      }

      Qaterial.DebugRectangle
      {
        //id: icon

        border.color: Qaterial.Colors.orange

        x: positioner.iconRect.x
        y: positioner.iconRect.y

        width: positioner.iconRect.width
        height: positioner.iconRect.height

        Qaterial.Icon
        {
          id: icon
          size: iconSizeSlider.value
          icon: Qaterial.Icons.accountBoxMultipleOutline
          anchors.fill: parent
        }
      }

      Qaterial.DebugRectangle
      {
        //id: label

        border.color: Qaterial.Colors.blue

        x: positioner.labelRect.x
        y: positioner.labelRect.y

        width: positioner.labelRect.width
        height: positioner.labelRect.height
      }
    }
  }

  Qaterial.HorizontalLineSeparator
  {
    width: parent.width
  }

  Row
  {
    spacing: 16

    Column
    {
      spacing: 8
      width: 220

      Qaterial.LabelHeadline6
      {
        text: "Input"
      }

      Qaterial.Label
      {
        text: `display : ${positioner.display}\n` +
          `horizontalAlignment : ${positioner.horizontalAlignment}\n` +
          `verticalAlignment : ${positioner.verticalAlignment}\n` +
          `spacing : ${positioner.spacing}\n` +
          `mirrored : ${positioner.mirrored}\n` +
          `iconImplicitSize : ${positioner.iconImplicitSize}\n` +
          `labelImplicitSize : ${positioner.labelImplicitSize}\n` +
          `containerSize : ${positioner.containerSize}`
      }

      Qaterial.LabelHeadline6
      {
        text: "Output"
      }

      Qaterial.Label
      {
        text: `implicitSize : ${positioner.implicitSize}\n` +
          `iconRect : ${positioner.iconRect}\n` +
          `labelRect : ${positioner.labelRect}`
      }
    }

    Qaterial.VerticalLineSeparator
    {
      height: parent.height
    }

    Column
    {
      spacing: 0

      Row
      {
        spacing: 32
        Column
        {
          Qaterial.LabelHeadline6
          {
            text: "Horizontal Align"
          }

          Row
          {
            Qaterial.ToolButton
            {
              icon.source: Qaterial.Icons.alignHorizontalLeft
              highlighted: positioner.horizontalAlignment === Qt.AlignLeft
              checkable: false

              onClicked: () => positioner.horizontalAlignment = Qt.AlignLeft
            }
            Qaterial.ToolButton
            {
              icon.source: Qaterial.Icons.alignHorizontalCenter
              highlighted: positioner.horizontalAlignment === Qt.AlignHCenter
              checkable: false

              onClicked: () => positioner.horizontalAlignment = Qt.AlignHCenter
            }
            Qaterial.ToolButton
            {
              icon.source: Qaterial.Icons.alignHorizontalRight
              highlighted: positioner.horizontalAlignment === Qt.AlignRight
              checkable: false

              onClicked: () => positioner.horizontalAlignment = Qt.AlignRight
            }
          }
        }

        Column
        {
          Qaterial.LabelHeadline6
          {
            text: "Vertical Align"
          }

          Row
          {
            Qaterial.ToolButton
            {
              icon.source: Qaterial.Icons.alignVerticalTop
              highlighted: positioner.verticalAlignment === Qt.AlignTop
              checkable: false

              onClicked: () => positioner.verticalAlignment = Qt.AlignTop
            }
            Qaterial.ToolButton
            {
              icon.source: Qaterial.Icons.alignVerticalCenter
              highlighted: positioner.verticalAlignment === Qt.AlignVCenter
              checkable: false

              onClicked: () => positioner.verticalAlignment = Qt.AlignVCenter
            }
            Qaterial.ToolButton
            {
              icon.source: Qaterial.Icons.alignVerticalBottom
              highlighted: positioner.verticalAlignment === Qt.AlignBottom
              checkable: false

              onClicked: () => positioner.verticalAlignment = Qt.AlignBottom
            }
          }
        }
      } // Row

      Qaterial.LabelHeadline6
      {
        text: "Layout"
      }

      Qaterial.SwitchButton
      {
        id: mirroredButton

        text: "mirrored"
        checked: false
      }

      Qaterial.LabelHeadline6
      {
        text: "Display"
      }

      Grid
      {
        columns: 2

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

    Qaterial.VerticalLineSeparator
    {
      height: parent.height
    }

    Column
    {
      Qaterial.LabelHeadline6
      {
        text: "Size"
      }

      Qaterial.Slider
      {
        id: containerWidthSlider
        backgroundImplicitHeight: 24
        color: Qaterial.Colors.pink
        from: 10
        to: 300
        value: 200
        stepSize: 1
      }

      Qaterial.Slider
      {
        id: iconSizeSlider
        backgroundImplicitHeight: 24
        color: Qaterial.Colors.orange
        from: 10
        to: 50
        value: 24
        stepSize: 1
      }

      Qaterial.Slider
      {
        id: labelWidthSlider
        backgroundImplicitHeight: 24
        color: Qaterial.Colors.blue
        from: 10
        to: 300
        value: 100
        stepSize: 1
      }
    }
  }
}
