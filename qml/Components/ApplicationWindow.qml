/** Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T

import QQuickMaterialHelper.Style 1.12

T.ApplicationWindow 
{
    id: window

    color: MaterialStyle.backgroundColor
    property color overlayColor: MaterialStyle.overlayColor

    overlay.modal: Rectangle 
    {
        color: window.overlayColor
        Behavior on opacity { NumberAnimation { duration: 150 } }
    } // Rectangle

    overlay.modeless: Rectangle 
    {
        color: window.overlayColor
        Behavior on opacity { NumberAnimation { duration: 150 } }
    } // Rectangle
} // ApplicationWindow
