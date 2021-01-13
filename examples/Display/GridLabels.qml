import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Item
{
  height: 100
  width: 200

  Qaterial.GridLabelsX
  {
    y: parent.height
    numberOfLabels: 4
    axisMaxX: 100
    axisMinX: 0
    color: "blue"
  }

  Qaterial.GridLabelsY
  {
    x: parent.width
    numberOfLabels: 4
    axisMaxY: 100
    axisMinY: 0
    color: "red"
  }
}
