/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.12
import Qt.labs.platform 1.1 as QLab
// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  property var settings: null
  property QtObject context

  onContextChanged: function() { if(!context) close() }

  Component
  {
    id: _dialogComp

    Qaterial.AlertIconDialog
    {
      text: (root.settings && root.settings.text) ? root.settings.text : ""
      title: (root.settings && root.settings.title) ? root.settings.title : ""

      Component.onCompleted:
      {
        if(root.settings)
        {
          if(root.settings.iconSource)
            iconSource = root.settings.iconSource

          if(root.settings.icon)
            iconSource = root.settings.icon

          if(root.settings.iconColor)
            iconColor = root.settings.iconColor

          if(root.settings.standardButtons)
            standardButtons = root.settings.standardButtons
        }

        open()
      }

      onAccepted: function()
      {
        if(root.settings && root.settings.onAccepted)
          root.settings.onAccepted()

        if(root.settings && root.settings.acceptedCallback)
        {
          Qaterial.Logger.warn("You are using deprecated 'acceptedCallback'. You should consider moving to 'onAccepted'")
          root.settings.acceptedCallback()
        }
      }

      onApplied: function()
      {
        if(root.settings && root.settings.onApplied)
          root.settings.onApplied()

        if(root.settings && root.settings.appliedCallback)
        {
          Qaterial.Logger.warn("You are using deprecated 'appliedCallback'. You should consider moving to 'onApplied'")
          root.settings.appliedCallback()
        }
      }

      onHelpRequested: function()
      {
        if(root.settings && root.settings.onHelpRequested)
          root.settings.onHelpRequested()

        if(root.settings && root.settings.helpRequestedCallback)
        {
          Qaterial.Logger.warn("You are using deprecated 'helpRequestedCallback'. You should consider moving to 'onHelpRequested'")
          root.settings.helpRequestedCallback()
        }
      }

      onRejected: function()
      {
        if(root.settings && root.settings.onRejected)
          root.settings.onRejected()

        if(root.settings && root.settings.rejectedCallback)
        {
          Qaterial.Logger.warn("You are using deprecated 'rejectedCallback'. You should consider moving to 'onRejected'")
          root.settings.rejectedCallback()
        }
      }

      onClosed: () => root.close()
    } // AlertIconDialog
  } // Component

  Component
  {
    id: _textFieldDialogComp

    Qaterial.TextFieldDialog
    {
      text:                             (root.settings && root.settings.text) ? root.settings.text : ""
      title:                           (root.settings && root.settings.title) ? root.settings.title : ""
      textTitle:                   (root.settings && root.settings.textTitle) ? root.settings.textTitle : ""
      placeholderText:       (root.settings && root.settings.placeholderText) ? root.settings.placeholderText : ""
      helperText:                 (root.settings && root.settings.helperText) ? root.settings.helperText : ""
      validator:                   (root.settings && root.settings.validator) ? root.settings.validator : null
      inputMethodHints:     (root.settings && root.settings.inputMethodHints) ? root.settings.inputMethodHints : Qt.ImhSensitiveData
      maximumLengthCount: (root.settings && root.settings.maximumLengthCount) ? root.settings.maximumLengthCount : 32767
      selectAllText:           (root.settings && root.settings.selectAllText) ? root.settings.selectAllText : false
      errorText:                   (root.settings && root.settings.errorText) ? root.settings.errorText : false
      echoMode:                     (root.settings && root.settings.echoMode) ? root.settings.echoMode : TextInput.Normal

      Component.onCompleted:
      {
        if(root.settings && root.settings.standardButtons)
        standardButtons = root.settings.standardButtons

        open()
      }

      onAccepted:
      {
        if(root.settings && root.settings.acceptedCallback)
        root.settings.acceptedCallback(text, acceptableInput && !error)
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

      onClosed: () => root.close()
    } // TextFieldDialog
  } // Component

  Component
  {
    id: _busyIndicatorDialogComp

    Qaterial.BusyIndicatorDialog
    {
      text: root.settings && root.settings.text ? root.settings.text : ""
      Component.onCompleted: open()
    } // BusyIndicatorDliaog
  } // Component

  Component
  {
    id: _radioListViewComp

    Qaterial.RadioDialog
    {
      title: (root.settings && root.settings.title) ? root.settings.title : ""
      currentIndex: (root.settings && root.settings.currentIndex !== undefined) ? root.settings.currentIndex : -1

      model: (root.settings && root.settings.model) ? root.settings.model : null
      delegate: (root.settings && root.settings.delegate) ? root.settings.delegate : defaultDelegate

      Component.onCompleted:
      {
        if(root.settings && root.settings.standardButtons)
        standardButtons = root.settings.standardButtons

        if(!model)
        console.log("Error : RadioListViewDialog : model is null on open")

        open()
      }

      onAccepted:
      {
        if(root.settings && root.settings.acceptedCallback)
        root.settings.acceptedCallback(currentIndex)
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

      onClosed: () => root.close()
    } // RadioDialog
  } // Component

  Component
  {
    id: _fileDialogComp
    QLab.FileDialog
    {
      id: fileDialog

      title: (root.settings && root.settings.title) ? root.settings.title : ""
      folder: (root.settings && root.settings.folder) ? root.settings.folder : ""
      defaultSuffix: (root.settings && root.settings.defaultSuffix) ? root.settings.defaultSuffix : ""
      nameFilters: (root.settings && root.settings.nameFilters) ? root.settings.nameFilters : undefined
      fileMode: (root.settings && root.settings.fileMode) ? root.settings.fileMode : 0
      options: (root.settings && root.settings.options) ? root.settings.options : 0

      onAccepted: function()
      {
        function urlToLocalFile(url)
        {
          let path = url.toString()
          const isWindows = Qt.platform.os === "windows"
          path = isWindows ? path.replace(/^(file:\/{3})/, "") : path.replace(/^(file:\/{2})/, "")
          return decodeURIComponent(path)
        }

        if(fileDialog.fileMode === QLab.FileDialog.OpenFiles)
        {
          if(root.settings && root.settings.onAccepted)
          {
            let filePaths = []
            fileDialog.files.forEach((element) => filePaths.push(urlToLocalFile(element)))
            root.settings.onAccepted(filePaths)
          }
        }
        else if(root.settings && root.settings.onAccepted)
        {
          root.settings.onAccepted(urlToLocalFile(fileDialog.file.toString()))
        }
      }

      onRejected: function()
      {
        if(root.settings && root.settings.onRejected)
          root.settings.onRejected()
      }

      Component.onCompleted: () => open()
    }
  }

  Loader
  {
    id: _dialogLoader
  } // Loader

  function _init(dialogSettings = null)
  {
    close()

    // Assign settings
    if(dialogSettings)
      settings = dialogSettings

    // Assign context
    if(dialogSettings && dialogSettings.context)
    {
      if(dialogSettings.context instanceof QtObject)
      {
        root.context = dialogSettings.context
      }
      else
      {
        Qaterial.Logger.warn(`${dialogSettings.context} isn't an instance of QtObject. It can't be used as a dialog context.`)
      }
    }
  }

  function close()
  {
    // 1) Close if already open
    if(_dialogLoader.sourceComponent)
      _dialogLoader.sourceComponent = undefined

    // 2) Keep settings in memory
    settings = null
    context = null
  }

  function showDialog(dialogSettings)
  {
    _init(dialogSettings)
    _dialogLoader.sourceComponent = _dialogComp
  }

  function showFileDialog(dialogSettings)
  {
    _init(dialogSettings)
    _dialogLoader.sourceComponent = _fileDialogComp
  }

  function openWithSettings(dialogManagerSettings)
  {
    Qaterial.Logger.warn("'DialogLoader.openWithSettings' is deprecated, consider moving to 'showDialog'")
    showDialog(dialogManagerSettings)
  }

  function openTextField(textFieldDialogSettings)
  {
    _init(textFieldDialogSettings)
    _dialogLoader.sourceComponent = _textFieldDialogComp
  }

  function openBusyIndicator(busyIndicatorDialogSettings)
  {
    _init(busyIndicatorDialogSettings)
    _dialogLoader.sourceComponent = _busyIndicatorDialogComp
  }

  function closeBusyIndicator()
  {
    // this is too yolo, showBusyIndicator should returned a pointer or a handle
    if(_dialogLoader.sourceComponent && _dialogLoader.sourceComponent === _busyIndicatorDialogComp)
      _dialogLoader.sourceComponent = undefined
  }

  function openRadioListView(radioListViewDialogSettings)
  {
    _init(radioListViewDialogSettings)
    _dialogLoader.sourceComponent = _radioListViewComp
  }

  function openFromComponent(component)
  {
    _init()
    _dialogLoader.sourceComponent = component
  }
} // Item
