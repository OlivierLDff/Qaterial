---
layout: default
title: Rectangle Area Handler
---

# Rectangle Area Handler

![RectangleAreaHandlerDemo](https://user-images.githubusercontent.com/17255804/85398203-283aa100-b555-11ea-921b-12772e3a1bf7.gif)

The `RectangleAreaHandler` allow easy manipulation of a `start` and `end` **vector2d**. It can be used as an handler to select a particular area, to crop an image, etc...

`start` and `end` are always normalized for easy manipulation. The real coordinate are available with `realStartX`, `realStartY`, `realEndX`, `realEndY`.

By default the size of the handler is undefined, so it is made to fill another Item.

```js
import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Rectangle
{
	width: 200
	height: 200
	
	Qaterial.RectangleAreaHandler
	{
		anchors.fill: parent
        
        onMoved: (start, end) => console.log(`moved start: ${start}, end: ${end}`)
	}
}
```

[Try it live](https://tinyurl.com/yb2m7lgh)

## Size, margin

The size of each handle is determined by `handleSize`. This will determine the **red** area in the following example. For more natural grabbing, a zone inside and inside can be added with `margin`. This in displayed in **pink** in the example.

![RectangleAreaHandlerMargin](https://user-images.githubusercontent.com/17255804/85397999-d2fe8f80-b554-11ea-80b0-06de10aa155c.gif)

[Try it here](https://tinyurl.com/yc5z57e3)

## Customization

A `RectangleAreaHandler` is made a 4 `handle` and 4 `handleLinker` that can be customized. 

![RectangleAreaHandlerCustomizedDemo](https://user-images.githubusercontent.com/17255804/85398291-4c967d80-b555-11ea-9db0-28b3c302a7ee.gif)

* `handle`: x, y, width, height are set by the loader. It should have a `hovered` property.
* `handleLinked`: x, y are set by the loader. It should have a `hovered` and `horizontal` property.
  * When `horizontal` is **true**, `width` is set by loader, `height` should be set by the item.
  * When `horizontal` is **false**, `height` is set by loader, `width` should be set by the item.

```js
import QtQuick 2.0
import Qaterial 1.0 as Qaterial
import QtQuick.Shapes 1.14

Qaterial.RectangleAreaHandler
{
  id: root
  
  handle: Rectangle
  {
    property bool hovered
    color: "#FF9800"

    width: 10
    height: 10

    scale: hovered ? 2 : 1
    Behavior on scale { NumberAnimation { duration: 100 } }

    rotation: 45
    antialiasing: true
  }

  handleLinker: Item
  {
    id: _linker
    property bool horizontal
    property bool hovered

    Shape
    {
      ShapePath
      {
        strokeWidth: hovered ? 4 : 2
        Behavior on strokeWidth { NumberAnimation { duration: 50 } }
        strokeColor: "#FF9800"
        strokeStyle: ShapePath.DashLine
        dashPattern: [ 1, 4 ]
        PathLine
        {
          x: horizontal ? _linker.width : 0
          y: horizontal ? 0 : _linker.height
        }
      }
    }
  }
}
```

