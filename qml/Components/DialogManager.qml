/** Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Components 1.12
import QQuickMaterialHelper.Style 1.12

Item
{
    id: root

    Component
    {
        id: _dialogComp
        AlertIconDialog
        {
            text: root.settings && root.settings.text ? root.settings.text : ""
            title: root.settings && root.settings.title ? root.settings.title : ""

            Component.onCompleted:
            {
                if(root.settings && root.settings.iconSource)
                    iconSource = root.settings.iconSource
                if(root.settings && root.settings.iconColor)
                    iconColor = root.settings.iconColor
                if(root.settings && root.settings.standardButtons)
                   standardButtons = root.settings.standardButtons

                open()
            }

            onAccepted:
            {
                if(root.settings && root.settings.acceptedCallback)
                    root.settings.acceptedCallback()
            }

            onApplied:
            {
                if(root.settings && root.settings.appliedCallback)
                    root.settings.appliedCallback()
            }

            onHelpRequested:
            {
                if(root.settings && root.settings.helpRequestedCallback)
                    root.settings.helpRequestedCallback()
            }

            onRejected:
            {
                if(root.settings && root.settings.rejectedCallback)
                    root.settings.rejectedCallback()
            }

            onClosed:
            {
                root.settings = null
                _dialogLoader.sourceComponent = undefined
            }
        }
    }

    Component
    {
        id: _textFieldDialogComp
        TextFieldDialog
        {
            text: root.settings && root.settings.text ? root.settings.text : ""
            title: root.settings && root.settings.title ? root.settings.title : ""
            textTitle: root.settings && root.settings.textTitle ? root.settings.textTitle : ""
            placeholderText: root.settings && root.settings.placeholderText ? root.settings.placeholderText : ""
            helperText: root.settings && root.settings.helperText ? root.settings.helperText : ""
            validator: root.settings && root.settings.validator ? root.settings.validator : null
            inputMethodHints: root.settings && root.settings.inputMethodHints ? root.settings.inputMethodHints : Qt.ImhSensitiveData
            maximumLengthCount: root.settings && root.settings.maximumLengthCount ? root.settings.maximumLengthCount : 32767
            selectAllText: root.settings && root.settings.selectAllText ? root.settings.selectAllText : false
            echoMode: root.settings && root.settings.echoMode ? root.settings.echoMode : TextInput.Normal

            Component.onCompleted:
            {
                if(root.settings && root.settings.standardButtons)
                   standardButtons = root.settings.standardButtons

                open()
            }

            onAccepted:
            {
                if(root.settings && root.settings.acceptedCallback)
                    root.settings.acceptedCallback(text)
            }

            onApplied:
            {
                if(root.settings && root.settings.appliedCallback)
                    root.settings.appliedCallback()
            }

            onHelpRequested:
            {
                if(root.settings && root.settings.helpRequestedCallback)
                    root.settings.helpRequestedCallback()
            }

            onRejected:
            {
                if(root.settings && root.settings.rejectedCallback)
                    root.settings.rejectedCallback()
            }

            onClosed:
            {
                root.settings = null
                _dialogLoader.sourceComponent = undefined
            }
        }
    }

    Component
    {
        id: _busyIndicatorDialogComp
        BusyIndicatorDialog
        {
            text: root.settings && root.settings.text ? root.settings.text : ""
            Component.onCompleted: open()
        }
    }

    Loader
    {
        id: _dialogLoader
    }

    property var settings: null

    function openWithSettings(dialogManagerSettings)
    {
        // 1) Close if already open
        if(_dialogLoader.sourceComponent)
            _dialogLoader.sourceComponent = undefined

        // 2) Keep settings in memory
        settings = dialogManagerSettings

        // 3) Open the dialog
        _dialogLoader.sourceComponent = _dialogComp
    }

    function openTextField(textFieldDialogSettings)
    {
        // 1) Close if already open
        if(_dialogLoader.sourceComponent)
            _dialogLoader.sourceComponent = undefined

        // 2) Keep settings in memory
        settings = textFieldDialogSettings

        // 3) Open the dialog
        _dialogLoader.sourceComponent = _textFieldDialogComp
    }

    function openBusyIndicator(busyIndicatorDialogSettings)
    {
        // 1) Close if already open
        if(_dialogLoader.sourceComponent)
            _dialogLoader.sourceComponent = undefined

        // 2) Keep settings in memory
        settings = busyIndicatorDialogSettings

        // 3) Open the dialog
        _dialogLoader.sourceComponent = _busyIndicatorDialogComp
    }

    function closeBusyIndicator()
    {
        if(_dialogLoader.sourceComponent && _dialogLoader.sourceComponent === _busyIndicatorDialogComp)
            _dialogLoader.sourceComponent = undefined
    }

    function openFromComponent(component)
    {
        // 1) Close if already open
        if(_dialogLoader.sourceComponent)
            _dialogLoader.sourceComponent = undefined

        // 2) Keep settings in memory
        settings = null

        // 3) Open the dialog
        _dialogLoader.sourceComponent = component
    }
} // Item
