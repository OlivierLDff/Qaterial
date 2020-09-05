import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.Expandable
{
  id: root

  header: Qaterial.ItemDelegate
  {
    height: 32
    backgroundColor: Qaterial.Style.orange
    onClicked: () => root.expanded = !root.expanded
  }

  delegate: Rectangle
  {
    height: 64
    color: Qaterial.Style.teal
  }

  animation: NumberAnimation
  {
    duration: 1000
    easing.type: Easing.OutCirc
  }
} // Expandable
