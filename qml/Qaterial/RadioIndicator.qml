/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0 as Qaterial

Rectangle
{
  implicitWidth: Qaterial.Style.radioIndicator.implicitWidth
  implicitHeight: Qaterial.Style.radioIndicator.implicitHeight
  radius: width / 2
  border.width: 2
  border.color: !control.enabled ? Qaterial.Style.hintTextColor() :
    control.checked || control.down ? Qaterial.Style.accentColor : Qaterial.Style.secondaryTextColor()
  color: "transparent"

  Behavior on border.color
  {
    ColorAnimation
    {
      duration: 100
      easing.type: Easing.OutCubic
    } // ColorAnimation
  } // Behavior

  property Item control

  Rectangle
  {
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    readonly property bool shouldBeVisible: control.checked || control.down
    width: shouldBeVisible ? Qaterial.Style.radioIndicator.implicitWidth / 2 : 0
    height: shouldBeVisible ? Qaterial.Style.radioIndicator.implicitHeight / 2 : 0
    radius: width / 2
    color: parent.border.color
    //visible: control.checked || control.down

    Behavior on width
    {
      NumberAnimation
      {
        duration: 100
        easing.type: Easing.OutCubic
      } // NumberAnimation
    } // Behavior

    Behavior on height
    {
      NumberAnimation
      {
        duration: 100
        easing.type: Easing.OutCubic
      } // NumberAnimation
    } // Behavior
  } // Rectangle
} // Rectangle
