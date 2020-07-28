// Copyright Olivier Le Doeuff 2020 (C)

import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.ApplicationWindow
{
  id: window

  title: `Qaterial Hot Reload - ${currentFilePath}`

  property alias currentFilePath: hr.currentFilePath

  width: 1280
  height: 600

  minimumWidth: 200
  minimumHeight: 200

  HotReload
  {
    id: hr
    anchors.fill: parent
  }

  Qaterial.WindowLayoutSave { name: "Reloader" }
}
