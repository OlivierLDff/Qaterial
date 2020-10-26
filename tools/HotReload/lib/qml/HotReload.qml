// Copyright Olivier Le Doeuff 2020 (C)

import QtQml 2.14

import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14

import Qt.labs.settings 1.1 as QLab

import Qaterial 1.0 as Qaterial

Qaterial.Page
{
  id: root

  property string currentFolderPath
  property string currentFilePath
  property string currentFileUrl
  property string currentFileName: currentFilePath.substring(currentFilePath.lastIndexOf('/') + 1)

  property bool showFolderExplorer: true

  property
  var currentImportPath: []

  property string errorString

  property int theme: Qaterial.Style.theme

  signal newObjectLoaded()

  implicitWidth: 1280
  implicitHeight: 600

  function loadFileInLoader(source)
  {
    Qaterial.DialogManager.close()
    loader.create(source)
  }

  function reload()
  {
    root.loadFileInLoader(currentFileUrl)
  }

  function loadFile(path)
  {
    Qaterial.HotReload.unWatchFile(root.currentFilePath)
    currentFileUrl = `file:/${path}`
    currentFilePath = path
    Qaterial.HotReload.watchFile(root.currentFilePath)

    loadFileInLoader(root.currentFileUrl)
  }

  QLab.Settings
  {
    id: settings

    category: "General"

    property alias currentFolderPath: root.currentFolderPath
    property alias currentFilePath: root.currentFilePath
    property alias currentFileUrl: root.currentFileUrl
    property alias currentImportPath: root.currentImportPath

    property alias showFolderExplorer: root.showFolderExplorer
    property
    var folderSplitView

    property alias formatHorizontalAlignCenter: formatHorizontalAlignCenter.checked
    property alias formatVerticalAlignCenter: formatVerticalAlignCenter.checked
    property alias formatHorizontalAlignLeft: formatHorizontalAlignLeft.checked
    property alias formatHorizontalAlignRight: formatHorizontalAlignRight.checked
    property alias formatVerticalAlignBottom: formatVerticalAlignBottom.checked
    property alias formatVerticalAlignTop: formatVerticalAlignTop.checked
    property alias fullScreen: fullScreen.checked

    property alias theme: root.theme
  }

  Shortcut
  {
    sequence: "F5"
    onActivated: () => root.reload()
  }

  Shortcut
  {
    sequence: "Ctrl+O"
    onActivated: () => root.openFilePicker()
  }

  function openFilePicker()
  {
    Qaterial.DialogManager.showOpenFileDialog(
    {
      title: "Please choose a file",
      nameFilters: ["Qml Files (*.qml)"],
      onAccepted: function(path)
      {
        root.loadFile(path)
      }
    })
  }

  function openFolderPicker()
  {
    Qaterial.DialogManager.showFolderDialog(
    {
      title: "Please choose a folder",
      onAccepted: function(path)
      {
        root.currentFolderPath = path
        root.showFolderExplorer = true
      }
    })
  }

  Connections
  {
    target: Qaterial.HotReload
    function onWatchedFileChanged() { root.reload() }
  }

  header: Qaterial.ToolBar
  {
    implicitHeight: flow.implicitHeight
    Flow
    {
      id: flow
      width: parent.width - menuButton.implicitWidth
      Qaterial.SquareButton
      {
        ToolTip.visible: hovered || pressed
        ToolTip.text: "Open File to Hot Reload"
        icon.source: Qaterial.Icons.fileOutline
        useSecondaryColor: true

        onClicked: () => root.openFilePicker()
      }

      Qaterial.SquareButton
      {
        ToolTip.visible: hovered || pressed
        ToolTip.text: "Open Folder to Hot Reload"
        icon.source: Qaterial.Icons.folderOutline
        useSecondaryColor: true

        onClicked: () => root.openFolderPicker()
      }

      Qaterial.SquareButton
      {
        ToolTip.visible: hovered || pressed
        ToolTip.text: checked ? "Hide folder explorer" : "Show folder explorer"
        icon.source: Qaterial.Icons.pageLayoutSidebarLeft
        useSecondaryColor: true

        checked: root.showFolderExplorer

        onReleased: () => root.showFolderExplorer = checked
      }

      Qaterial.ToolSeparator {}

      Qaterial.SquareButton
      {
        ToolTip.visible: hovered || pressed
        ToolTip.text: "Reload (F5)"
        icon.source: Qaterial.Icons.sync
        useSecondaryColor: true

        onClicked: () => root.reload()
      }

      Qaterial.SquareButton
      {
        ToolTip.visible: hovered || pressed
        ToolTip.text: "Qml Import Path"
        icon.source: Qaterial.Icons.fileTree
        useSecondaryColor: true

        onClicked: function()
        {
          if(!_importPathMenu.visible)
            _importPathMenu.open()
        }

        ImportPathMenu
        {
          id: _importPathMenu
          y: parent.height

          model: Qaterial.HotReload.importPaths

          function setImportPathsAndReload(paths)
          {
            Qaterial.HotReload.importPaths = paths
            root.currentImportPath = paths
            root.reload()
          }

          onResetPathEntries: function()
          {
            Qaterial.HotReload.importPaths = undefined
            Qaterial.Logger.info(`Reset Path Entries to ${Qaterial.HotReload.importPaths}`)
            root.currentImportPath = Qaterial.HotReload.importPaths.toString()
              .split(',')
            root.reload()
          }

          onAddPathEntry: function(index)
          {
            Qaterial.DialogManager.showTextFieldDialog(
            {
              context: root,
              width: 800,
              title: "Enter Qml import path",
              textTitle: "Path",
              validator: null,
              inputMethodHints: Qt.ImhSensitiveData,
              standardButtons: Dialog.Ok | Dialog.Cancel,
              onAccepted: function(text, acceptable)
              {
                if(index <= -1)
                  index = Qaterial.HotReload.importPaths.length
                Qaterial.Logger.info(`Append Path ${text} at ${index}`)
                let tempPaths = Qaterial.HotReload.importPaths.toString()
                  .split(',')
                tempPaths.splice(index, 0, text)
                _importPathMenu.setImportPathsAndReload(tempPaths)
              },
            })
          }

          onEditPathEntry: function(index)
          {
            Qaterial.DialogManager.showTextFieldDialog(
            {
              context: root,
              width: 800,
              title: "Edit Qml import path",
              textTitle: "Path",
              text: Qaterial.HotReload.importPaths[index],
              validator: null,
              inputMethodHints: Qt.ImhSensitiveData,
              standardButtons: Dialog.Ok | Dialog.Cancel,
              onAccepted: function(text, acceptable)
              {
                Qaterial.Logger.info(`Edit Path ${index} to ${text}`)
                let tempPaths = Qaterial.HotReload.importPaths.toString()
                  .split(',')
                tempPaths.splice(index, 1, text)
                _importPathMenu.setImportPathsAndReload(tempPaths)
              },
            })
          }

          onDeletePathEntry: function(index)
          {
            if(index >= 0 && index < Qaterial.HotReload.importPaths.length)
            {
              Qaterial.DialogManager.showDialog(
              {
                context: root,
                width: 500,
                title: "Warning",
                text: `Are you sure to delete "${Qaterial.HotReload.importPaths[index]}"`,
                iconSource: Qaterial.Icons.alertOutline,
                standardButtons: Dialog.Ok | Dialog.Cancel,
                onAccepted: function()
                {
                  Qaterial.Logger.info(`Remove Path ${Qaterial.HotReload.importPaths[index]}`)
                  let tempPaths = Qaterial.HotReload.importPaths.toString()
                    .split(',')
                  tempPaths.splice(index, 1)
                  _importPathMenu.setImportPathsAndReload(tempPaths)
                }
              })
            }
          }

          onMovePathUp: function(index)
          {
            let tempPaths = Qaterial.HotReload.importPaths.toString()
              .split(',')
            tempPaths.splice(index, 0, tempPaths.splice(index - 1, 1)[0])
            _importPathMenu.setImportPathsAndReload(tempPaths)
          }

          onMovePathDown: function(index)
          {
            let tempPaths = Qaterial.HotReload.importPaths.toString()
              .split(',')
            tempPaths.splice(index, 0, tempPaths.splice(index + 1, 1)[0])
            _importPathMenu.setImportPathsAndReload(tempPaths)
          }
        }
      }

      Qaterial.ToolButton
      {
        id: formatHorizontalAlignCenter

        enabled: !fullScreen.checked && !formatHorizontalAlignLeft.checked && !formatHorizontalAlignRight.checked
        icon.source: Qaterial.Icons.formatHorizontalAlignCenter

        ToolTip.visible: hovered || pressed
        ToolTip.text: "Align Horizontal Center"

        onClicked: () => root.reload()
      }

      Qaterial.ToolButton
      {
        id: formatVerticalAlignCenter

        enabled: !fullScreen.checked && !formatVerticalAlignBottom.checked && !formatVerticalAlignTop.checked
        icon.source: Qaterial.Icons.formatVerticalAlignCenter

        ToolTip.visible: hovered || pressed
        ToolTip.text: "Align Vertical Center"

        onClicked: () => root.reload()
      }

      Qaterial.ToolSeparator {}

      Qaterial.ToolButton
      {
        id: formatHorizontalAlignLeft

        enabled: !fullScreen.checked && !formatHorizontalAlignCenter.checked
        icon.source: Qaterial.Icons.formatHorizontalAlignLeft

        ToolTip.visible: hovered || pressed
        ToolTip.text: "Align Left"

        onClicked: () => root.reload()
      }

      Qaterial.ToolButton
      {
        id: formatHorizontalAlignRight

        enabled: !fullScreen.checked && !formatHorizontalAlignCenter.checked
        icon.source: Qaterial.Icons.formatHorizontalAlignRight

        ToolTip.visible: hovered || pressed
        ToolTip.text: "Align Right"

        onClicked: () => root.reload()
      }

      Qaterial.ToolButton
      {
        id: formatVerticalAlignBottom

        enabled: !fullScreen.checked && !formatVerticalAlignCenter.checked
        icon.source: Qaterial.Icons.formatVerticalAlignBottom

        ToolTip.visible: hovered || pressed
        ToolTip.text: "Align Bottom"

        onClicked: () => root.reload()
      }

      Qaterial.ToolButton
      {
        id: formatVerticalAlignTop

        enabled: !fullScreen.checked && !formatVerticalAlignCenter.checked
        icon.source: Qaterial.Icons.formatVerticalAlignTop

        ToolTip.visible: hovered || pressed
        ToolTip.text: "Align Top"

        onClicked: () => root.reload()
      }

      Qaterial.ToolSeparator {}

      Qaterial.ToolButton
      {
        id: fullScreen

        enabled: !formatHorizontalAlignCenter.checked &&
          !formatVerticalAlignCenter.checked &&
          !formatHorizontalAlignLeft.checked &&
          !formatHorizontalAlignRight.checked &&
          !formatVerticalAlignBottom.checked &&
          !formatVerticalAlignTop.checked
        icon.source: checked ? Qaterial.Icons.fullscreen : Qaterial.Icons.fullscreenExit

        ToolTip.visible: hovered || pressed
        ToolTip.text: checked ? "Fullscreen" : "Fullscreen Exit"

        onClicked: () => root.reload()
      }

      Qaterial.ToolSeparator {}

      Qaterial.SquareButton
      {
        readonly property bool lightTheme: root.theme === Qaterial.Style.Theme.Light
        icon.source: lightTheme ? Qaterial.Icons.weatherSunny : Qaterial.Icons.moonWaningCrescent
        useSecondaryColor: true
        ToolTip.visible: hovered || pressed
        ToolTip.text: lightTheme ? "Theme Light" : "Theme Dark"

        onClicked: function()
        {
          theme = lightTheme ? Qaterial.Style.Theme.Dark : Qaterial.Style.Theme.Light
          Qaterial.Style.theme = theme
        }
      }

      Qaterial.ToolSeparator {}

      Qaterial.SquareButton
      {
        icon.source: Qaterial.Icons.formatLetterCase

        onClicked: function()
        {
          if(!_typoMenu.visible)
            _typoMenu.open()
        }

        TypoMenu
        {
          id: _typoMenu
          y: parent.height
        }

        ToolTip.visible: hovered || pressed
        ToolTip.text: "Typography"
      }

      Qaterial.SquareButton
      {
        contentItem: Item
        {
          Image
          {
            anchors.centerIn: parent
            source: 'qrc:Qaterial/HotReload/material-icons-light.svg'
            sourceSize.width: Qaterial.Style.toolButton.iconWidth
            sourceSize.height: Qaterial.Style.toolButton.iconWidth
          }
        }

        onClicked: function()
        {
          if(!_iconsMenu.visible)
            _iconsMenu.open()
        }

        IconsMenu
        {
          id: _iconsMenu
          y: parent.height
        }

        ToolTip.visible: hovered || pressed
        ToolTip.text: "Icons Explorer"
      }

      Qaterial.SquareButton
      {
        contentItem: Item
        {
          Image
          {
            anchors.centerIn: parent
            source: 'qrc:Qaterial/HotReload/material-palette.png'
          }
        }

        onClicked: function()
        {
          if(!_paletteMenu.visible)
            _paletteMenu.open()
        }

        MaterialPaletteMenu
        {
          id: _paletteMenu
          y: parent.height
        }

        ToolTip.visible: hovered || pressed
        ToolTip.text: "Material Color Palette"
      }

    } // Flow

    Qaterial.AppBarButton
    {
      id: menuButton
      x: parent.width - width
      icon.source: Qaterial.Icons.dotsVertical

      onClicked: function()
      {
        if(!menu.visible)
          menu.open()
      }

      Qaterial.Menu
      {
        id: menu
        y: parent.height

        Qaterial.MenuItem
        {
          icon.source: Qaterial.Icons.earth
          text: "Qaterial Online"
          onClicked: () => Qt.openUrlExternally("https://olivierldff.github.io/QaterialOnline/")
        }

        Qaterial.MenuItem
        {
          icon.source: Qaterial.Icons.helpCircle
          text: "Documentation"
          onClicked: () => Qt.openUrlExternally("https://olivierldff.github.io/Qaterial/")
        }

        Qaterial.MenuItem
        {
          icon.source: Qaterial.Icons.github
          text: "Qaterial on Github"
          onClicked: () => Qt.openUrlExternally("https://github.com/OlivierLDff/Qaterial")
        }
      }
    }
  } // ToolBar

  SplitView
  {
    anchors.fill: parent
    orientation: Qt.Vertical
    SplitView.fillWidth: true

    SplitView
    {
      id: folderSplitView
      orientation: Qt.Horizontal
      SplitView.fillHeight: true
      SplitView.minimumHeight: 100

      Rectangle
      {
        visible: root.showFolderExplorer
        color: Qaterial.Style.theme === Qaterial.Style.Theme.Dark ? "#2A2C30" : "white"
        z: 10

        SplitView.preferredWidth: 200
        SplitView.minimumWidth: 0

        Qaterial.FolderTreeView
        {
          id: treeView
          anchors.fill: parent

          header: Qaterial.Label
          {
            text: treeView.model.fileName
            textType: Qaterial.Style.TextType.Button
            padding: 8
            elide: Text.ElideRight
            width: treeView.width
          }

          ScrollIndicator.vertical: Qaterial.ScrollIndicator {}

          property QtObject selectedElement

          nameFilters: ["*.qml"]
          path: `file:${root.currentFolderPath}`

          itemDelegate: Qaterial.FolderTreeViewItem
          {
            id: control
            highlighted: model && model.filePath === root.currentFilePath
            onAccepted: function(path)
            {
              function urlToLocalFile(url)
              {
                let path = url.toString()
                const isWindows = Qt.platform.os === "windows"
                path = isWindows ? path.replace(/^(file:\/{3})/, "") : path.replace(/^(file:\/{2})/, "")
                return decodeURIComponent(path)
              }
              root.loadFile(urlToLocalFile(path))
            }
          }
        } // TreeView
      } // Pane

      Item
      {
        id: loader
        width: parent.width
        property
        var loadedObject: null
        property url createUrl

        function create(url)
        {
          createUrl = url
          Qaterial.DialogManager.openBusyIndicator({ text: `Loading ${root.currentFileName}` })
          createLaterTimer.start()
        }

        Timer
        {
          id: createLaterTimer
          interval: 230
          onTriggered: () => loader.createLater(loader.createUrl)
        }

        function assignAnchors()
        {
          if(loadedObject.anchors)
          {
            if(fullScreen.checked)
              loadedObject.anchors.fill = loader
            if(formatHorizontalAlignCenter.checked)
              loadedObject.anchors.horizontalCenter = loader.horizontalCenter
            if(formatVerticalAlignCenter.checked)
              loadedObject.anchors.verticalCenter = loader.verticalCenter
            if(formatHorizontalAlignLeft.checked)
              loadedObject.anchors.left = loader.left
            if(formatHorizontalAlignRight.checked)
              loadedObject.anchors.right = loader.right
            if(formatVerticalAlignBottom.checked)
              loadedObject.anchors.bottom = loader.bottom
            if(formatVerticalAlignTop.checked)
              loadedObject.anchors.top = loader.top
          }
        }

        function createLater(url)
        {
          Qaterial.Logger.info(`Load from ${url}`)

          // Destroy previous item
          if(loadedObject)
          {
            loadedObject.destroy()
            loadedObject = null
          }

          Qaterial.HotReload.clearCache()
          let component = Qt.createComponent(url)

          if(component.status === Component.Ready)
          {
            //loadedObject = component.createObject(loader)

            var incubator = component.incubateObject(loader, { visible: false });
            if(incubator.status != Component.Ready)
            {
              incubator.onStatusChanged = function(status)
              {
                if(status == Component.Ready)
                {
                  loadedObject = incubator.object
                  assignAnchors()
                  loadedObject.visible = true
                  Qaterial.DialogManager.close()

                  root.newObjectLoaded()
                }
              }
            }
            else
            {
              loadedObject = incubator.object
              assignAnchors()
              loadedObject.visible = true
              Qaterial.DialogManager.close()

              root.newObjectLoaded()
            }

            root.errorString = ""
          }
          else
          {
            root.errorString = component.errorString()
            Qaterial.Logger.error(`Fail to load with error ${root.errorString}`)
            Qaterial.DialogManager.close()
            root.newObjectLoaded()
          }
        }

        Column
        {
          anchors.centerIn: parent
          spacing: 16
          visible: !root.currentFilePath

          Image
          {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 128
            height: 128
            source: "qrc:/Qaterial/HotReload/code.svg"
          }

          Qaterial.Label
          {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Please Pick a qml file or folder to get started"
          }

          Row
          {
            anchors.horizontalCenter: parent.horizontalCenter

            Qaterial.RaisedButton
            {
              text: "Open File"
              icon.source: Qaterial.Icons.fileOutline

              onClicked: () => root.openFilePicker()
            }

            Qaterial.OutlineButton
            {
              text: "Open Folder"
              icon.source: Qaterial.Icons.folderOutline

              onClicked: () => root.openFolderPicker()
            }
          }
        }
      }
    }

    StatusView
    {
      id: _statusView
      anchors.bottom: parent.bottom
      width: parent.width
      SplitView.minimumHeight: 40

      errorString: root.errorString
      file: root.currentFileName

      Connections
      {
        target: Qaterial.HotReload
        function onNewLog(msg)
        {
          const color = function()
          {
            if(msg.includes("debug"))
              return Qaterial.Style.blue
            if(msg.includes("info"))
              return Qaterial.Style.green
            if(msg.includes("warning"))
              return Qaterial.Style.orange
            if(msg.includes("error"))
              return Qaterial.Style.red
            return Qaterial.Style.primaryTextColor()
          }();

          _statusView.log(msg, color)
        }
      }

      function log(msg, color)
      {
        _statusView.append(`<font style='color:${color};'>${msg}</font>`)
      }
    } // StatusView
  } // SplitView

  Component.onCompleted: function()
  {
    Qaterial.Logger.info(`Load configuration from ${settings.fileName}`)
    folderSplitView.restoreState(settings.folderSplitView)
    Qaterial.Style.theme = root.theme

    if(Qaterial.HotReload.importPaths !== root.currentImportPath)
    {
      if(root.currentImportPath.length)
      {
        Qaterial.Logger.info(`Set qml import path to Qaterial.HotReload.importPaths`)
        Qaterial.HotReload.importPaths = root.currentImportPath
      }
      else
      {
        root.currentImportPath = Qaterial.HotReload.importPaths
      }
    }

    if(root.currentFileUrl)
    {
      loader.create(root.currentFileUrl)
      Qaterial.HotReload.watchFile(root.currentFilePath)
    }
  }

  Component.onDestruction: function()
  {
    settings.folderSplitView = folderSplitView.saveState()
  }
} // ApplicationWindow
