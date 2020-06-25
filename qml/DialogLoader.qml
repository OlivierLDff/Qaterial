/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: _root

  Component
  {
    id: _dialogComp
    Qaterial.AlertIconDialog
    {
      text: (_root.settings && _root.settings.text) ? _root.settings.text : ""
      title: (_root.settings && _root.settings.title) ? _root.settings.title : ""

      Component.onCompleted:
      {
        if(_root.settings && _root.settings.iconSource)
          iconSource = _root.settings.iconSource
        if(_root.settings && _root.settings.iconColor)
          iconColor = _root.settings.iconColor
        if(_root.settings && _root.settings.standardButtons)
          standardButtons = _root.settings.standardButtons

        open()
      }

      onAccepted:
      {
        if(_root.settings && _root.settings.acceptedCallback)
          _root.settings.acceptedCallback()
      }

      onApplied:
      {
        if(_root.settings && _root.settings.appliedCallback)
          _root.settings.appliedCallback()
      }

      onHelpRequested:
      {
        if(_root.settings && _root.settings.helpRequestedCallback)
          _root.settings.helpRequestedCallback()
      }

      onRejected:
      {
        if(_root.settings && _root.settings.rejectedCallback)
          _root.settings.rejectedCallback()
      }

      onClosed:
      {
        _root.settings = null
        _dialogLoader.sourceComponent = undefined
      }
    } // AlertIconDialog
  } // Component

  Component
  {
    id: _textFieldDialogComp

    Qaterial.TextFieldDialog
    {
      text:                             (_root.settings && _root.settings.text) ? _root.settings.text : ""
      title:                           (_root.settings && _root.settings.title) ? _root.settings.title : ""
      textTitle:                   (_root.settings && _root.settings.textTitle) ? _root.settings.textTitle : ""
      placeholderText:       (_root.settings && _root.settings.placeholderText) ? _root.settings.placeholderText : ""
      helperText:                 (_root.settings && _root.settings.helperText) ? _root.settings.helperText : ""
      validator:                   (_root.settings && _root.settings.validator) ? _root.settings.validator : null
      inputMethodHints:     (_root.settings && _root.settings.inputMethodHints) ? _root.settings.inputMethodHints : Qt.ImhSensitiveData
      maximumLengthCount: (_root.settings && _root.settings.maximumLengthCount) ? _root.settings.maximumLengthCount : 32767
      selectAllText:           (_root.settings && _root.settings.selectAllText) ? _root.settings.selectAllText : false
      errorText:                   (_root.settings && _root.settings.errorText) ? _root.settings.errorText : false
      echoMode:                     (_root.settings && _root.settings.echoMode) ? _root.settings.echoMode : TextInput.Normal

      Component.onCompleted:
      {
        if(_root.settings && _root.settings.standardButtons)
        standardButtons = _root.settings.standardButtons

        open()
      }

      onAccepted:
      {
        if(_root.settings && _root.settings.acceptedCallback)
        _root.settings.acceptedCallback(text, acceptableInput && !error)
      }

      onApplied:
      {
        if(_root.settings && _root.settings.appliedCallback)
        _root.settings.appliedCallback()
      }

      onHelpRequested:
      {
        if(_root.settings && _root.settings.helpRequestedCallback)
        _root.settings.helpRequestedCallback()
      }

      onRejected:
      {
        if(_root.settings && _root.settings.rejectedCallback)
        _root.settings.rejectedCallback()
      }

      onClosed:
      {
        _root.settings = null
        _dialogLoader.sourceComponent = undefined
      }
    } // TextFieldDialog
  } // Component

  Component
  {
    id: _busyIndicatorDialogComp

    Qaterial.BusyIndicatorDialog
    {
      text: _root.settings && _root.settings.text ? _root.settings.text : ""
      Component.onCompleted: open()
    } // BusyIndicatorDliaog
  } // Component

  Component
  {
    id: _radioListViewComp

    Qaterial.RadioDialog
    {
      title: (_root.settings && _root.settings.title) ? _root.settings.title : ""
      currentIndex: (_root.settings && _root.settings.currentIndex !== undefined) ? _root.settings.currentIndex : -1

      model: (_root.settings && _root.settings.model) ? _root.settings.model : null
      delegate: (_root.settings && _root.settings.delegate) ? _root.settings.delegate : defaultDelegate

      Component.onCompleted:
      {
        if(_root.settings && _root.settings.standardButtons)
        standardButtons = _root.settings.standardButtons

        if(!model)
        console.log("Error : RadioListViewDialog : model is null on open")

        open()
      }

      onAccepted:
      {
        if(_root.settings && _root.settings.acceptedCallback)
        _root.settings.acceptedCallback(currentIndex)
      }

      onApplied:
      {
        if(_root.settings && _root.settings.appliedCallback)
        _root.settings.appliedCallback()
      }

      onHelpRequested:
      {
        if(_root.settings && _root.settings.helpRequestedCallback)
        _root.settings.helpRequestedCallback()
      }

      onRejected:
      {
        if(_root.settings && _root.settings.rejectedCallback)
        _root.settings.rejectedCallback()
      }

      onClosed:
      {
        _root.settings = null
        _dialogLoader.sourceComponent = undefined
      }
    } // RadioDialog
  } // Component

  Loader
  {
    id: _dialogLoader
  } // Loader

  property var settings: null

  function closeIfAlreadyOpened()
  {
    if(_dialogLoader.sourceComponent)
      _dialogLoader.sourceComponent = undefined
  }

  function openWithSettings(dialogManagerSettings)
  {
    // 1) Close if already open
    closeIfAlreadyOpened()

    // 2) Keep settings in memory
    settings = dialogManagerSettings

    // 3) Open the dialog
    _dialogLoader.sourceComponent = _dialogComp
  }

  function openTextField(textFieldDialogSettings)
  {
    // 1) Close if already open
    closeIfAlreadyOpened()

    // 2) Keep settings in memory
    settings = textFieldDialogSettings

    // 3) Open the dialog
    _dialogLoader.sourceComponent = _textFieldDialogComp
  }

  function openBusyIndicator(busyIndicatorDialogSettings)
  {
    // 1) Close if already open
    closeIfAlreadyOpened()

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

  function openRadioListView(radioListViewDialogSettings)
  {
    // 1) Close if already open
    closeIfAlreadyOpened()

    // 2) Keep settings in memory
    settings = radioListViewDialogSettings

    // 3) Open the dialog
    _dialogLoader.sourceComponent = _radioListViewComp
  }

  function openFromComponent(component)
  {
    // 1) Close if already open
    closeIfAlreadyOpened()

    // 2) Keep settings in memory
    settings = null

    // 3) Open the dialog
    _dialogLoader.sourceComponent = component
  }

  function close()
  {
    // 1) Close if already open
    closeIfAlreadyOpened()

    // 2) Keep settings in memory
    settings = null
  }
} // Item
