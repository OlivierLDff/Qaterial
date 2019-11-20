/** Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

T.DialogButtonBox
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    spacing: MaterialStyle.dialog.spacing
    padding: MaterialStyle.dialog.padding
    alignment: Qt.AlignRight
    buttonLayout: T.DialogButtonBox.AndroidLayout

    property color foregroundColor: MaterialStyle.accentColor
    property color backgroundColor: MaterialStyle.backgroundColor

    /*delegate: FlatButton
    {
        foregroundColor: control.foregroundColor
        onClicked: _list.positionViewAtBeginning()
    }*/
    delegate: FlatButton
    {
    }

    contentItem: ListView
    {
        id: _list
        model: control.contentModel
        spacing: control.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.SnapToItem
    } // ListView

    background: Rectangle
    {
        implicitHeight: MaterialStyle.dialog.buttonRectImplicitHeight
        radius: MaterialStyle.dialog.radius
        color: control.backgroundColor
        // Rounded corners should be only at the top or at the bottom
        //topPadding: control.position === T.DialogButtonBox.Footer ? -2 : 0
        //bottomPadding: control.position === T.DialogButtonBox.Header ? -2 : 0
        //clip: true
    } // Rectangle
}
