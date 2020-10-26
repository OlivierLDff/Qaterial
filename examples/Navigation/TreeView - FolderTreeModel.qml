import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQml 2.14
import Qt.labs.folderlistmodel 2.14 as QFlm

import Qaterial 1.0 as Qaterial

Qaterial.TreeView
{
  id: treeView

  width: 300
  height: parent ? Math.min(contentHeight, parent.height) : contentHeight

  property QtObject selectedElement

  model: Qaterial.FolderTreeModel
  {
    // sortField: Qaterial.FolderTreeModel.Type/Name/Size/Time
    // sortReversed: true
    // sortCaseSensitive: false
    //
    // showDotAndDotDot: true
    // showDrives: false
    // showDirs: false
    // showFiles: false
    // showHidden: true
    // showOnlyReadable: true
    //
    // nameFilters: [ "*.qml", "*.cpp" ]
    // caseSensitive: true
    //
    // path: file:///Path/To/Folder
    Component.onCompleted: () => fetch()
  }

  itemDelegate: Qaterial.ItemDelegate
  {
    id: control

    property QtObject model
    property Qaterial.FolderTreeModel folderTreeModel: model ? model.qtObject : null
    property int depth
    property int index

    height: 24
    leftPadding: depth * 20

    readonly property bool selected: model && model === treeView.selectedElement

    contentItem: RowLayout
    {
      Qaterial.ColorIcon
      {
        source:
        {
          if(!model)
            return ""

          if(model.fileIsDir)
            return control.model.expanded ? Qaterial.Icons.folderOutline : Qaterial.Icons.folder
          if(control.model.fileCompleteSuffix.includes("vcxproj"))
            return Qaterial.Icons.microsoftVisualStudioCode
          if(control.model.fileCompleteSuffix.includes("json"))
            return Qaterial.Icons.codeJson
          if(control.model.fileCompleteSuffix.includes("js"))
            return Qaterial.Icons.nodeJs
          if(control.model.fileCompleteSuffix.includes("qrc"))
            return Qaterial.Icons.database
          return Qaterial.Icons.codeTags
        }
        color:
        {
          if(control.selected || control.hovered)
            return Qaterial.Style.accentColor
          Qaterial.Style.hintTextColor()
        }
        Behavior on rotation { NumberAnimation { duration: 200;easing.type: Easing.OutQuart } }
      }
      Qaterial.Label
      {
        Layout.fillWidth: true
        text: (control.model ? control.model.fileName : "")
        textType: Qaterial.Style.TextType.Caption
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter

        color:
        {
          if(control.selected)
            return Qaterial.Style.accentColor
          if(control.hovered)
            return Qaterial.Style.primaryTextColor()
          return Qaterial.Style.hintTextColor()
        }
      }
    }

    onClicked: function()
    {
      if(model && model.fileIsDir)
      {
        // fetch content of folder if expand is about to happen
        if(!model.expanded)
          folderTreeModel.fetch()

        // Then expand or retract
        model.expanded = !model.expanded
      }
    }
  }
}
