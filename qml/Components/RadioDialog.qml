/** Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Components 1.12
import QQuickMaterialHelper.Style 1.12

ModalDialog 
{
    id: root

    property alias model: _list.model
    property alias currentIndex: _list.currentIndex

    property alias delegate: _list.delegate
    horizontalPadding: 0
    bottomPadding: 1
    drawSeparator: _list.height < _list.contentHeight
    property double maxHeight: MaterialStyle.dialog.maxHeight

    standardButtons: Dialog.Ok | Dialog.Cancel
    contentItem:ListView
    {
        implicitHeight: Math.min(root.maxHeight, _list.contentHeight)
        //height: 200
        interactive: contentHeight > height
        id: _list
        clip: true
        delegate: RadioDialogDelegate
        {
            text: model.text ? model.text : ""
            secondaryText: model.secondaryText ? model.secondaryText : ""
            width: parent.width // Not necessary if it stay inside RadioDialogDelegate.qml ?
        }
    }   
}