import QtQuick 2.0
import Qaterial 1.0 as Qaterial
import QtQuick.Shapes 1.14

Qaterial.RectangleAreaHandler
{
  id: root

  start: Qt.vector2d(0.25, 0.25)
  end: Qt.vector2d(0.75, 0.75)

  width: parent.width
  height: parent.height

  handle: Rectangle
  {
    property bool hovered
    color: "#FF9800"

    width: 10
    height: 10

    scale: hovered ? 2 : 1
    Behavior on scale { NumberAnimation { duration: 100 } }

    rotation: 45
    antialiasing: true
  }

  handleLinker: Item
  {
    id: _linker
    property bool horizontal
    property bool hovered

    Shape
    {
      ShapePath
      {
        strokeWidth: hovered ? 4 : 2
        Behavior on strokeWidth { NumberAnimation { duration: 50 } }
        strokeColor: "#FF9800"
        strokeStyle: ShapePath.DashLine
        dashPattern: [1, 4]
        PathLine
        {
          x: horizontal ? _linker.width : 0
          y: horizontal ? 0 : _linker.height
        }
      }
    }
  }

  Column
  {
    anchors.centerIn: parent
    Qaterial.Label { text: `start: {${root.start.x.toFixed(2)},${root.start.y.toFixed(2)}}` }
    Qaterial.Label { text: `end: {${root.end.x.toFixed(2)},${root.end.y.toFixed(2)}}` }
  }
}
