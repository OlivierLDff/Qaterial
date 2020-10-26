import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Qaterial.LineChart
{
  id: root
  width: 400
  height: 200

  thickness: 3
  color: Qaterial.Style.green

  series: [
    Qt.vector2d(-10, -20),
    Qt.vector2d(10, 12),
    Qt.vector2d(20, 24),
    Qt.vector2d(30, 15),
    Qt.vector2d(40, -26),
    Qt.vector2d(50, 25),
    Qt.vector2d(60, 87),
    Qt.vector2d(70, 32)
  ]

  Qaterial.Label
  {
    text: `minX:${root.minX} | minY:${root.minY} | maxX:${root.maxX} | maxY:${root.maxY}`
  }
}
