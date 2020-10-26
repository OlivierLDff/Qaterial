/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12

import Qaterial 1.0 as Qaterial

T.ComboBox
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding,
    implicitIndicatorHeight + topPadding + bottomPadding)

  topInset: 6
  bottomInset: 6

  leftPadding: padding + (!_control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)
  rightPadding: padding + (_control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)

  property double elevation: flat ? _control.pressed || _control.hovered ? 2 : 0 : _control.pressed ? 8 : 2
  Material.background: flat ? "transparent" : undefined
  property color foregroundColor: flat ? undefined : Material.primaryTextColor

  delegate: MenuItem
  {
    width: parent.width
    text: _control.textRole ? (Array.isArray(_control.model) ? modelData[_control.textRole] : model[_control
      .textRole]) : modelData
    Material.foreground: _control.currentIndex === index ? parent.Material.accent : parent.Material.foreground
    highlighted: _control.highlightedIndex === index
    hoverEnabled: _control.hoverEnabled
  } // MenuItem

  indicator: ColorImage
  {
    x: _control.mirrored ? _control.padding : _control.width - width - _control.padding
    y: _control.topPadding + (_control.availableHeight - height) / 2
    color: _control.enabled ? _control.Material.foreground : _control.Material.hintTextColor
    source: Qaterial.Icons.menuDown
  } // ColorImage

  contentItem: T.TextField
  {
    padding: 6
    leftPadding: _control.editable ? 2 : _control.mirrored ? 0 : 12
    rightPadding: _control.editable ? 2 : _control.mirrored ? 12 : 0

    text: _control.editable ? _control.editText : _control.displayText

    enabled: _control.editable
    autoScroll: _control.editable
    readOnly: _control.down
    inputMethodHints: _control.inputMethodHints
    validator: _control.validator

    font: _control.font
    color: _control.enabled ? _control.Material.foreground : _control.Material.hintTextColor
    selectionColor: _control.Material.accentColor
    selectedTextColor: _control.Material.primaryHighlightedTextColor
    verticalAlignment: Text.AlignVCenter

    cursorDelegate: CursorDelegate {}
  } // TextField

  background: Rectangle
  {
    implicitWidth: 120
    implicitHeight: _control.Material.buttonHeight

    radius: _control.flat ? 0 : 2
    color: !_control.editable ? _control.Material.dialogColor : "transparent"

    layer.enabled: _control.enabled && !_control.editable && _control.Material.background.a > 0
    layer.effect: ElevationEffect
    {
      elevation: _control.Material.elevation
    } // ElevationEffect

    Rectangle
    {
      visible: _control.editable
      y: parent.y + _control.baselineOffset
      width: parent.width
      height: _control.activeFocus ? 2 : 1
      color: _control.editable && _control.activeFocus ? _control.Material.accentColor : _control.Material
        .hintTextColor
    } // Rectangle

    Rectangle
    {
      height: 2 //_control.backgroundBorderHeight
      color: "red" //_control.backgroundHighlightColor
      width: _control.activeFocus ? parent.width : 0
      x: _control.activeFocus ? 0 : parent.width / 2

      Behavior on width
      {
        enabled: !_control.activeFocus
        NumberAnimation { easing.type: Easing.OutCubic;
          duration: 300 } // NumberAnimation
      } // Behavior

      Behavior on x
      {
        enabled: !_control.activeFocus
        NumberAnimation { easing.type: Easing.OutCubic;
          duration: 300 } // NumberAnimation
      } // Behavior
    } // Rectangle

    Ripple
    {
      clip: _control.flat
      clipRadius: _control.flat ? 0 : 2
      x: _control.editable && _control.indicator ? _control.indicator.x : 0
      width: _control.editable && _control.indicator ? _control.indicator.width : parent.width
      height: parent.height
      pressed: _control.pressed
      anchor: _control.editable && _control.indicator ? _control.indicator : _control
      active: _control.pressed || _control.visualFocus || _control.hovered
      color: _control.Material.rippleColor
    } // Ripple
  } // Rectangle

  popup: T.Popup
  {
    y: _control.editable ? _control.height - 5 : 0
    width: _control.width
    height: Math.min(contentItem.implicitHeight, _control.Window.height - topMargin - bottomMargin)
    transformOrigin: Item.Top
    topMargin: 12
    bottomMargin: 12

    Material.theme: _control.Material.theme
    Material.accent: _control.Material.accent
    Material.primary: _control.Material.primary

    enter: Transition
    {
      // grow_fade_in
      NumberAnimation { property: "scale";from: 0.9;to: 1.0;easing.type: Easing.OutQuint;duration: 220 }
      NumberAnimation { property: "opacity";from: 0.0;to: 1.0;easing.type: Easing.OutCubic;duration: 150 }
    } // Transition

    exit: Transition
    {
      // shrink_fade_out
      NumberAnimation { property: "scale";from: 1.0;to: 0.9;easing.type: Easing.OutQuint;duration: 220 }
      NumberAnimation { property: "opacity";from: 1.0;to: 0.0;easing.type: Easing.OutCubic;duration: 150 }
    } // Transition

    contentItem: ListView
    {
      clip: true
      implicitHeight: contentHeight
      model: _control.delegateModel
      currentIndex: _control.highlightedIndex
      highlightMoveDuration: 0

      T.ScrollIndicator.vertical: ScrollIndicator {}
    } // ListView

    background: Rectangle
    {
      radius: 2
      color: parent.Material.dialogColor

      layer.enabled: _control.enabled
      layer.effect: ElevationEffect
      {
        elevation: 8
      } // ElevationEffect
    } // Rectangle
  } // Popup
} // ComboBox
