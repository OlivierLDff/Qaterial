// Copyright Olivier Le Doeuff 2020 (C)

import QtQuick 2.0
import Qt.labs.settings 1.0 as QLab

import Qaterial 1.0 as Qaterial
import Qaterial.HotReload 1.0 as HR

Item
{
  id: root

  property int appTheme: Qaterial.Style.theme

  QLab.Settings { property alias appTheme: root.appTheme }

  Loader
  {
    id: splashScreenLoader
    active: false
    sourceComponent: HR.SplashScreenWindow { }

    Component.onCompleted: () => applicationLoader.active = true
  } // Loader

  Loader
  {
    id: applicationLoader
    active: false
    sourceComponent: HR.HotReloadWindow
    {
      Component.onCompleted: () => splashScreenLoader.active = false
    }
  } // Loader

  Component.onCompleted: function()
  {
    Qaterial.Style.theme = root.appTheme
    splashScreenLoader.active = true
  }
}