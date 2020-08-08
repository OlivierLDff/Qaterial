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

  function urlToLocalFile(url)
  {
    let path = url.toString()
    const isWindows = Qt.platform.os === "windows"
    path = isWindows ? path.replace(/^(file:\/{3})/, "") : path.replace(/^(file:\/{2})/, "")
    return decodeURIComponent(path)
  }

  Component
  {
    id: _dialogComp

    Qaterial.AlertIconDialog
    {
      Binding on text
      {
        when: root.settings && root.settings.text
        value: root.settings.text
      }

      Binding on title
      {
        when: root.settings && root.settings.title
        value: root.settings.title
      }

      Binding on iconColor
      {
        when: root.settings && root.settings.icon
        value: root.settings.icon
      }

      Binding on iconSource
      {
        when: root.settings && root.settings.iconSource
        value:
        {
          Qaterial.Logger.warn('\'iconSource\' is deprecated, use \'icon\'')
          return root.settings.iconSource
        }
      }

      Binding on standardButtons
      {
        when: root.settings && (root.settings.standardButtons !== undefined)
        value: root.settings.standardButtons
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
    } // AlertIconDialog
  } // Component

  Component
  {
    id: _textFieldDialogComp

    Qaterial.TextFieldDialog
    {
      Binding on text
      {
        when: root.settings && root.settings.text
        value: root.settings.text
      }

      Binding on title
      {
        when: root.settings && root.settings.title
        value: root.settings.title
      }

      Binding on textTitle
      {
        when: root.settings && root.settings.textTitle
        value: root.settings.textTitle
      }

      Binding on placeholderText
      {
        when: root.settings && root.settings.placeholderText
        value: root.settings.placeholderText
      }

      Binding on helperText
      {
        when: root.settings && root.settings.helperText
        value: root.settings.helperText
      }

      Binding on validator
      {
        when: root.settings && root.settings.validator
        value: root.settings.validator
      }

      Binding on inputMethodHints
      {
        when: root.settings && root.settings.inputMethodHints
        value: root.settings.inputMethodHints
      }

      Binding on maximumLengthCount
      {
        when: root.settings && root.settings.maximumLengthCount
        value: root.settings.maximumLengthCount
      }

      Binding on selectAllText
      {
        when: root.settings && root.settings.selectAllText
        value: root.settings.selectAllText
      }

      Binding on errorText
      {
        when: root.settings && root.settings.errorText
        value: root.settings.errorText
      }

      Binding on echoMode
      {
        when: root.settings && root.settings.echoMode
        value: root.settings.echoMode
      }

      Binding on standardButtons
      {
        when: root.settings && (root.settings.standardButtons !== undefined)
        value: root.settings.standardButtons
      }

      onAccepted: function()
      {
        if(root.settings && root.settings.onAccepted)
          root.settings.onAccepted(text, acceptableInput && !error)

        if(root.settings && root.settings.acceptedCallback)
        {
          Qaterial.Logger.warn("You are using deprecated 'acceptedCallback'. You should consider moving to 'onAccepted'")
          root.settings.acceptedCallback(text, acceptableInput && !error)
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
    } // TextFieldDialog
  } // Component

  Component
  {
    id: _busyIndicatorDialogComp

    Qaterial.BusyIndicatorDialog
    {
      Binding on text
      {
        when: root.settings && root.settings.text
        value: root.settings.text
      }

      Binding on standardButtons
      {
        when: root.settings && (root.settings.standardButtons !== undefined)
        value: root.settings.standardButtons
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

      onAccepted: function()
      {
        if(root.settings && root.settings.acceptedCallback)
        root.settings.acceptedCallback(currentIndex)
      }

      onApplied: function()
      {
        if(root.settings && root.settings.appliedCallback)
        root.settings.appliedCallback()
      }

      onHelpRequested: function()
      {
        if(root.settings && root.settings.helpRequestedCallback)
        root.settings.helpRequestedCallback()
      }

      onRejected: function()
      {
        if(root.settings && root.settings.rejectedCallback)
        root.settings.rejectedCallback()
      }

      onClosed: () => root.close()

      Component.onCompleted:
      {
        if(root.settings && (root.settings.standardButtons !== undefined))
          standardButtons = root.settings.standardButtons

        if(!model)
          console.log("Error : RadioListViewDialog : model is null on open")
      }
      Component.onDestruction: () => close()
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
        if(fileDialog.fileMode === QLab.FileDialog.OpenFiles)
        {
          if(root.settings && root.settings.onAccepted)
          {
            let filePaths = []
            fileDialog.files.forEach((element) => filePaths.push(root.urlToLocalFile(element)))
            root.settings.onAccepted(filePaths)
          }
        }
        else if(root.settings && root.settings.onAccepted)
        {
          root.settings.onAccepted(root.urlToLocalFile(fileDialog.file.toString()))
        }
      }

      onRejected: function()
      {
        if(root.settings && root.settings.onRejected)
          root.settings.onRejected()
      }

      Component.onDestruction: () => close()
    }
  }

  Component
  {
    id: _folderDialogComp
    QLab.FolderDialog
    {
      id: folderDialog

      title: (root.settings && root.settings.title) ? root.settings.title : ""
      folder: (root.settings && root.settings.folder) ? root.settings.folder : ""
      options: (root.settings && root.settings.options) ? root.settings.options : 0

      onAccepted: function()
      {
        if(root.settings && root.settings.onAccepted)
        {
          root.settings.onAccepted(root.urlToLocalFile(folderDialog.folder.toString()))
        }
      }

      onRejected: function()
      {
        if(root.settings && root.settings.onRejected)
          root.settings.onRejected()
      }

      Component.onDestruction: () => close()
    }
  }

  Loader
  {
    id: _dialogLoader
    asynchronous: true
    visible: status == Loader.Ready

    onStatusChanged: function()
    {
      if (_dialogLoader.status == Loader.Ready)
      {
        if(item && item.open)
          item.open()
      }
    }
  } // Loader

  Connections
  {
    ignoreUnknownSignals: true
    target: _dialogLoader.item
    function onClosed() { Qt.callLater(root.close) }
  }

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
    console.log("tolo")
    // 1) Close if already open
    if(_dialogLoader.sourceComponent)
      _dialogLoader.sourceComponent = undefined

    // 2) Keep settings in memory
    settings = null
    context = null
  }

  function showDialog(settings)
  {
    _init(settings)
    _dialogLoader.sourceComponent = _dialogComp
  }

  function showFileDialog(settings)
  {
    _init(settings)
    _dialogLoader.sourceComponent = _fileDialogComp
  }

  function showSaveFileDialog(settings)
  {
    settings.fileMode = QLab.FileDialog.SaveFile
    showFileDialog(settings)
  }

  function showOpenFileDialog(settings)
  {
    settings.fileMode = QLab.FileDialog.OpenFile
    showFileDialog(settings)
  }

  function showOpenFilesDialog(settings)
  {
    settings.fileMode = QLab.FileDialog.OpenFiles
    showFileDialog(settings)
  }

  function showFolderDialog(settings)
  {
    _init(settings)
    _dialogLoader.sourceComponent = _folderDialogComp
  }

  function showTextFieldDialog(settings)
  {
    _init(settings)
    _dialogLoader.sourceComponent = _textFieldDialogComp
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
    {
      if(_dialogLoader.item)
      {
        _dialogLoader.item.close()
      }
      else
      {
        _dialogLoader.sourceComponent = undefined
      }
    }
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
