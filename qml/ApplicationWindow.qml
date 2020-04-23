/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0 as Qaterial

T.ApplicationWindow
{
  id: _window

  color: Qaterial.Style.backgroundColor
  property color overlayColor: Qaterial.Style.overlayColor

  overlay.modal: Rectangle
  {
    color: _window.overlayColor
    Behavior on opacity { NumberAnimation { duration: 150 } }
  } // Rectangle

  overlay.modeless: Rectangle
  {
    color: _window.overlayColor
    Behavior on opacity { NumberAnimation { duration: 150 } }
  } // Rectangle

  Component.onCompleted:
  {
    if(!Qaterial.DialogManager.parent)
    Qaterial.DialogManager.parent = contentItem

    if(!Qaterial.SnackbarManager.parent)
    Qaterial.SnackbarManager.parent = contentItem
  } // Component
} // ApplicationWindow
