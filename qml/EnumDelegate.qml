/** Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

ItemDelegate
{
    id: control

    signal accepted(int value)
    signal rejected()

    property alias model: _radioDialog.model
    property alias value: _radioDialog.currentIndex
    property alias delegate: _radioDialog.delegate
    property alias currentIndex: _radioDialog.currentIndex
    property alias title: _radioDialog.title

    RadioDialog
    {
        id: _radioDialog
        onAccepted: control.accepted(currentIndex)
        onRejected: control.rejected()
    }

    onClicked: _radioDialog.open()
}
