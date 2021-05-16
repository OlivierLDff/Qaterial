// Copyright 2021 Olivier Le Doeuff
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qaterial 1.0 as Qaterial

ColumnLayout
{
  id: root

  width: 200
  spacing: Qaterial.Style.smallSpacing

  property real iconSize:
  {
    if(smallIconSizeBtn.checked)
      return Qaterial.Style.smallIcon
    if(mediumIconSizeBtn.checked)
      return Qaterial.Style.mediumIcon
    if(largeIconSizeBtn.checked)
      return Qaterial.Style.largeIcon
  }

  Qaterial.Card
  {
    Layout.fillWidth: true
    horizontalPadding: Qaterial.Style.largeSpacing

    ColumnLayout
    {
      spacing: 0

      Qaterial.SwitchButton
      {
        id: enabledSw
        text: "Enabled"
        checked: true
      }

      Qaterial.SwitchButton
      {
        id: mirroredSw
        text: "Mirrored"
        checked: false
      }

      RowLayout
      {
        Layout.alignment: Qt.AlignHCenter
        spacing: 0

        ButtonGroup
        {
          buttons: [smallIconSizeBtn, mediumIconSizeBtn, largeIconSizeBtn]
        }

        Qaterial.SquareButton
        {
          id: smallIconSizeBtn
          icon.source: Qaterial.Icons.sizeS
          checkable: true
        }
        Qaterial.SquareButton
        {
          id: mediumIconSizeBtn
          icon.source: Qaterial.Icons.sizeM
          checkable: true
        }
        Qaterial.SquareButton
        {
          id: largeIconSizeBtn
          icon.source: Qaterial.Icons.sizeL
          checkable: true
          checked: true
        }
      }
    }
  }

  Qaterial.Card
  {
    Layout.fillWidth: true
    padding: Qaterial.Style.largeSpacing

    LayoutMirroring.enabled: mirroredSw.checked
    LayoutMirroring.childrenInherit: true

    ColumnLayout
    {
      anchors
      {
        left: parent.left
        right: parent.right
      }

      Qaterial.IconLabelWithCaption
      {
        Layout.fillWidth: true
        mirrored: mirroredSw.checked

        enabled: enabledSw.checked
        icon.source: "https://www.flaticon.com/svg/static/icons/svg/119/119591.svg"
        icon.color: "transparent"
        icon.width: root.iconSize
        icon.height: root.iconSize

        text: "Title"
        caption: "Caption"
      }

      Qaterial.IconLabelWithCaption
      {
        Layout.fillWidth: true
        mirrored: mirroredSw.checked

        enabled: enabledSw.checked
        icon.source: "https://www.flaticon.com/svg/static/icons/svg/119/119592.svg"
        icon.color: "transparent"
        icon.width: root.iconSize
        icon.height: root.iconSize

        text: "Very long title elide"
        caption: "Caption"
      }

      Qaterial.IconLabelWithCaption
      {
        Layout.fillWidth: true
        mirrored: mirroredSw.checked

        enabled: enabledSw.checked
        icon.source: "https://www.flaticon.com/svg/static/icons/svg/119/119593.svg"
        icon.color: "transparent"
        icon.width: root.iconSize
        icon.height: root.iconSize

        text: "Very Long Title"
        caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras facilisis lacus a quam tincidunt euismod. Quisque viverra magna mattis, laoreet magna non, sodales nulla."

        maximumLineCount: 2
      }

      RowLayout
      {
        Layout.alignment: Qt.AlignHCenter
        spacing: 0

        ButtonGroup
        {
          buttons: [alignTop, alignHCenter, alignBottom]
        }

        Qaterial.SquareButton
        {
          id: alignTop
          icon.source: Qaterial.Icons.alignVerticalTop
          checkable: true
        }
        Qaterial.SquareButton
        {
          id: alignHCenter
          icon.source: Qaterial.Icons.alignVerticalCenter
          checked: true
          checkable: true
        }
        Qaterial.SquareButton
        {
          id: alignBottom
          icon.source: Qaterial.Icons.alignVerticalBottom
          checkable: true
        }
      }

      Qaterial.IconLabelWithCaption
      {
        Layout.fillWidth: true
        Layout.preferredHeight: 80

        mirrored: mirroredSw.checked

        verticalAlignment:
        {
          if(alignTop.checked)
            return Qt.AlignTop
          if(alignHCenter.checked)
            return Qt.AlignVCenter
          if(alignBottom.checked)
            return Qt.AlignBottom
          return false
        }

        enabled: enabledSw.checked
        icon.source: Qaterial.Icons.rocketLaunchOutline
        icon.color: Qaterial.Colors.pink300
        icon.width: root.iconSize
        icon.height: root.iconSize

        text:
        {
          if(alignTop.checked)
            return "AlignTop"
          if(alignHCenter.checked)
            return "AlignVCenter"
          if(alignBottom.checked)
            return "AlignBottom"
        }
        caption: "verticalAlignment"

        Qaterial.DebugRectangle { anchors.fill: parent }
      }
    }
  }

  Qaterial.Card
  {
    Layout.fillWidth: true
    horizontalPadding: Qaterial.Style.largeSpacing
    bottomPadding: Qaterial.Style.smallSpacing

    ColumnLayout
    {
      anchors
      {
        left: parent.left
        right: parent.right
      }

      spacing: 0

      RowLayout
      {
        Layout.alignment: Qt.AlignHCenter
        Qaterial.SquareButton
        {
          id: showIcon
          icon.source: Qaterial.Icons.textureBox
          checkable: true
          checked: true
        }

        Qaterial.SquareButton
        {
          id: showText
          icon.source: Qaterial.Icons.textShort
          checkable: true
          checked: true
        }

        Qaterial.SquareButton
        {
          id: showCaption
          icon.source: Qaterial.Icons.textSubject
          checkable: true
          checked: true
        }

      }

      Qaterial.IconLabelWithCaption
      {
        LayoutMirroring.enabled: mirroredSw.checked
        LayoutMirroring.childrenInherit: true

        Layout.fillWidth: true
        mirrored: mirroredSw.checked

        enabled: enabledSw.checked
        icon.source: showIcon.checked ? "https://www.flaticon.com/svg/static/icons/svg/119/119593.svg" : ""
        icon.color: "transparent"
        icon.width: root.iconSize
        icon.height: root.iconSize

        text: showText.checked ? "Very Long Title" : ""
        caption: showCaption.checked ? "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras facilisis lacus a quam tincidunt euismod." : ""

        maximumLineCount: 2
      }
    }
  }
}
