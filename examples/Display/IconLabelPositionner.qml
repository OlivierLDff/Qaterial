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

  Qaterial.IconLabelPositionner
  {
    id: positionner

    display:
    {
      if(iconOnlyRadio.checked)
        return Qaterial.IconLabelPositionner.IconOnly
      if(textOnlyRadio.checked)
        return Qaterial.IconLabelPositionner.TextOnly
      if(textBesideIconRadio.checked)
        return Qaterial.IconLabelPositionner.TextBesideIcon
      if(textUnderIconRadio.checked)
        return Qaterial.IconLabelPositionner.TextUnderIcon
    }
    horizontalAlignment: Qt.AlignHCenter
    verticalAlignment: Qt.AlignVCenter
    spacing: 8
    mirrored: mirroredButton.checked
    //iconImplicitSize: Qt.size(iconSizeSlider.value, iconSizeSlider.value)
    //labelImplicitSize: Qt.size(labelWidthSlider.value, 20)
    iconImplicitSize: Qt.size(icon.implicitWidth, icon.implicitHeight)
    labelImplicitSize: Qt.size(label.implicitWidth, label.implicitHeight)
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

      width: positionner.containerSize.width
      height: positionner.containerSize.height

      Qaterial.DebugRectangle
      {
        id: implicitContainer

        x:
        {
          if(positionner.horizontalAlignment & Qt.AlignRight)
            return parent.width - width
          if(positionner.horizontalAlignment & Qt.AlignHCenter)
            return (parent.width - width)/2
          return 0
        }

        y:
        {
          if(positionner.verticalAlignment & Qt.AlignBottom)
            return parent.height - height
          if(positionner.verticalAlignment & Qt.AlignVCenter)
            return (parent.height - height)/2
          return 0
        }

        border.color: Qaterial.Colors.green

        width: positionner.implicitSize.width
        height: positionner.implicitSize.height
      }

      Qaterial.DebugRectangle
      {
        //id: icon

        border.color: Qaterial.Colors.orange

        x: positionner.iconRect.x
        y: positionner.iconRect.y

        width: positionner.iconRect.width
        height: positionner.iconRect.height

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

        x: positionner.labelRect.x
        y: positionner.labelRect.y

        width: positionner.labelRect.width
        height: positionner.labelRect.height

        Qaterial.Label
        {
          id: label
          text: "Icon Label"
          elide: Text.ElideRight
          anchors.fill: parent
        }
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

      Qaterial.Label
      {
        text: "Input"
        textType: Qaterial.Style.TextType.Title
      }

      Qaterial.Label
      {
        text: `display : ${positionner.display}\n` +
          `horizontalAlignment : ${positionner.horizontalAlignment}\n` +
          `verticalAlignment : ${positionner.verticalAlignment}\n` +
          `spacing : ${positionner.spacing}\n` +
          `mirrored : ${positionner.mirrored}\n` +
          `iconImplicitSize : ${positionner.iconImplicitSize}\n` +
          `labelImplicitSize : ${positionner.labelImplicitSize}\n` +
          `containerSize : ${positionner.containerSize}`
      }

      Qaterial.Label
      {
        text: "Output"
        textType: Qaterial.Style.TextType.Title
      }

      Qaterial.Label
      {
        text: `implicitSize : ${positionner.implicitSize}\n` +
          `iconRect : ${positionner.iconRect}\n` +
          `labelRect : ${positionner.labelRect}`
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
          Qaterial.Label
          {
            text: "Horizontal Align"
            textType: Qaterial.Style.TextType.Title
          }

          Row
          {
            Qaterial.ToolButton
            {
              icon.source: Qaterial.Icons.alignHorizontalLeft
              highlighted: positionner.horizontalAlignment === Qt.AlignLeft
              checkable: false

              onClicked: () => positionner.horizontalAlignment = Qt.AlignLeft
            }
            Qaterial.ToolButton
            {
              icon.source: Qaterial.Icons.alignHorizontalCenter
              highlighted: positionner.horizontalAlignment === Qt.AlignHCenter
              checkable: false

              onClicked: () => positionner.horizontalAlignment = Qt.AlignHCenter
            }
            Qaterial.ToolButton
            {
              icon.source: Qaterial.Icons.alignHorizontalRight
              highlighted: positionner.horizontalAlignment === Qt.AlignRight
              checkable: false

              onClicked: () => positionner.horizontalAlignment = Qt.AlignRight
            }
          }
        }

        Column
        {
          Qaterial.Label
          {
            text: "Vertical Align"
            textType: Qaterial.Style.TextType.Title
          }

          Row
          {
            Qaterial.ToolButton
            {
              icon.source: Qaterial.Icons.alignVerticalTop
              highlighted: positionner.verticalAlignment === Qt.AlignTop
              checkable: false

              onClicked: () => positionner.verticalAlignment = Qt.AlignTop
            }
            Qaterial.ToolButton
            {
              icon.source: Qaterial.Icons.alignVerticalCenter
              highlighted: positionner.verticalAlignment === Qt.AlignVCenter
              checkable: false

              onClicked: () => positionner.verticalAlignment = Qt.AlignVCenter
            }
            Qaterial.ToolButton
            {
              icon.source: Qaterial.Icons.alignVerticalBottom
              highlighted: positionner.verticalAlignment === Qt.AlignBottom
              checkable: false

              onClicked: () => positionner.verticalAlignment = Qt.AlignBottom
            }
          }
        }
      } // Row

      Qaterial.Label
      {
        text: "Layout"
        textType: Qaterial.Style.TextType.Title
      }

      Qaterial.SwitchButton
      {
        id: mirroredButton

        text: "mirrored"
        checked: false
      }

      Qaterial.Label
      {
        text: "Display"
        textType: Qaterial.Style.TextType.Title
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
      Qaterial.Label
      {
        text: "Size"
        textType: Qaterial.Style.TextType.Title
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
