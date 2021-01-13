// Copyright Olivier Le Doeuff 2020 (C)

import QtQml 2.14
import QtQuick 2.14

import Qaterial 1.0 as Qaterial

Qaterial.TreeView
{
  id: treeView

  property alias path: folderTreeModel.path
  property alias nameFilters: folderTreeModel.nameFilters
  property alias caseSensitive: folderTreeModel.caseSensitive
  property alias showDrives: folderTreeModel.showDrives
  property alias showDirs: folderTreeModel.showDirs
  property alias showFiles: folderTreeModel.showFiles
  property alias showDirsFirst: folderTreeModel.showDirsFirst
  property alias showDot: folderTreeModel.showDot
  property alias showDotDot: folderTreeModel.showDotDot
  property alias showDotAndDotDot: folderTreeModel.showDotAndDotDot
  property alias showHidden: folderTreeModel.showHidden
  property alias showOnlyReadable: folderTreeModel.showOnlyReadable
  property alias sortCaseSensitive: folderTreeModel.sortCaseSensitive
  property alias sortReversed: folderTreeModel.sortReversed
  property alias sortField: folderTreeModel.sortField
  property alias status: folderTreeModel.status

  implicitWidth: 300
  implicitHeight: contentHeight

  model: folderTreeModel
  itemDelegate: Qaterial.FolderTreeViewItem {}

  Qaterial.FolderTreeModel
  {
    id: folderTreeModel

    onPathChanged: function() { if(treeView.model === folderTreeModel) fetch() }
    Component.onCompleted: function() { if(treeView.model === folderTreeModel) fetch() }
  }
}
