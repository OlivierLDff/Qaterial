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
import QtQuick.Controls 2.12

import Qaterial 1.0 as Qaterial

Item
{
  id: root

  property Item control
  property int checkState: control.checkState

  property color accentColor: Qaterial.Style.colorTheme.accent
  property color indicatorColor: Qaterial.Style.colorTheme.primaryText
  property color borderColor: Qaterial.Style.colorTheme.disabledText
  property color disabledColor: Qaterial.Style.colorTheme.disabledText

  implicitWidth: backgroundRect.implicitWidth
  implicitHeight: backgroundRect.implicitHeight

  Rectangle
  {
    id: backgroundRect

    implicitWidth: Qaterial.Style.checkIndicator.implicitWidth
    implicitHeight: Qaterial.Style.checkIndicator.implicitHeight

    color: "transparent"
    border.color:
    {
      if(!root.control.enabled)
        return disabledColor

      return (root.checkState !== Qt.Unchecked) ? root.accentColor : root.borderColor
    }
    border.width: root.checkState !== Qt.Unchecked ? width / 2 : 2
    radius: Qaterial.Style.checkIndicator.radius

    Behavior on border.width
    {
      NumberAnimation
      {
        duration: 100
        easing.type: Easing.OutCubic
      } // NumberAnimation
    } // Behavior

    Behavior on border.color
    {
      ColorAnimation
      {
        duration: 100
        easing.type: Easing.OutCubic
      } // ColorAnimation
    } // Behavior

    Qaterial.Icon
    {
      id: checkImage

      anchors
      {
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
      }

      size: Qaterial.Style.checkIndicator.iconWidth
      icon: Qaterial.Icons.check
      color: root.indicatorColor

      scale: root.checkState === Qt.Checked ? 1 : 0
      Behavior on scale { NumberAnimation { duration: 100 } }
    } // Icon

    Rectangle
    {

      anchors
      {
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
      }

      width: Qaterial.Style.checkIndicator.partiallyCheckedWidth
      height: Qaterial.Style.checkIndicator.partiallyCheckedHeight
      color: root.indicatorColor

      scale: root.checkState === Qt.PartiallyChecked ? 1 : 0
      Behavior on scale { NumberAnimation { duration: 100 } }
    } // Rectangle

    states: [
      State
      {
        name: "checked"
        when: root.checkState === Qt.Checked
      }, // State
      State
      {
        name: "partiallychecked"
        when: root.checkState === Qt.PartiallyChecked
      } // State
    ] // states

    transitions: Transition
    {
      enabled: root._transitionSwitchEnabled
      SequentialAnimation
      {
        NumberAnimation
        {
          target: backgroundRect
          property: "scale"
          // Go down 2 pixels in size.
          to: 1 - 2 / backgroundRect.width
          duration: 120
        } // NumberAnimation
        NumberAnimation
        {
          target: backgroundRect
          property: "scale"
          to: 1
          duration: 120
        } // NumberAnimation
      } // SequentialAnimation
    } // Transition
  } // Rectangle

  // Make sure that animation on scale doesn't run during creating, but only when there is a change during lifetime
  property bool _transitionSwitchEnabled: false

  Component.onCompleted: () => _transitionSwitchEnabled = true
}
