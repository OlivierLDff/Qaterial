/** Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com */

import QtQuick 2.12

import QQuickMaterialHelper.Components 1.12

Item
{
    AlertIconDialog
    {
        id: _dialog

        text: root.settings && root.settings.text ? root.settings.text : ""
        title: root.settings && root.settings.title ? root.settings.title : ""
        iconSource: root.settings && root.settings.iconSource ? root.settings.iconSource : ""
        iconColor: root.settings && root.settings.iconColor ? root.settings.iconColor : ""
        standardButtons: root.settings && root.settings.standardButtons ? root.settings.standardButtons : 0

        onAccepted: 
        {
            if(root.settings && root.settings.acceptedCallback)
                root.settings.acceptedCallback()
        }
        onRejected:
        {
            if(root.settings && root.settings.rejectedCallback)
                root.settings.rejectedCallback()       
        }

        onClosed:
        {
            root.settings = null
        }
    }

    property DialogManagerSettings settings: null

    function openWithSettings(dialogManagerSettings)
    {
        // 1) Close if already open
        if(_dialog.opened)
            _dialog.close()

        // 2) Keep settings in memory
        settings = dialogManagerSettings

        // 3) Open the dialog
        _dialog.open()
    }
} // Item
