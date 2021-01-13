import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.RectangleAreaHandler
{
  id: root

  start: Qt.vector2d(0.25, 0.25)
  end: Qt.vector2d(0.75, 0.75)

  //margin: 16
  inMargin: _inMargin.value
  outMargin: _outMargin.value
  handleSize: _handleSize.value

  width: parent.width
  height: parent.height

  handleColor: "black"

  // Outside Handler + grab margin
  Rectangle
  {
    x: root.realStartX - root.outHalfHandleSize
    y: root.realStartY - root.outHalfHandleSize

    width: root.realEndX - x + root.outHalfHandleSize
    height: root.realEndY - y + root.outHalfHandleSize

    color: Qaterial.Style.blue
    z: -1
  }

  // Outside Handler
  Rectangle
  {
    x: root.realStartX - root.handleSize / 2
    y: root.realStartY - root.handleSize / 2

    width: root.realEndX - x + root.handleSize / 2
    height: root.realEndY - y + root.handleSize / 2

    color: Qaterial.Style.lime
    z: -1
  }

  // Inside Handler
  Rectangle
  {
    x: root.realStartX + root.handleSize / 2
    y: root.realStartY + root.handleSize / 2

    width: root.realEndX - x - root.handleSize / 2
    height: root.realEndY - y - root.handleSize / 2

    color: Qaterial.Style.orange
    z: -1
  }

  // Inside Handler + grab margin
  Rectangle
  {
    x: root.realStartX + root.inHalfHandleSize
    y: root.realStartY + root.inHalfHandleSize

    width: root.realEndX - x - root.inHalfHandleSize
    height: root.realEndY - y - root.inHalfHandleSize

    color: Qaterial.Style.deepPurple
    z: -1
  }

  Column
  {
    anchors.centerIn: parent
    Qaterial.SliderDelegate
    {
      id: _outMargin
      from: 0
      to: 50
      value: 16
      text: "outMargin"
      secondaryText: value.toFixed(0)
    }
    Qaterial.SliderDelegate
    {
      id: _inMargin
      from: 0
      to: 50
      value: 8
      text: "inMargin"
      secondaryText: value.toFixed(0)
    }
    Qaterial.SliderDelegate
    {
      id: _handleSize
      from: 0
      to: 50
      value: 32
      text: "handleSize"
      secondaryText: value.toFixed(0)
    }
  }

}
