import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.Expandable
{
  id: root

  header: Qaterial.ItemDelegate
  {
    id: _header
    text: "Header"
    onClicked: () => root.expanded = !root.expanded

    contentItem: Qaterial.Label
    {
      text: parent.text
      textType: Qaterial.Style.TextType.Title
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
    }

    Qaterial.DebugRectangle
    {
      anchors.fill: parent;
      border.color: Qaterial.Style.green
    }
  }

  delegate: Qaterial.Label
  {
    text: "Delegate"
    textType: Qaterial.Style.TextType.Title
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    height: 100

    Qaterial.DebugRectangle
    {
      anchors.fill: parent;
      border.color: Qaterial.Style.amber
    }
  }
} // Expandable
