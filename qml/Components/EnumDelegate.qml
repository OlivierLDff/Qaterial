/** Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Components 1.12
import QQuickMaterialHelper.Containers 1.12
import QQuickMaterialHelper.Style 1.12

ItemDelegate
{
    id: control

    signal accepted(int value)
    signal rejected()

    property alias model: _radioDialog.model
    property alias value: _radioDialog.currentIndex
    property alias delegate: _radioDialog.delegate

    property alias title: _radioDialog.title

    RadioDialog
    {
        id: _radioDialog
        onAccepted: control.accepted(currentIndex)
        onRejected: control.rejected()
    }

    onClicked: _radioDialog.open()
} 