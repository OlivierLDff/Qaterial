// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// MaterialHelper
import QQuickMaterialHelper.Components 1.12
import QQuickMaterialHelper.Containers 1.12
import QQuickMaterialHelper.Style 1.12

/**
  * @brief Manager that creates snack bar dinamically
  */
 Item
 {
    id: root

    // The actual time we are using that can be override by the user
    property real snackbarTimeout: MaterialStyle.snackbar.shortDisplayTime
    // Use to force the display off of the snackbar bar
    property bool displaySnackbar: false
    // If the snackbar can be kill before the end of it's lifetime
    property bool canBeKilled: true

    z: Infinity

    // Snackbar component that is intentianted
    Component
    {
        id:_snackbarComp

        Snackbar
        {
            id : _snackbar
            opacity: 0

            onActionPressed :
            {
                if(root.settings && root.settings.onAccept)
                {
                    root.settings.onAccept()
                    goToPendingDestroy()
                    //_snackbarLoader.sourceComponent = null // close snack bar because the user have made his choice
                    // todo
                }

            }
            text : root.settings && root.settings.text ? root.settings.text : ""
            action: root.settings && root.settings.action ? root.settings.action: ""

            Component.onCompleted:
            {
                snackbarTimeout = root.settings.timeout === undefined ? MaterialStyle.snackbar.shortDisplayTime : root.settings.timeout
                canBeKilled = root.settings.canBeKilled === undefined ? true : root.settings.canBeKilled
                opacity = 1
            }

            property bool pendingDestroy: false

            function goToPendingDestroy()
            {
                fadeDuration = displaySnackbar ? 250 : 50
                opacity = 0
                _destroyTimer.start()
            }

            function destroySnackbar()
            {
                _snackbarLoader.sourceComponent = null

                if(root.settings && root.settings.onClose)
                    root.settings.onClose()

                root.popSnackBar() // to know if other snack bar is required
            }

            Connections
            {
                target: root
                onDisplaySnackbarChanged:
                {
                    if(!root.displaySnackbar && !pendingDestroy)
                        goToPendingDestroy()
                }
            }

            Timer
            {
                interval: root.snackbarTimeout
                running: true
                onTriggered: goToPendingDestroy()
            }

            Timer
            {
                id: _destroyTimer
                interval: fadeDuration
                onTriggered: destroySnackbar()
            }

            property real fadeDuration: 150

            Behavior on opacity
            {
                NumberAnimation
                {
                    duration: fadeDuration
                    easing.type: Easing.OutQuad
                }
            }
        } // SnackBar
    } // Component

    Loader
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom : parent.bottom
        id: _snackbarLoader
    }

    property var settings: null
    property var settingsCurrent : null
    property var settingsArray : []

    //Show a snackbar prepared in paramters
    function show(config)
    {
        if(_snackbarLoader.sourceComponent)
        {
            if(canBeKilled)
            {
                displaySnackbar = false
                if(settingsArray.length)
                    settingsArray.length = 0
            }
            settingsArray.push(config)
        }
        else
        {
            settings = config
            displaySnackbar = true
            _snackbarLoader.sourceComponent = _snackbarComp
        }
    }

    // function to load the next snack bar recorded before
    function popSnackBar()
    {
        if (settingsCurrent = settingsArray.shift())
            show(settingsCurrent)
    }
}
