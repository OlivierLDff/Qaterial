/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.14
import QtQml 2.12
import Qt.labs.platform 1.1 as QLab
// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  property
  var settings: null
  property QtObject context
  onContextChanged: function()
  {
    if(_protectPopStack)
      return

    if(!context)
      _popStack()
  }
  property bool _protectPopStack
  property
  var stackSettings: null
  property Component stackComponent

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
      text: root.settings && root.settings.text ? root.settings.text : ""
      title: root.settings && root.settings.title ? root.settings.title : ""
      iconSource: root.settings && root.settings.iconSource ? root.settings.iconSource : ""
      iconColor: root.settings && root.settings.iconColor ? root.settings.iconColor : Qaterial.Style.accentColor
      standardButtons: root.settings && root.settings.standardButtons ? root.settings.standardButtons : Dialog.NoButton

      onAccepted: function()
      {
        if(root.settings && root.settings.onAccepted)
          root.settings.onAccepted()

        if(root.settings && root.settings.acceptedCallback)
        {
          Qaterial.Logger.warn(
            "You are using deprecated 'acceptedCallback'. You should consider moving to 'onAccepted'")
          root.settings.acceptedCallback()
        }
      }

      onApplied: function()
      {
        if(root.settings && root.settings.onApplied)
          root.settings.onApplied()

        if(root.settings && root.settings.appliedCallback)
        {
          Qaterial.Logger.warn(
            "You are using deprecated 'appliedCallback'. You should consider moving to 'onApplied'")
          root.settings.appliedCallback()
        }
      }

      onHelpRequested: function()
      {
        if(root.settings && root.settings.onHelpRequested)
          root.settings.onHelpRequested()

        if(root.settings && root.settings.helpRequestedCallback)
        {
          Qaterial.Logger.warn(
            "You are using deprecated 'helpRequestedCallback'. You should consider moving to 'onHelpRequested'")
          root.settings.helpRequestedCallback()
        }
      }

      onRejected: function()
      {
        if(root.settings && root.settings.onRejected)
          root.settings.onRejected()

        if(root.settings && root.settings.rejectedCallback)
        {
          Qaterial.Logger.warn(
            "You are using deprecated 'rejectedCallback'. You should consider moving to 'onRejected'")
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
      id: textFieldDialog
      text: root.settings && root.settings.text ? root.settings.text : ""
      title: root.settings && root.settings.title ? root.settings.title : ""
      textTitle: root.settings && root.settings.textTitle ? root.settings.textTitle : ""
      placeholderText: root.settings && root.settings.placeholderText ? root.settings.placeholderText : ""
      helperText: root.settings && root.settings.helperText ? root.settings.helperText : ""
      validator: root.settings && root.settings.validator ? root.settings.validator : null
      inputMethodHints: root.settings && root.settings.inputMethodHints ? root.settings.inputMethodHints : 0
      maximumLengthCount: root.settings && root.settings.maximumLengthCount ? root.settings.maximumLengthCount : 32767
      selectAllText: root.settings && root.settings.selectAllText ? root.settings.selectAllText : false
      errorText: root.settings && root.settings.errorText ? root.settings.errorText : ""
      echoMode: root.settings && root.settings.echoMode ? root.settings.echoMode : TextInput.Normal
      standardButtons: root.settings && root.settings.standardButtons ? root.settings.standardButtons : Dialog.NoButton
      dialogImplicitWidth: root.settings && root.settings.width ? root.settings.width : Qaterial.Style.dialog
        .implicitWidth

      onAccepted: function()
      {
        if(root.settings && root.settings.onAccepted)
          root.settings.onAccepted(text, acceptableInput && !error)

        if(root.settings && root.settings.acceptedCallback)
        {
          Qaterial.Logger.warn(
            "You are using deprecated 'acceptedCallback'. You should consider moving to 'onAccepted'")
          root.settings.acceptedCallback(text, acceptableInput && !error)
        }
      }

      onApplied: function()
      {
        if(root.settings && root.settings.onApplied)
          root.settings.onApplied()

        if(root.settings && root.settings.appliedCallback)
        {
          Qaterial.Logger.warn(
            "You are using deprecated 'appliedCallback'. You should consider moving to 'onApplied'")
          root.settings.appliedCallback()
        }
      }

      onHelpRequested: function()
      {
        if(root.settings && root.settings.onHelpRequested)
          root.settings.onHelpRequested()

        if(root.settings && root.settings.helpRequestedCallback)
        {
          Qaterial.Logger.warn(
            "You are using deprecated 'helpRequestedCallback'. You should consider moving to 'onHelpRequested'")
          root.settings.helpRequestedCallback()
        }
      }

      onRejected: function()
      {
        if(root.settings && root.settings.onRejected)
          root.settings.onRejected()

        if(root.settings && root.settings.rejectedCallback)
        {
          Qaterial.Logger.warn(
            "You are using deprecated 'rejectedCallback'. You should consider moving to 'onRejected'")
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
      text: root.settings && root.settings.text ? root.settings.text : ""
      standardButtons: root.settings && root.settings.standardButtons ? root.settings.standardButtons : Dialog.NoButton

      onAccepted: function()
      {
        if(root.settings && root.settings.onAccepted)
          root.settings.onAccepted()

        if(root.settings && root.settings.acceptedCallback)
        {
          Qaterial.Logger.warn(
            "You are using deprecated 'acceptedCallback'. You should consider moving to 'onAccepted'")
          root.settings.acceptedCallback()
        }
      }

      onApplied: function()
      {
        if(root.settings && root.settings.onApplied)
          root.settings.onApplied()

        if(root.settings && root.settings.appliedCallback)
        {
          Qaterial.Logger.warn(
            "You are using deprecated 'appliedCallback'. You should consider moving to 'onApplied'")
          root.settings.appliedCallback()
        }
      }

      onHelpRequested: function()
      {
        if(root.settings && root.settings.onHelpRequested)
          root.settings.onHelpRequested()

        if(root.settings && root.settings.helpRequestedCallback)
        {
          Qaterial.Logger.warn(
            "You are using deprecated 'helpRequestedCallback'. You should consider moving to 'onHelpRequested'")
          root.settings.helpRequestedCallback()
        }
      }

      onRejected: function()
      {
        if(root.settings && root.settings.onRejected)
          root.settings.onRejected()

        if(root.settings && root.settings.rejectedCallback)
        {
          Qaterial.Logger.warn(
            "You are using deprecated 'rejectedCallback'. You should consider moving to 'onRejected'")
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

      Component.onCompleted:
      {
        if(root.settings && (root.settings.standardButtons !== undefined))
          standardButtons = root.settings.standardButtons

        if(!model)
          console.log("Error : RadioListViewDialog : model is null on open")
      }
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
      if(_dialogLoader.status == Loader.Ready)
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
    function onClosed()
    {
      Qt.callLater(root._popStack)
    }
  }

  function show(settings, comp)
  {
    close()

    if(_dialogLoader.sourceComponent)
    {
      root.stackComponent = comp
      root.stackSettings = settings
    }
    else
    {
      root._show(settings, comp)
    }
  }

  function close()
  {
    root.stackComponent = null
    root.stackSettings = null

    if(_dialogLoader.item)
    {
      // Try to properly close the item if a 'close' function is available (and a closed signal)
      // Otherwise destroy the component
      if(_dialogLoader.item.close && _dialogLoader.item.closed)
        _dialogLoader.item.close()
      else
        forceClose()
    }
    else if(_dialogLoader.sourceComponent)
    {
      forceClose()
    }
  }

  function forceClose()
  {
    // SourceComponent is still in incubation, delete it now
    _dialogLoader.sourceComponent = undefined
  }

  function _show(settings, comp)
  {
    // Assign setttings
    root.settings = settings

    _protectPopStack = true
    // Assign context
    if(settings && settings.context)
    {
      if(settings.context instanceof QtObject)
      {
        root.context = settings.context
      }
      else
      {
        Qaterial.Logger.warn(`${settings.context} isn't an instance of QtObject. It can't be used as a dialog context.`)
        root.context = null
      }
    }
    else
    {
      root.context = null
    }
    _protectPopStack = false

    _dialogLoader.sourceComponent = comp
  }

  function _popStack()
  {
    root._show(root.stackSettings, root.stackComponent)
    root.stackComponent = null
    root.stackSettings = null
  }

  function showDialog(settings)
  {
    show(settings, _dialogComp)
  }

  function showFileDialog(settings)
  {
    show(settings, _fileDialogComp)
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
    show(settings, _folderDialogComp)
  }

  function showTextFieldDialog(settings)
  {
    show(settings, _textFieldDialogComp)
  }

  function openWithSettings(settings)
  {
    Qaterial.Logger.warn("'DialogLoader.openWithSettings' is deprecated, consider moving to 'showDialog'")
    showDialog(settings)
  }

  function openTextField(settings)
  {
    showTextFieldDialog(settings)
  }

  function openBusyIndicator(settings)
  {
    show(settings, _busyIndicatorDialogComp)
  }

  function closeBusyIndicator()
  {
    // this is too yolo, showBusyIndicator should returned a pointer or a handle
    if(_dialogLoader.sourceComponent && _dialogLoader.sourceComponent === _busyIndicatorDialogComp)
      root.close()
  }

  function openRadioListView(settings)
  {
    show(settings, _radioListViewComp)
  }

  function openFromComponent(comp)
  {
    show(null, comp)
  }
} // Item
