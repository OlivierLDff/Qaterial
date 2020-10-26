import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.RectangleAreaHandler
{
  id: root

  start: Qt.vector2d(0.25, 0.25)
  end: Qt.vector2d(0.75, 0.75)

  //margin: 16
  inMargin: 8
  outMargin: 16
  handleSize: 32

  minSize: Qt.vector2d(0, 0)

  reverseAllowed: true
  horizontalReverseAllowed: reverseAllowed
  verticalReverseAllowed: reverseAllowed

  width: parent.width
  height: parent.height

  onMoved: (start, end) => console.log(`moved start: ${start}, end: ${end}`)

  // Zone determined with start and end
  Qaterial.DebugRectangle
  {
    x: root.realStartX
    y: root.realStartY

    width: root.realEndX - x
    height: root.realEndY - y

    border.color: "green"
  }

  // Inside Handler
  Qaterial.DebugRectangle
  {
    x: root.realStartX + root.handleSize / 2
    y: root.realStartY + root.handleSize / 2

    width: root.realEndX - x - root.handleSize / 2
    height: root.realEndY - y - root.handleSize / 2

    border.color: "red"
  }

  // Outside Handler
  Qaterial.DebugRectangle
  {
    x: root.realStartX - root.handleSize / 2
    y: root.realStartY - root.handleSize / 2

    width: root.realEndX - x + root.handleSize / 2
    height: root.realEndY - y + root.handleSize / 2

    border.color: "red"
  }

  // Outside Handler + grab margin
  Qaterial.DebugRectangle
  {
    x: root.realStartX - root.outHalfHandleSize
    y: root.realStartY - root.outHalfHandleSize

    width: root.realEndX - x + root.outHalfHandleSize
    height: root.realEndY - y + root.outHalfHandleSize

    border.color: "violet"
  }

  // Inside Handler + grab margin
  Qaterial.DebugRectangle
  {
    x: root.realStartX + root.inHalfHandleSize
    y: root.realStartY + root.inHalfHandleSize

    width: root.realEndX - x - root.inHalfHandleSize
    height: root.realEndY - y - root.inHalfHandleSize

    border.color: "violet"
  }

  Column
  {
    anchors.centerIn: parent
    Qaterial.Label { text: `start: {${root.start.x.toFixed(2)},${root.start.y.toFixed(2)}}` }
    Qaterial.Label { text: `end: {${root.end.x.toFixed(2)},${root.end.y.toFixed(2)}}` }
  }
}
