/** Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Components 1.12
import QQuickMaterialHelper.Style 1.12

ModalDialog
{
    id: root

    property var model: null
    property int currentIndex: 0

    property var delegate: defaultDelegate
    readonly property var defaultDelegate: _defaultDelegate

    Component
    {
        id: _defaultDelegate
        RadioDialogDelegate
        {
            text: model.text ? model.text : ""
            secondaryText: model.secondaryText ? model.secondaryText : ""
        }
    }

    horizontalPadding: 0
    bottomPadding: 1
    drawSeparator: _list.height < _list.contentHeight
    property double maxHeight: MaterialStyle.dialog.maxHeight

    standardButtons: Dialog.Ok | Dialog.Cancel
    contentItem: ListView
    {
        implicitHeight: Math.min(root.maxHeight, _list.contentHeight)
        //height: 200
        interactive: contentHeight > height
        id: _list
        clip: true
        model: root.model
        delegate: root.delegate
        highlightFollowsCurrentItem: true
        currentIndex: root.currentIndex

        onCurrentIndexChanged:
        {
            if(root.currentIndex !== currentIndex)
                root.currentIndex = currentIndex
        }
    }
}
