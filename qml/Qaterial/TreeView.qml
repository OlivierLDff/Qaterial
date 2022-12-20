import QtQuick
import QtQml 2.14
import Qaterial as Qaterial

ListView
{
  id: root

  property Component itemDelegate

  property string modelRole: "model"
  property string depthRole: "depth"
  property string indexRole: "index"
  property string childrenRole: "children"

  readonly property int depth: -1

  Component
  {
    id: treeViewItemComponent

    Qaterial.TreeViewItem
    {
      id: expandable

      width: root.width

      modelRole: root.modelRole
      depthRole: root.depthRole
      indexRole: root.indexRole
      childrenRole: root.childrenRole

      header: root.itemDelegate
      treeViewItem: treeViewItemComponent
    }
  }

  delegate: treeViewItemComponent
}
