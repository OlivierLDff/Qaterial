/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Templates as T

T.StackView
{
  id: root

  // From 0 to 1
  property real scaleRatio: 0.1
  property int duration: 200

  pushEnter: Transition
  {
    // slide_in_right
    NumberAnimation
    {
      property: "scale"
      from: 1 + root.scaleRatio
      to: 1
      duration: root.duration
      easing.type: Easing.OutCubic
    } // NumberANimation

    NumberAnimation
    {
      property: "opacity"
      from: 0.0
      to: 1.0
      duration: root.duration
      easing.type: Easing.OutCubic
    } // NumberANimation
  } // Transition

  pushExit: Transition
  {
    // slide_out_left
    NumberAnimation
    {
      property: "scale"
      from: 1
      to: 1 - root.scaleRatio
      duration: root.duration
      easing.type: Easing.OutCubic
    } // NumberANimation

    NumberAnimation
    {
      property: "opacity"
      from: 1.0
      to: 0.0
      duration: root.duration
      easing.type: Easing.OutCubic
    } // NumberANimation
  } // Transition

  popEnter: Transition
  {
    // slide_in_left
    NumberAnimation
    {
      property: "scale"
      from: 1 - root.scaleRatio
      to: 1
      duration: root.duration
      easing.type: Easing.OutCubic
    } // NumberANimation

    NumberAnimation
    {
      property: "opacity"
      from: 0.0
      to: 1.0
      duration: root.duration
      easing.type: Easing.OutCubic
    } // NumberANimation
  } // Transition

  popExit: Transition
  {
    // slide_out_right
    NumberAnimation
    {
      property: "scale"
      from: 1
      to: 1 + root.scaleRatio
      duration: root.duration
      easing.type: Easing.OutCubic
    } // NumberANimation

    NumberAnimation
    {
      property: "opacity"
      from: 1.0
      to: 0.0
      duration: root.duration
      easing.type: Easing.OutCubic
    } // NumberANimation
  } // Transition

  replaceEnter: Transition
  {
    // slide_in_right
    NumberAnimation
    {
      property: "scale"
      from: 1 + root.scaleRatio
      to: 1
      duration: root.duration
      easing.type: Easing.OutCubic
    } // NumberANimation

    NumberAnimation
    {
      property: "opacity"
      from: 0.0
      to: 1.0
      duration: root.duration
      easing.type: Easing.OutCubic
    } // NumberANimation
  } // Transition

  replaceExit: Transition
  {
    // slide_out_left
    NumberAnimation
    {
      property: "scale"
      from: 1
      to: 1 - root.scaleRatio
      duration: root.duration
      easing.type: Easing.OutCubic
    } // NumberANimation

    NumberAnimation
    {
      property: "opacity"
      from: 1.0
      to: 0.0
      duration: root.duration
      easing.type: Easing.OutCubic
    } // NumberANimation
  } // Transition
} // StackView
