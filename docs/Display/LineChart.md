---
layout: default
title: Charts
---

# Charts

## LineChart

Display a graph from an array of `Qt.vector2d` called `series`.

## Example
![image](https://user-images.githubusercontent.com/66482761/87764698-14fab880-c817-11ea-8900-8f6156079cae.png)

``` js
Qaterial.LineChart
{
  id: _lineChart
  width: 400
  height: 200
  thickness: 3
  color: "cyan"

  series: 
  [
    Qt.vector2d(-10,-20),
    Qt.vector2d(10,12),
    Qt.vector2d(20,24),
    Qt.vector2d(30,15),
    Qt.vector2d(40,-26),
    Qt.vector2d(50,25),
    Qt.vector2d(60,87),
    Qt.vector2d(70,32)
  ]
}
```

## Properties

`series`: a tab of `Qt.vector2d()` used to create the chartLine points
`thickness`: define the color of the line *(default: 1)*
`color`: define the color of the line *(default: `Qaterial.Style.AccentColor`)*
