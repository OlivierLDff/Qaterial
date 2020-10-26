import QtQuick 2.14
import QtQml 2.14

import Qaterial 1.0 as Qaterial

Qaterial.Expandable
{
  id: root

  property string modelRole: "model"
  property string depthRole: "depth"
  property string indexRole: "index"
  property string childrenRole: "children"

  property Component treeViewItem

  readonly property QtObject modelChildren: model[root.childrenRole]
  readonly property int depth: ListView.view.depth + 1

  expanded: model.expanded
  delegate: modelChildren && modelChildren.count ? listViewComponent : null

  Binding
  {
    target: root.headerItem
    when: root.headerItem && root.headerItem.hasOwnProperty(root.modelRole)
    property: root.modelRole
    value: model
    restoreMode: Binding.RestoreNone
  }

  Binding
  {
    target: root.headerItem
    when: root.headerItem && root.headerItem.hasOwnProperty(root.indexRole)
    property: root.indexRole
    value: index
    restoreMode: Binding.RestoreNone
  }

  Binding
  {
    target: root.headerItem
    when: root.headerItem && root.headerItem.hasOwnProperty(root.depthRole)
    property: root.depthRole
    value: root.depth
    restoreMode: Binding.RestoreNone
  }

  Component
  {
    id: listViewComponent
    ListView
    {
      readonly property int depth: root.depth
      interactive: false
      height: contentHeight
      model: root.modelChildren
      delegate: root.treeViewItem

      // todo : loader treeViewBorder
    }
  }
}
