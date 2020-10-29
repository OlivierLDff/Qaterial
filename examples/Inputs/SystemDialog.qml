import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Column
{
  id: root

  width: 220

  function showSaveFile()
  {
    Qaterial.DialogManager.showSaveFileDialog(
    {
      context: root,
      title: qsTr("Save File ..."),
      folder: "file://",
      nameFilters: ["Text file (*.txt)", "Json file (*.json)"],
      onAccepted: (path) => console.log(`Accept path ${path}`),
      onRejected: () => console.log("Reject save file dialog")
    })
  }

  function showOpenFile()
  {
    Qaterial.DialogManager.showOpenFileDialog(
    {
      context: root,
      title: qsTr("Load File ..."),
      folder: "file://",
      nameFilters: ["Text file (*.txt)", "Json file (*.json)"],
      onAccepted: (path) => console.log(`Accept path ${path}`),
      onRejected: () => console.log("Reject open file dialog")
    })
  }

  function showOpenFiles()
  {
    Qaterial.DialogManager.showOpenFilesDialog(
    {
      context: root,
      title: qsTr("Load Files ..."),
      folder: "file://",
      nameFilters: ["Text file (*.txt)", "Json file (*.json)"],
      onAccepted: (paths) => console.log(`Accept path ${paths}`),
      onRejected: () => console.log("Reject open files dialog")
    })
  }

  function showOpenFolder()
  {
    Qaterial.DialogManager.showFolderDialog(
    {
      context: root,
      title: qsTr("Pick Folder ..."),
      folder: "file://",
      onAccepted: (path) => console.log(`Accept folder ${path}`),
      onRejected: () => console.log("Reject folder dialog")
    })
  }

  Qaterial.RaisedButton
  {
    width: parent.width
    text: "Save File Dialog"
    backgroundColor: Qaterial.Style.blue
    icon.source: Qaterial.Icons.contentSaveOutline

    onClicked: () => root.showSaveFile()
  }
  Qaterial.RaisedButton
  {
    width: parent.width
    text: "Open File Dialog"
    backgroundColor: Qaterial.Style.green
    icon.source: Qaterial.Icons.fileOutline

    onClicked: () => root.showOpenFile()
  }
  Qaterial.RaisedButton
  {
    width: parent.width
    text: "Open Files Dialog"
    backgroundColor: Qaterial.Style.orange
    icon.source: Qaterial.Icons.fileMultipleOutline

    onClicked: () => root.showOpenFiles()
  }
  Qaterial.RaisedButton
  {
    width: parent.width
    text: "Open Folder Dialog"
    backgroundColor: Qaterial.Style.pink
    icon.source: Qaterial.Icons.folderOutline

    onClicked: () => root.showOpenFolder()
  }
}
