/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0 as Qaterial

T.StackView
{
  id: _control

  popEnter: Transition
  {
    // slide_in_left
    NumberAnimation { property: "x";from: (_control.mirrored ? -0.5 : 0.5) * -_control
  .width;to: 0;duration: 200;easing.type: Easing.OutCubic } // NumberANimation
    NumberAnimation { property: "opacity";from: 0.0;to: 1.0;duration: 200;easing.type: Easing
      .OutCubic } // NumberANimation
  } // Transition

  popExit: Transition
  {
    // slide_out_right
    NumberAnimation { property: "x";from: 0;to: (_control.mirrored ? -0.5 : 0.5) * _control
    .width;duration: 200;easing.type: Easing.OutCubic } // NumberANimation
    NumberAnimation { property: "opacity";from: 1.0;to: 0.0;duration: 200;easing.type: Easing
      .OutCubic } // NumberANimation
  } // Transition

  pushEnter: Transition
  {
    // slide_in_right
    NumberAnimation { property: "x";from: (_control.mirrored ? -0.5 : 0.5) * _control
  .width;to: 0;duration: 200;easing.type: Easing.OutCubic } // NumberANimation
    NumberAnimation { property: "opacity";from: 0.0;to: 1.0;duration: 200;easing.type: Easing
      .OutCubic } // NumberANimation
  } // Transition

  pushExit: Transition
  {
    // slide_out_left
    NumberAnimation { property: "x";from: 0;to: (_control.mirrored ? -0.5 : 0.5) * -_control
    .width;duration: 200;easing.type: Easing.OutCubic } // NumberANimation
    NumberAnimation { property: "opacity";from: 1.0;to: 0.0;duration: 200;easing.type: Easing
      .OutCubic } // NumberANimation
  } // Transition

  replaceEnter: Transition
  {
    // slide_in_right
    NumberAnimation { property: "x";from: (_control.mirrored ? -0.5 : 0.5) * _control
  .width;to: 0;duration: 200;easing.type: Easing.OutCubic } // NumberANimation
    NumberAnimation { property: "opacity";from: 0.0;to: 1.0;duration: 200;easing.type: Easing
      .OutCubic } // NumberANimation
  } // Transition

  replaceExit: Transition
  {
    // slide_out_left
    NumberAnimation { property: "x";from: 0;to: (_control.mirrored ? -0.5 : 0.5) * -_control
    .width;duration: 200;easing.type: Easing.OutCubic } // NumberANimation
    NumberAnimation { property: "opacity";from: 1.0;to: 0.0;duration: 200;easing.type: Easing
      .OutCubic } // NumberANimation
  } // Transition
} // StackView
