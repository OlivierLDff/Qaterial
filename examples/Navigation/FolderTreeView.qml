import QtQuick 2.14
import QtQml 2.14

import Qaterial 1.0 as Qaterial

Qaterial.FolderTreeView
{
  id: treeView

  width: 300
  height: parent ? Math.min(contentHeight, parent.height) : contentHeight

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
  path: "file://C:/Users/olivi/Documents/dev/Naostage/Kratos/build/_deps/qaterial-src"

  property QtObject selectedElement

  itemDelegate: Qaterial.FolderTreeViewItem
  {
    highlighted: treeView.selectedElement === model
    onAccepted: function(path)
    {
      console.log(`Accept path ${path}`)
      treeView.selectedElement = model
    }
  }
}
