/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

Pane
{
    id: control

    // TEXT
    property string text

    // ACTION
    property alias action: _action.text
    signal actionPressed()

    padding: 0

    elevation: Style.snackbar.elevation
    radius: Style.snackbar.radius

    property bool drawline: Style.debug.drawDebugDelegate
    color: Style.snackbarColor()

    property bool expandable: false

    contentItem: Item
    {
        id: _content
        implicitWidth: control.expandable ? (Math.max(Style.snackbar.implicitWidth, _label.implicitWidth + _action.implicitWidth) + Style.card.horizontalPadding*(control.action != "" ? 3 : 2)) : Style.snackbar.implicitWidth
        implicitHeight: (_label.lineCount > 1) ? Style.snackbar.implicitHeight2 : Style.snackbar.implicitHeight

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
            anchors.leftMargin: Style.card.horizontalPadding
            anchors.right: (control.action != "") ? _action.left : parent.right
            anchors.rightMargin: (control.action != "") ? Style.card.horizontalPadding : Style.card.verticalPadding
            maximumLineCount: control.expandable ? 1 : 2
            wrapMode: control.expandable ? Text.NoWrap : Text.WordWrap
            elide: (control.mirrored ? Text.ElideLeft : Text.ElideRight)

            color: Style.snackbarTextColor()

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
            visible: text
            onPressed: control.actionPressed()
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.verticalCenter: _content.verticalCenter
            anchors.verticalCenterOffset: _label.lineCount > 1 ? implicitHeight/6 : 0
            onPrimary: true
            rippleColor: Style.snackbarRippleColor()
        } // FlatButton
    } // contentItem
} // Pane
