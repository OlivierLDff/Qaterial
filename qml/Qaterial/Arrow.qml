import QtQuick 2.14

Item
{
  id: root

  enum Tail
  {
    Flat,
    Arrow,
    FilledArrow
  }

  property vector2d start: Qt.vector2d(0, 0)
  property vector2d end: Qt.vector2d(0, 0)

  property color color
  property Gradient gradient
  property int thickness: 1
  property int headLength: 10

  property int startTail: Arrow.Tail.Flat
  property int endTail: Arrow.Tail.Flat

  readonly property real _startX: start.x
  readonly property real _startY: start.y
  readonly property real _endX: end.x
  readonly property real _endY: end.y

  on_StartXChanged: () => canvas.requestPaint()
  on_StartYChanged: () => canvas.requestPaint()

  on_EndXChanged: () => canvas.requestPaint()
  on_EndYChanged: () => canvas.requestPaint()

  implicitWidth: Math.abs(Math.max(start.x, end.x) - Math.min(start.x, end.x))
  implicitHeight: Math.abs(Math.max(start.y, end.y) - Math.min(start.y, end.y))

  Canvas
  {
    id: canvas
    anchors.fill: root

    function drawLine(ctx, fromx, fromy, tox, toy)
    {
      if(root.gradient)
      {
        let grd = ctx.createLinearGradient(fromx, fromy, tox, toy)
        for(let i = 0; i < root.gradient.stops.length; i++)
        {
          const stop = root.gradient.stops[i]
          grd.addColorStop(stop.position, stop.color)
        }
        ctx.strokeStyle = grd
      }
      else
      {
        ctx.strokeStyle = root.color
      }
      ctx.lineWidth = root.thickness

      ctx.beginPath()
      ctx.moveTo(fromx, fromy)
      ctx.lineTo(tox, toy)
      ctx.stroke()
      ctx.closePath()
    }

    function drawFilledTriangle(ctx, x, y, angle, headlen, color)
    {
      ctx.strokeStyle = color
      ctx.lineWidth = root.thickness
      ctx.fillStyle = color

      //starting a new path from the head of the arrow to one of the sides of the point
      ctx.beginPath()
      ctx.moveTo(x, y)
      ctx.lineTo(x - headlen * Math.cos(angle - Math.PI / 7), y - headlen * Math.sin(angle - Math.PI / 7))

      //path from the side point of the arrow, to the other side point
      ctx.lineTo(x - headlen * Math.cos(angle + Math.PI / 7), y - headlen * Math.sin(angle + Math.PI / 7))

      //path from the side point back to the tip of the arrow, and then again to the opposite side point
      ctx.lineTo(x, y)
      ctx.lineTo(x - headlen * Math.cos(angle - Math.PI / 7), y - headlen * Math.sin(angle - Math.PI / 7))

      //draws the paths created above
      ctx.stroke()
      ctx.fill()
      ctx.closePath()
    }

    function drawArrow(ctx, x, y, angle, headlen, color)
    {
      ctx.strokeStyle = color
      ctx.lineWidth = root.thickness

      //starting a new path from the head of the arrow to one of the sides of the point
      ctx.beginPath()
      ctx.moveTo(x, y)
      ctx.lineTo(x - headlen * Math.cos(angle - Math.PI / 7), y - headlen * Math.sin(angle - Math.PI / 7))

      //path from the side point of the arrow, to the other side point
      ctx.moveTo(x - headlen * Math.cos(angle + Math.PI / 7), y - headlen * Math.sin(angle + Math.PI / 7))

      //path from the side point back to the tip of the arrow, and then again to the opposite side point
      ctx.lineTo(x, y)
      ctx.lineTo(x - headlen * Math.cos(angle - Math.PI / 7), y - headlen * Math.sin(angle - Math.PI / 7))

      //draws the paths created above
      ctx.stroke()
      ctx.closePath()
    }

    onPaint: function()
    {
      let ctx = canvas.getContext('2d')

      const fromx = root.start.x
      const fromy = root.start.y
      const tox = root.end.x
      const toy = root.end.y

      ctx.reset()

      drawLine(ctx, fromx, fromy, tox, toy)

      let startColor = root.color
      let endColor = root.color

      if(root.gradient && root.gradient.stops.length)
      {
        startColor = root.gradient.stops[0].color
        endColor = root.gradient.stops[root.gradient.stops.length - 1].color
      }

      if(root.startTail === Arrow.Tail.FilledArrow)
        drawFilledTriangle(ctx, fromx, fromy, Math.atan2(fromy - toy, fromx - tox), root.headLength, startColor)

      if(root.endTail === Arrow.Tail.FilledArrow)
        drawFilledTriangle(ctx, tox, toy, Math.atan2(toy - fromy, tox - fromx), root.headLength, endColor)

      if(root.startTail === Arrow.Tail.Arrow)
        drawArrow(ctx, fromx, fromy, Math.atan2(fromy - toy, fromx - tox), root.headLength, startColor)

      if(root.endTail === Arrow.Tail.Arrow)
        drawArrow(ctx, tox, toy, Math.atan2(toy - fromy, tox - fromx), root.headLength, endColor)
    }
  }
}
