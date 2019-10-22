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
    // Use to force the display off of the snackbar bar
    property bool displaySnackbar: false
    // If the snackbar can be kill before the end of it's lifetime
    property bool canBeKilled: (settings && (settings.canBeKilled !== undefined))? settings.canBeKilled : true

    z: Infinity

    // Snackbar component that is instantiated
    Component
    {
        id:_snackbarComp

        Snackbar
        {
            id : _snackbar

            opacity: 0

            // The actual time we are using that can be override by the user
            property real snackbarTimeout: root.settings.timeout === undefined ? MaterialStyle.snackbar.shortDisplayTime : root.settings.timeout
            // Used to call the onAccept callback or the onClose.
            property bool actionCalled
            // Indicate that the snackbar is about to be destroyed (and fade out animation is playing)
            property bool pendingDestroy

            text : root.settings && root.settings.text ? root.settings.text : ""
            action: root.settings && root.settings.action ? root.settings.action: ""

            onActionPressed :
            {
                if(root.settings && root.settings.onAccept)
                {
                    root.settings.onAccept()
                    actionCalled = true
                    goToPendingDestroy()
                }
            }

            /** Call to play fade out */
            function goToPendingDestroy()
            {
                pendingDestroy = true
                fadeDuration = displaySnackbar ? outFadeDuration : inFadeDuration
                opacity = 0
                _timer.interval = fadeDuration
                _timer.start()
            }

            /** Called after fading out, this will pop the next snackbar */
            function destroySnackbar()
            {
                _snackbarLoader.sourceComponent = null

                if(!actionCalled && root.settings && root.settings.onClose)
                    root.settings.onClose()

                root.popSnackBar() // to know if other snack bar is required
            }

            /** The Manager will kill the current snackbar with an animation by using this boolean property */
            Connections
            {
                target: root
                onDisplaySnackbarChanged:
                {
                    if(!root.displaySnackbar && !pendingDestroy)
                        goToPendingDestroy()
                }
            }

            /** Timer used to manage the lifetime of the snackbar */
            Timer
            {
                id: _timer
                interval: snackbarTimeout
                running: true
                onTriggered:
                {
                    if(pendingDestroy)
                        destroySnackbar()
                    else
                        goToPendingDestroy()
                }
            }

            readonly property real inFadeDuration: 100
            readonly property real outFadeDuration: 300
            property real fadeDuration

            /** Animation on opacity */
            Behavior on opacity
            {
                NumberAnimation
                {
                    duration: fadeDuration
                    easing.type: Easing.OutQuad
                }
            }

            /** Force to play fade in animation */
            Component.onCompleted:
            {
                fadeDuration = inFadeDuration
                opacity = 1
            }
        } // SnackBar
    } // Component

    /** Load the current snackbar component that use */
    Loader
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom : parent.bottom
        id: _snackbarLoader
    } // Loader

    property var settings: null
    property var settingsQueue: []

    /**
     * Show a snackbar immediatly or after the current snackbar.
     * The settings object have multiple optionnal field
     * - text: Text that will be displayed in the snackbar
     * - action: Action button text, if not specified, no action button will appear
     * - timeout: Time to display the snackbar in milliseconds. Default is 2000 ms.
     * - onAccept: Callback function called when the action button is pressed
     * - onClose: Callback function called when the snackbar disapear on no action button have been pressed
     * - canBeKilled: If true, the snackbar is immediately replaced by a new one on next call of show. By default true.
     */
    function show(config)
    {
        if(_snackbarLoader.sourceComponent)
        {
            if(canBeKilled)
            {
                displaySnackbar = false
                if(settingsQueue.length)
                    settingsQueue.length = 0
            }
            settingsQueue.push(config)
        }
        else
        {
            settings = config
            displaySnackbar = true
            _snackbarLoader.sourceComponent = _snackbarComp
        }
    }

    /**
     * Try to load the next available snackbar in the queue.
     * This function is called when the current snackbar get destroyed
     */
    function popSnackBar()
    {
        var nextSnackbarSetting = settingsQueue.shift()
        if (nextSnackbarSetting)
            show(nextSnackbarSetting)
    }
}
