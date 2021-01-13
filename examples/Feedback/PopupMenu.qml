import QtQuick 2.15
import QtQuick.Controls 2.15

import Qaterial 1.0 as Qaterial

Item
{
  id: root

  implicitWidth: 200
  implicitHeight: column.implicitHeight

  Column
  {
    id: column

    Qaterial.RaisedButton
    {
      width: 200
      text: "Show Top"
      onClicked: () => popup.openAt(mapToItem(Overlay.overlay, width / 2, 0), Item.Bottom)
    }

    Qaterial.RaisedButton
    {
      width: 200
      text: "Show Left"
      onClicked: () => popup.openAt(mapToItem(Overlay.overlay, width, height / 2), Item.Left)
    }

    Qaterial.RaisedButton
    {
      width: 200
      text: "Show Right"
      onClicked: () => popup.openAt(mapToItem(Overlay.overlay, 0, height / 2), Item.Right)
    }

    Qaterial.RaisedButton
    {
      width: 200
      text: "Show Bottom"
      onClicked: () => popup.openAt(mapToItem(Overlay.overlay, width / 2, height), Item.Top)
    }
  }

  Qaterial.PopupMenu
  {
    id: popup

    spacing: 8
    padding: 4

    contentItem: Qaterial.DebugRectangle
    {
      implicitWidth: 200
      implicitHeight: 50

      Qaterial.Label
      {
        anchors.centerIn: parent
        text: "Content Item"
      }
    }
  }
}
