/** Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com */

import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Components 1.12

Page 
{
    id: page

    default property alias content: _pane.contentItem
    property alias pane: _pane

    Flickable 
    {
        anchors.fill: parent
        contentHeight: _pane.implicitHeight + (Qt.inputMethod && Qt.inputMethod.visible ? (Qt.inputMethod.keyboardRectangle.height/Screen.devicePixelRatio ) : 0)
        flickableDirection: Flickable.AutoFlickIfNeeded

        Pane 
        {
            id: _pane
            width: parent.width
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }
}
