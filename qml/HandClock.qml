import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  property color color: "transparent"
  property int radius: 100
  property int labelSize: (Qaterial.Style.dense ? 24 : 32) * Math.pow(2, 0.5)   //Diagonal Qaterial.Label size
  property alias renderDot: _dot.visible

  implicitWidth: radius*2 + labelSize
  implicitHeight: radius*2 + labelSize

  //Qaterial.DebugRectangle { border.color: "pink"; anchors.fill: parent }

  Rectangle
  {
      anchors.centerIn: parent
      width: root.radius*2
      height: root.radius*2
      radius: width/2
      color: "transparent"

      //Qaterial.DebugRectangle { x: parent.width/2 - width/2; y: -height/2; width: root.labelSize; height: width; border.color: "blue" }

      // Line of the HandClock
      Rectangle
      {
          x: parent.width/2 - width/2
          width: 2
          height: parent.height/2
          color: root.color
          antialiasing: true
      }

      // Central Circle
      Rectangle
      {
          anchors.centerIn: parent
          width: 10
          height: width
          radius: width/2
          color: root.color
      }

      // External circle to pick
      Rectangle
      {
          x: parent.width/2 - width/2
          y: -height/2
          width: root.labelSize-12

          height: width
          radius: width/2
          color: root.color
          antialiasing: true

          // Central Dot for minutes in MinutePicker
          Rectangle
          {
              id: _dot
              anchors.centerIn: parent
              color: "white"
              width: 4
              height: width
              radius: width/2
          }
      }
  }
}
