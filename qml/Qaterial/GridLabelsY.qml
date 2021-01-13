import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  implicitWidth: 50
  implicitHeight: 100

  property int numberOfLabels: 4
  property int axisMaxY: 100
  property int axisMinY: 0
  property color color: Qaterial.Style.foregroundColor

  Repeater
  {
    model: root.numberOfLabels
    Qaterial.Label
    {
      rightPadding: 10
      leftPadding: 10
      y: index * root.height / root.numberOfLabels - height / 2
      text: root.axisMaxY - index * (root.axisMaxY - root.axisMinY) / root.numberOfLabels
      color: root.color
    }
  }
}
