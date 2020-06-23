import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.RectangleAreaHandler
{
  id: root

  start: Qt.vector2d(0.25, 0.25)
  end: Qt.vector2d(0.75, 0.75)


  Column
  {
    anchors.centerIn: parent
    Qaterial.Label { text: `start: {${root.start.x.toFixed(2)},${root.start.y.toFixed(2)}}` }
    Qaterial.Label { text: `end: {${root.end.x.toFixed(2)},${root.end.y.toFixed(2)}}` }
  }
}