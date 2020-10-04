import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  property real leftPadding
  property real rightPadding
  property real spacing
  property int columns

  readonly property int paddingLessWidth: root.width - root.leftPadding - root.rightPadding
  readonly property real oneBlockSize: Math.floor(paddingLessWidth-(root.columns-1)*root.spacing)/root.columns

  Repeater
  {
    anchors.fill: parent
    model: root.columns > 0 ? root.columns-1 : 0
    delegate: Rectangle
    {
      x: root.leftPadding + root.oneBlockSize*(index+1) + root.spacing*index
      height: parent.height
      width: root.spacing
      color: Qaterial.Colors.cyan
    }
  }

  Repeater
  {
    anchors.fill: parent
    model: root.columns > 0 ? root.columns : 0
    delegate: Rectangle
    {
      x: root.leftPadding + root.oneBlockSize*(index) + root.spacing*index
      height: parent.height
      width: root.oneBlockSize
      color: Qaterial.Colors.red
    }
  }

  Rectangle
  {
    height: parent.height
    width: root.leftPadding
    color: Qaterial.Colors.green
  }

  Rectangle
  {
    x: parent.width - width
    height: parent.height
    width: root.leftPadding
    color: Qaterial.Colors.green
  }
}
