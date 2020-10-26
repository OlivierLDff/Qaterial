/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0 as Qaterial

T.ScrollIndicator
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding)

  padding: 2

  contentItem: Rectangle
  {
    implicitWidth: 4
    implicitHeight: 4
    radius: 2

    color: Qaterial.Style.hintTextColor()
    visible: _control.size < 1.0
    opacity: 0.0

    states: State
    {
      name: "active"
      when: _control.active
      PropertyChanges { target: _control.contentItem;opacity: 0.75 }
    } // State

    transitions: [
      Transition
      {
        from: "active"
        SequentialAnimation
        {
          PauseAnimation { duration: 450 } // PauseAnimation
          NumberAnimation { target: _control
      .contentItem;duration: 200;property: "opacity";to: 0.0 } // NumberAnimation
        } // SequentialAnimation
      } // Transition
    ] // transitions
  } // Rectangle
} // ScrollIndicator
