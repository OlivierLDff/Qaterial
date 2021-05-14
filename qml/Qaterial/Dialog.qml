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
  id: root

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
  font: Qaterial.Style.textTheme.body1

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
  // Deprecated
  property alias backgroundColor: root.palette.base
  property color overlayColor: Qaterial.Style.overlayColor
  property bool drawSeparator: false

  palette.base: Qaterial.Style.colorTheme.dialog

  background: Rectangle
  {
    radius: Qaterial.Style.dialog.radius
    color: root.palette.base

    layer.enabled: root.elevation > 0
    layer.effect: Qaterial.ElevationEffect
    {
      elevation: root.elevation
    } // ElevationEffect

    Qaterial.HorizontalLineSeparator
    {
      visible: root.drawSeparator && header.visible
      //anchors.top: header.bottom
      //anchors.topMargin: root.topPadding
      anchors.horizontalCenter: parent.horizontalCenter
      implicitWidth: root.width
      y: root.header ? root.header.height + root.topPadding - 1 : 0
    } // HorizontalLineSeparator

    Qaterial.HorizontalLineSeparator
    {
      visible: root.drawSeparator && footer.visible
      y: root.footer ? root.height - footer.height - root.bottomPadding : 0
      //anchors.bottom: footer.top
      //anchors.bottomMargin: root.bottomPadding
      anchors.horizontalCenter: parent.horizontalCenter
      implicitWidth: root.width
    } // HorizontalLineSeparator
  } // Rectangle

  header: Qaterial.LabelHeadline6
  {
    text: root.title
    visible: root.title
    elide: Label.ElideRight
    padding: Qaterial.Style.dialog.horizontalPadding
    bottomPadding: 0
    background: Rectangle
    {
      radius: Qaterial.Style.dialog.radius
      color: root.palette.base
      //clip: true
    } // Rectangle
  } // Label

  footer: Qaterial.DialogButtonBox
  {
    visible: count > 0
    palette.base: root.palette.base
  } // DialogButtonBox

  T.Overlay.modal: Rectangle
  {
    color: root.overlayColor
    Behavior on opacity { NumberAnimation { duration: 150 } }
  } // Rectangle

  T.Overlay.modeless: Rectangle
  {
    color: root.overlayColor
    Behavior on opacity { NumberAnimation { duration: 150 } }
  } // Rectangle
} // Dialog
