/** Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com */

// Qt
import QtQuick.Controls 2.12

// MaterialHelper
import QQuickMaterialHelper.Components 1.12
import QQuickMaterialHelper.Style 1.12

Dialog
{
    id: root
    modal: true
    focus: true

    x: Math.floor((parent.width - width) / 2)
    y: Math.floor((parent.height-(Qt.inputMethod && Qt.inputMethod.visible ? (Qt.inputMethod.keyboardRectangle.height/Screen.devicePixelRatio ) : 0) - height) / 2)

    parent: Overlay.overlay
    width: Math.floor(Math.min(parent.width - 2*MaterialStyle.card.horizontalPadding, MaterialStyle.dialog.implicitWidth))
}
