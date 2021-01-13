import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.Expandable
{
  id: root

  header: Qaterial.ItemDelegate
  {
    text: "Header"
    onClicked: () => root.expanded = !root.expanded

    contentItem: Qaterial.LabelHeadline6
    {
      text: parent.text
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
    }

    Qaterial.DebugRectangle
    {
      anchors.fill: parent;
      border.color: Qaterial.Style.green
    }
  }

  delegate: Qaterial.LabelHeadline6
  {
    text: "Delegate"
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
