/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Controls

// Qaterial
import Qaterial as Qaterial

Qaterial.RadioDelegate
{
  onClicked: ListView.view.currentIndex = index
  checked: ListView.isCurrentItem
  backgroundColor: Qaterial.Style.dialogColor
  indicatorSpacing: Qaterial.Style.dialog.indicatorSpacing
  alignTextRight: true
  LayoutMirroring.enabled: true
  width: parent.width // Not sure if this should be here ?
} // RadioDelegate
