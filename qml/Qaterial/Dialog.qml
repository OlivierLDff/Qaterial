/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

T.Dialog
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    contentWidth + leftPadding + rightPadding,
    implicitHeaderWidth,
    implicitFooterWidth)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding +
    (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0) +
    (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

  padding: Qaterial.Style.dialog.horizontalPadding
  topPadding: Qaterial.Style.dialog.topPadding //+ (drawSeparator ? 1 : 0)
  bottomPadding: (drawSeparator ? 1 : (Qaterial.Style.dialog.horizontalPadding + 1))

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

  property double elevation: Qaterial.Style.dialog.elevation
  property color backgroundColor: Qaterial.Style.dialogColor
  property color overlayColor: Qaterial.Style.overlayColor
  property bool drawSeparator: false

  background: Rectangle
  {
    radius: Qaterial.Style.dialog.radius
    color: Qaterial.Style.dialogColor

    layer.enabled: _control.elevation > 0
    layer.effect: Qaterial.ElevationEffect
    {
      elevation: _control.elevation
    } // ElevationEffect

    Qaterial.HorizontalLineSeparator
    {
      visible: _control.drawSeparator && header.visible
      //anchors.top: header.bottom
      //anchors.topMargin: _control.topPadding
      anchors.horizontalCenter: parent.horizontalCenter
      implicitWidth: _control.width
      y: _control.header.height + _control.topPadding - 1
    } // HorizontalLineSeparator

    Qaterial.HorizontalLineSeparator
    {
      visible: _control.drawSeparator && footer.visible
      y: _control.height - footer.height - _control.bottomPadding
      //anchors.bottom: footer.top
      //anchors.bottomMargin: _control.bottomPadding
      anchors.horizontalCenter: parent.horizontalCenter
      implicitWidth: _control.width
    } // HorizontalLineSeparator
  } // Rectangle

  header: Qaterial.Label
  {
    text: _control.title
    visible: _control.title
    elide: Label.ElideRight
    padding: Qaterial.Style.dialog.horizontalPadding
    bottomPadding: 0
    textType: Qaterial.Style.TextType.Title
    background: Rectangle
    {
      radius: Qaterial.Style.dialog.radius
      color: _control.backgroundColor
      //clip: true
    } // Rectangle
  } // Label

  footer: Qaterial.DialogButtonBox
  {
    visible: count > 0
    backgroundColor: _control.backgroundColor
  } // DialogButtonBox

  T.Overlay.modal: Rectangle
  {
    color: _control.overlayColor
    Behavior on opacity { NumberAnimation { duration: 150 } }
  } // Rectangle

  T.Overlay.modeless: Rectangle
  {
    color: _control.overlayColor
    Behavior on opacity { NumberAnimation { duration: 150 } }
  } // Rectangle
} // Dialog
