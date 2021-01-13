import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Canvas
{
  // Series of vector2d that will be displayed
  property
  var series: []

  property color color: Qaterial.Style.accentColor
  property int thickness: 2

  property int maxX: valueMaxX()
  property int maxY: valueMaxY()
  property int minX: valueMinX()
  property int minY: valueMinY()

  function valueMaxX()
  {
    let max = -Infinity
    for(let i = 0; i < series.length; i++)
    {
      if(series[i].x > max)
        max = series[i].x;
    }
    return max
  }

  function valueMaxY()
  {
    let max = -Infinity
    for(let i = 0; i < series.length; i++)
    {
      if(series[i].y > max)
        max = series[i].y;
    }
    return max
  }

  function valueMinX()
  {
    let min = +Infinity
    for(let i = 0; i < series.length; i++)
    {
      if(series[i].x < min)
        min = series[i].x;
    }
    return min
  }

  function valueMinY()
  {
    let min = +Infinity
    for(let i = 0; i < series.length; i++)
    {
      if(series[i].y < min)
        min = series[i].y;
    }
    return min
  }

  implicitWidth: 200
  implicitHeight: 100

  onPaint: function()
  {
    if(!series || series.length <= 0)
      return

    // todo : reorder series for draw

    let ctx = getContext('2d');

    ctx.reset()
    ctx.strokeStyle = color
    ctx.lineWidth = thickness
    ctx.beginPath()

    const startX = (series[0].x - minX) * width / (maxX - minX)
    const startY = (maxY - series[0].y) * height / (maxY - minY)
    ctx.moveTo(startX, startY)

    for(let i = 1; i < series.length; ++i)
    {
      const lineX = (series[i].x - minX) * width / (maxX - minX)
      const lineY = (maxY - series[i].y) * height / (maxY - minY)
      ctx.lineTo(lineX, lineY);
    }

    ctx.stroke();
  }
} // Canvas
