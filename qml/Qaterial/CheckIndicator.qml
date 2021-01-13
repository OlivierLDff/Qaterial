/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Rectangle
{
  id: _indicatorItem
  implicitWidth: Qaterial.Style.checkIndicator.implicitWidth
  implicitHeight: Qaterial.Style.checkIndicator.implicitHeight
  color: "transparent"
  border.color:
  {
    if(!control.enabled)
      return Qaterial.Style.hintTextColor()
    return (checkState !== Qt.Unchecked) ? Qaterial.Style.accentColor : Qaterial.Style.secondaryTextColor()
  }
  // border.color: !control.enabled ? Qaterial.Style.hintTextColor()
  //     : checkState !== Qt.Unchecked ? Qaterial.Style.accentColor : Qaterial.Style.secondaryTextColor()
  border.width: checkState !== Qt.Unchecked ? width / 2 : 2
  radius: Qaterial.Style.checkIndicator.radius

  property Item control
  property int checkState: control.checkState

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

  Qaterial.ColorIcon
  {
    id: checkImage
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    iconSize: Qaterial.Style.checkIndicator.iconWidth
    source: Qaterial.Icons.check
    color: "white"

    scale: checkState === Qt.Checked ? 1 : 0
    Behavior on scale { NumberAnimation { duration: 100 } }
  } // ColorIcon

  Rectangle
  {
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: Qaterial.Style.checkIndicator.partiallyCheckedWidth
    height: Qaterial.Style.checkIndicator.partiallyCheckedHeight
    color: "white"

    scale: checkState === Qt.PartiallyChecked ? 1 : 0
    Behavior on scale { NumberAnimation { duration: 100 } }
  } // Rectangle

  states: [
    State
    {
      name: "checked"
      when: checkState === Qt.Checked
    }, // State
    State
    {
      name: "partiallychecked"
      when: checkState === Qt.PartiallyChecked
    } // State
  ] // states

  transitions: Transition
  {
    SequentialAnimation
    {
      NumberAnimation
      {
        target: _indicatorItem
        property: "scale"
        // Go down 2 pixels in size.
        to: 1 - 2 / _indicatorItem.width
        duration: 120
      } // NumberAnimation
      NumberAnimation
      {
        target: _indicatorItem
        property: "scale"
        to: 1
        duration: 120
      } // NumberAnimation
    } // SequentialAnimation
  } // Transition
} // Rectangle
