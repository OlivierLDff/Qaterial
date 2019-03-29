/** Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Components 1.12
import QQuickMaterialHelper.Style 1.12

RadioDelegate
{
    onClicked: ListView.view.currentIndex = index
    checked: ListView.view.currentIndex === index
    backgroundColor: MaterialStyle.dialogColor
    indicatorSpacing: MaterialStyle.dialog.indicatorSpacing
    alignTextRight: true
    LayoutMirroring.enabled: true
    width: parent.width // Not sure if this should be here ?
}