/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls.Material 2.12

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

  // Ugly trick for now : todo remove
  Material.theme: Qaterial.Style.theme
  Material.primary: Qaterial.Style.primaryColor
  Material.background: Qaterial.Style.backgroundColor
  Material.accent: Qaterial.Style.accentColor
  Material.foreground: Qaterial.Style.foregroundColor

  Qaterial.SnackbarLoader
  {
    id: _snackBarLoader
  }

  Qaterial.DialogLoader
  {
    id: _dialogLoader
  }

  Component.onCompleted:
  {
    if(!Qaterial.SnackbarManager.snackBarLoader)
      Qaterial.SnackbarManager.snackBarLoader = _snackBarLoader

    if(!Qaterial.DialogManager.dialogLoader)
      Qaterial.DialogManager.dialogLoader = _dialogLoader
  } // Component
} // ApplicationWindow
