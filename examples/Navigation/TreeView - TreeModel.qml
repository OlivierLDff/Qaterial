import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQml 2.14

import Qaterial 1.0 as Qaterial

Qaterial.TreeView
{
  id: root

  width: 300
  height: parent ? Math.min(contentHeight, parent.height) : contentHeight

  property QtObject selectedElement

  model: Qaterial.TreeModel
  {
    Qaterial.TreeElement
    {
      text: "Applications"
      Qaterial.TreeElement { text: "Calendar" }
      Qaterial.TreeElement { text: "Chrome" }
      Qaterial.TreeElement { text: "Webstorm" }
    }
    Qaterial.TreeElement
    {
      text: "Documents"
      Qaterial.TreeElement { text: "OSS" }
      Qaterial.TreeElement
      {
        text: "Qaterial"
        Qaterial.TreeElement
        {
          text: "src"
          Qaterial.TreeElement { text: "main.cpp" }
        }
        Qaterial.TreeElement
        {
          text: "qml"
          Qaterial.TreeElement { text: "main.qml" }
          Qaterial.TreeElement { text: "main.qrc" }
        }
        Qaterial.TreeElement { text: "CMakeLists.txt" }
      }
    }
  }

  itemDelegate: Qaterial.ItemDelegate
  {
    id: control

    property QtObject model
    property int depth
    property int index

    height: 24
    leftPadding: depth * 20

    contentItem: RowLayout
    {
      Qaterial.ColorIcon
      {
        source: Qaterial.Icons.chevronRight
        color: Qaterial.Style.primaryTextColor()
        visible: control.model && control.model.children && control.model.children.count
        Binding on rotation
        {
          when: control.model && control.model.expanded
          value: 90
          restoreMode: Binding.RestoreBindingOrValue
        }
        Behavior on rotation { NumberAnimation { duration: 200;easing.type: Easing.OutQuart } }
      }
      Qaterial.Label
      {
        Layout.fillWidth: true
        text: control.model ? control.model.text : ""
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
        Binding on color
        {
          when: model === root.selectedElement
          value: Qaterial.Style.accentColor
        }
      }
    }

    onClicked: function()
    {
      if(model.children.count !== 0)
        model.expanded = !model.expanded
      else
        root.selectedElement = model
    }
  }
}
