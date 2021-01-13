import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  implicitWidth: 200
  implicitHeight: 40

  property int axisMaxX: 100
  property int axisMinX: 0
  property int numberOfLabels: 10
  property color color: Qaterial.Style.foregroundColor

  Repeater
  {
    model: root.numberOfLabels
    Qaterial.Label
    {
      topPadding: 6
      bottomPadding: 6
      x: (index + 1) * root.width / root.numberOfLabels
      text: root.axisMinX + index * (root.axisMaxX - root.axisMinX) / root.numberOfLabels
      color: root.color
    }
  }
}
