/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0 as Qaterial

T.ScrollBar
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding)

  padding: 0
  visible: _control.policy !== T.ScrollBar.AlwaysOff
  rightPadding: Qaterial.Style.scroll.padding
  leftPadding: Qaterial.Style.scroll.padding

  contentItem: Rectangle
  {
    implicitWidth: _control.interactive ? Qaterial.Style.scroll.implicitWidth : Qaterial.Style.scroll
      .implicitWidthInactive
    implicitHeight: _control.interactive ? Qaterial.Style.scroll.implicitWidth : Qaterial.Style.scroll
      .implicitWidthInactive
    radius: Qaterial.Style.scroll.radius

    color: _control.pressed ? Qaterial.Style.secondaryTextColor() : _control.interactive && _control.hovered ?
      Qaterial.Style.helperTextColor() : Qaterial.Style.dividersColor()
    opacity: 0.0
  } // Rectangle

  background: Rectangle
  {
    implicitWidth: _control.interactive ? Qaterial.Style.scroll.implicitWidthBackground : Qaterial.Style.scroll
      .implicitWidthInactive
    implicitHeight: _control.interactive ? Qaterial.Style.scroll.implicitWidthBackground : Qaterial.Style.scroll
      .implicitWidthInactive
    color: "#30000000"
    opacity: 0.0
    visible: _control.interactive
  } // Rectangle

  states: State
  {
    name: "active"
    when: _control.policy === T.ScrollBar.AlwaysOn || (_control.active && _control.size < 1.0)
  } // State

  transitions: [
    Transition
    {
      to: "active"
      NumberAnimation { targets: [contentItem, background];property: "opacity";to: 1.0 } // NumberAnimation
    }, // Transition

    Transition
    {
      from: "active"
      SequentialAnimation
      {
        PropertyAction { targets: [contentItem, background];property: "opacity";value: 1.0 } // PropertyAction
        PauseAnimation { duration: 2450 } // PauseAnimation
        NumberAnimation { targets: [contentItem, background];property: "opacity";to: 0 } // NumberAnimation
      } // SequentialAnimation
    } // Transition
  ] // transitions
} // ScrollBar
