/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

Pane 
{
    id: control

    // TEXT
    property string text

    // ACTION
    property alias action: _action.text
    signal actionPressed()

    padding: 0

    elevation: MaterialStyle.snackbar.elevation
    radius: MaterialStyle.snackbar.radius

    property bool drawline: MaterialStyle.debug.drawDebugDelegate
    color: MaterialStyle.snackbarColor()

    property bool expandable: false

    contentItem: Item
    {
        id: _content
        implicitWidth: control.expandable ? (Math.max(MaterialStyle.snackbar.implicitWidth, _label.implicitWidth + _action.implicitWidth) + MaterialStyle.card.horizontalPadding*(control.action != "" ? 3 : 2)) : MaterialStyle.snackbar.implicitWidth
        implicitHeight: (_label.lineCount > 1) ? MaterialStyle.snackbar.implicitHeight2 : MaterialStyle.snackbar.implicitHeight

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "pink"
            visible: control.drawline
        }

        Label // Label when there is only one action or in desktop mode
        {
            id: _label
            text: control.text
            anchors.verticalCenter: _content.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: MaterialStyle.card.horizontalPadding
            anchors.right: (control.action != "") ? _action.left : parent.right
            anchors.rightMargin: (control.action != "") ? MaterialStyle.card.horizontalPadding : MaterialStyle.card.verticalPadding
            maximumLineCount: control.expandable ? 1 : 2
            wrapMode: control.expandable ? Text.NoWrap : Text.WordWrap
            elide: (control.mirrored ? Text.ElideLeft : Text.ElideRight)

            color: MaterialStyle.snackbarTextColor()

            DebugRectangle
            {
                anchors.fill: parent
                border.color: "red"
                visible: control.drawline
            }
        } // Label

        FlatButton
        {
            id: _action
            visible: text != ""
            onPressed: control.actionPressed()
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.verticalCenter: _content.verticalCenter
            anchors.verticalCenterOffset: _label.lineCount > 1 ? implicitHeight/6 : 0
            onPrimary: true
        } // FlatButton
    }
} // Pane
