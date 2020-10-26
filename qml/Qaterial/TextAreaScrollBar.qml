/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.ScrollBar
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding)

  padding: 2
  policy: ScrollBar.AlwaysOn

  background: Rectangle
  {
    implicitWidth: _control.interactive ? Qaterial.Style.scroll.implicitWidthBackground : Qaterial.Style.scroll
      .implicitWidthInactive
    implicitHeight: _control.interactive ? Qaterial.Style.scroll.implicitWidthBackground : Qaterial.Style.scroll
      .implicitWidthInactive
    color: "transparent"
  } // Rectangle

  contentItem: Rectangle
  {
    implicitWidth: 4
    implicitHeight: 4
    radius: 2

    color: Qaterial.Style.hintTextColor()
    visible: _control.size < 1.0
    opacity: 0.5

    states: State
    {
      name: "active"
      when: _control.active
      PropertyChanges { target: _control.contentItem;opacity: 0.75 }
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
          PropertyAction { targets: [contentItem, background];property: "opacity";value: 1.0 } // NumberAnimation
          PauseAnimation { duration: 2450 } // PauseAnimation
          NumberAnimation { targets: [contentItem, background];property: "opacity";to: 0.5 } // NumberAnimation
        }
      } // Transition
    ] // transitions
  } // Rectangle
} // ScrollBar
