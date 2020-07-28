import QtQuick 2.0
import QtQml 2.2

import Qaterial 1.0 as Qaterial

Item
{
  id: root
  //Qaterial.DebugRectangle{ anchors.fill: parent}
  implicitWidth: size
  implicitHeight: size

  property int size: 100               // The size of the circle in pixel
  property real arcBegin: 0            // start arc angle in degree
  property real arcEnd: 260         // end arc angle in degree
  property real arcOffset: 0           // rotation
  property bool isPie: false         // paint a pie instead of an arc
  property bool showBackground: false  // a full circle as a background of the arc
  property real lineWidth: 10       // width of the line
  property string colorCircle: Qaterial.Style.accentColor
  property string colorBackground: "#779933"

  onArcBeginChanged: canvas.requestPaint()
  onArcEndChanged: canvas.requestPaint()

  Canvas
  {
    id: canvas
    width: parent.width
    height: parent.height
    rotation: -90 + root.arcOffset

    //Qaterial.DebugRectangle{anchors.fill: parent}

    onPaint:
    {
      let ctx = getContext("2d")

      const alpha = Math.PI * ((root.arcEnd - ((root.arcEnd - root.arcBegin)/2)) / 180)

      const x = width / 2
      const y = height / 2
      const start = Math.PI * (root.arcBegin / 180)
      const end = Math.PI * (root.arcEnd / 180)
      ctx.reset()
      if (root.isPie)
      {
        if (root.showBackground)
        {
            ctx.beginPath()
            ctx.fillStyle = root.colorBackground
            ctx.moveTo(x, y)
            ctx.arc(x, y, root.size / 2, 0, Math.PI * 2, false)
            ctx.lineTo(x, y)
            ctx.fill()
        }
        ctx.beginPath()
        ctx.fillStyle = root.colorCircle
        ctx.moveTo(x, y)
        ctx.arc(x, y, root.size / 2, start, end, false)
        ctx.lineTo(x, y)
        ctx.fill()
      }
      else
      {
        if (root.showBackground)
        {
          ctx.beginPath();
          ctx.arc(x, y, (root.size / 2) - parent.lineWidth / 2, 0, Math.PI * 2, false)
          ctx.lineWidth = root.lineWidth
          ctx.strokeStyle = root.colorBackground
          ctx.stroke()
        }
        ctx.beginPath();
        ctx.arc(x, y, (root.size / 2) - parent.lineWidth / 2, start, end, false)
        ctx.lineWidth = root.lineWidth
        ctx.strokeStyle = root.colorCircle
        ctx.stroke()
      }
    } // OnPaint
  } // canvas
} // Item