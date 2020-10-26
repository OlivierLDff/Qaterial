/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.Dialog
{
  id: root
  modal: true
  focus: true

  x: Math.floor((parent.width - width) / 2)
  y: Math.floor((parent.height - (Qt.inputMethod && Qt.inputMethod.visible ? (Qt.inputMethod.keyboardRectangle
    .height / Screen.devicePixelRatio) : 0) - height) / 2)

  parent: Overlay.overlay
  property int dialogImplicitWidth: Qaterial.Style.dialog.implicitWidth
  implicitWidth: Math.floor(Math.min(parent.width - 2 * Qaterial.Style.card.horizontalPadding, dialogImplicitWidth))
} // Dialog
