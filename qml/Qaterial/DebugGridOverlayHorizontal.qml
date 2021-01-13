import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  property real topPadding
  property real bottomPadding
  property real spacing
  property int columns

  readonly property int paddingLessHeight: root.height - root.topPadding - root.bottomPadding
  readonly property real oneBlockSize: Math.floor(paddingLessHeight - (root.columns - 1) * root.spacing) / root.columns

  Repeater
  {
    anchors.fill: parent
    model: root.columns > 0 ? root.columns - 1 : 0
    delegate: Rectangle
    {
      y: root.topPadding + root.oneBlockSize * (index + 1) + root.spacing * index
      width: parent.width
      height: root.spacing
      color: Qaterial.Colors.cyan
    }
  }

  Repeater
  {
    anchors.fill: parent
    model: root.columns > 0 ? root.columns : 0
    delegate: Rectangle
    {
      y: root.topPadding + root.oneBlockSize * (index) + root.spacing * index
      width: parent.width
      height: root.oneBlockSize
      color: Qaterial.Colors.red
    }
  }

  Rectangle
  {
    width: parent.width
    height: root.topPadding
    color: Qaterial.Colors.green
  }

  Rectangle
  {
    y: parent.height - height
    width: parent.width
    height: root.topPadding
    color: Qaterial.Colors.green
  }
}
