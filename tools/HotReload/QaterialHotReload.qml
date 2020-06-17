// Qt
import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import Qt.labs.settings 1.0 as QLab
import QtQuick.Dialogs 1.3 as QQ1D
import Qaterial 1.0 as Qaterial
import QaterialEngine 1.0

Qaterial.ApplicationWindow
{
  id: window

  property string currentFilePath
  property string currentFileUrl
  property string currentFileName: currentFilePath.substring(currentFilePath.lastIndexOf('/')+1)

  property string errorString

  width: 1280
  height: 600
  visible: true
  title: `Qaterial Hot Reload - ${currentFilePath}`

  minimumHeight : 200
  minimumWidth : 200

  function loadFileInLoader(source)
  {
    loader.create(source)
  }

  function loadFile(path)
  {
    QaterialEngine.unWatchFile(window.currentFilePath)
    currentFileUrl = path
    // remove prefixed "file:///"
    if(Qt.platform.os === "windows")
        path = path.replace(/^(file:\/{3})/,"");
    else
        path = path.replace(/^(file:\/{2})/,"");
    // unescape html codes like '%23' for '#'
    currentFilePath = decodeURIComponent(path);
    QaterialEngine.watchFile(window.currentFilePath)

    loader.create(window.currentFileUrl)
  }

  QLab.Settings
  {
      property alias width: window.width
      property alias height: window.height
      property alias x: window.x
      property alias y: window.y
      property alias currentFilePath: window.currentFilePath
      property alias currentFileUrl: window.currentFileUrl
  }

  Shortcut
  {
      sequence: "F5"
      onActivated: () => window.loadFileInLoader(window.currentFileUrl)
  }

  QQ1D.FileDialog
  {
      id: fileDialog
      title: "Please choose a file"
      onAccepted: () => window.loadFile(fileDialog.fileUrl.toString())
  }

  Connections
  {
    target: QaterialEngine
    onWatchedFileChanged: () => window.loadFileInLoader(window.currentFileUrl)
  }

  header: Qaterial.ToolBar
  {
    Row
    {
      Qaterial.AppBarButton
      {
        ToolTip.visible: hovered
        ToolTip.text: "Open File to Hot Reload"
        icon.source: "qrc:/folder-outline.svg"

        onClicked: () => fileDialog.open()
      }
      Qaterial.AppBarButton
      {
        ToolTip.visible: hovered
        ToolTip.text: "Reload (F5)"
        icon.source: "qrc:/sync.svg"

        onClicked: () => window.loadFileInLoader(window.currentFileUrl)
      }
    } // RowLayout
  } // ToolBar

  SplitView
  {
    anchors.fill: parent
    orientation: Qt.Vertical

    Item
    {
      id: loader
      width: parent.width
      SplitView.fillHeight: true
      property var loadedObject: null

      function create(url)
      {
        // Destroy previous item
        if(loadedObject)
        {
          loadedObject.destroy()
          loadedObject = null
        }

        QaterialEngine.clearCache()
        let component = Qt.createComponent(url)

        if (component.status === Component.Ready)
        {
          loadedObject = component.createObject(loader)
          window.errorString = ""
        }
        else
        {
          window.errorString = component.errorString()
        }
      }

      Component.onCompleted: function()
      {
        if(window.currentFileUrl)
        {
          loader.create(window.currentFileUrl)
          QaterialEngine.watchFile(window.currentFilePath)
        }
      }

      Column
      {
        anchors.centerIn: parent
        spacing: 16
        visible: !window.currentFilePath
        Qaterial.Label
        {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Please Pick a qml file to get started"
        }
        Qaterial.RaisedButton
        {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Open File"
          icon.source: "qrc:/folder-outline.svg"

          onClicked: () => fileDialog.open()
        }
      }
    }

    StatusView
    {
      anchors.bottom: parent.bottom
      width: parent.width
      SplitView.minimumHeight: 40

      errorString: window.errorString
      file: window.currentFileName
    } // StatusView
  } // SplitView
} // ApplicationWindow