import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.Expandable
{
  id: root

  header: Qaterial.ItemDelegate
  {
    id: _header
    width: root.width

    icon.source: Qaterial.Icons.account
    text: "Header"
    secondaryText: `expanded: ${root.expanded}`

    onClicked: () => root.expanded = !root.expanded

    Qaterial.DebugRectangle { anchors.fill: parent;
      border.color: "#E91E63" }
  } // Rectangle

  delegate: Column
  {
    Repeater
    {
      id: _repeater

      model: ListModel
      {
        ListElement { icon: "numeric-1-circle-outline";color: "#2196F3" }
        ListElement { icon: "numeric-2-circle-outline";color: "#4CAF50" }
        ListElement { icon: "numeric-3-circle-outline";color: "#f44336" }
      } // ListModel

      delegate: Qaterial.ItemDelegate
      {
        width: root.width

        text: `Delegate ${index}`
        icon.source: `qrc:/Qaterial/Icons/${model.icon}.svg`

        Qaterial.DebugRectangle { anchors.fill: parent;
          border.color: model.color }

        onClicked: () => Qaterial.Logger.debug(`Element ${index+1} clicked`)
      } // ItemDelegate
    } // Repeater
  } // Item
} // Expandable
