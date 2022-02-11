/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material 2.12
import QtQuick.Controls

// Qaterial
import Qaterial as Qaterial

T.ApplicationWindow
{
  id: _window

  color: Qaterial.Style.backgroundColor
  property color overlayColor: Qaterial.Style.overlayColor

  Overlay.modal: Rectangle
  {
    color: _window.overlayColor
    Behavior on opacity { NumberAnimation { duration: 150 } }
  } // Rectangle

  Overlay.modeless: Rectangle
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
