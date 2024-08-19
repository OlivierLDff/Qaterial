---
layout: default
title: 🔲 Rectangle Area Handler
---

# 🔲 Rectangle Area Handler

![RectangleAreaHandlerDemo](https://user-images.githubusercontent.com/17255804/85398203-283aa100-b555-11ea-921b-12772e3a1bf7.gif)

The `RectangleAreaHandler` allow easy manipulation of a `start` and `end` **vector2d**. It can be used as an handler to select a particular area, to crop an image, etc...

`start` and `end` are always normalized for easy manipulation (ie value are in between 0 and 1). The real coordinate are available with `realStartX`, `realStartY`, `realEndX`, `realEndY`.

By default the size of the handler is undefined. It should fill a parent.

```js
import QtQuick
import Qaterial as Qaterial

Rectangle
{
  width: 200
  height: 200

  Qaterial.RectangleAreaHandler
  {
    // Selected area will be render in 200x200 parent
    anchors.fill: parent

    // Default start point will be 50px, 50px
    start: Qt.vector2d(0.25, 0.25)
    // Default end point will be 150px, 150px
    end: Qt.vector2d(0.75, 0.75)

    onMoved: (start, end) => console.log(`moved start: ${start}, end: ${end}`)
  }
}
```

[Try it live](https://tinyurl.com/yb2m7lgh)

## Behavior

The `RectangleAreaHandler` behavior can be customized in many ways.

* Grabbing area that can be controlled with `inMargin`, `outMargin`, `handleSize`
* Allow to reverse the rectangle with `reverseAllowed`, `horizontalReverseAllowed`, `verticalReverseAllowed`.
* Specify a minimum area with `minSize`. *Note: When using `minSize`, it automatically disable `reverse` behavior*.

### Grabbing Area

![AreaGrabbing](https://user-images.githubusercontent.com/17255804/85622001-7ab7b280-b666-11ea-9989-1fc1e2b445c8.gif)

Grabbing Area can be controlled with 3 parameters:

* `handleSize`: Control the visible render size of handles. Rendered in green in example.
* `outMargin`: Margin to allow easy grab outside of visual handle. Rendered in cyan in example.
* `inMargin`: Margin inside visual handles before grabbing the full rectangle for move. Rendered in orange in the example.

```js
import Qaterial as Qaterial

Qaterial.RectangleAreaHandler
{
  inMargin: 8
  outMargin: 16
  handleSize: 32
}
```

[QaterialOnline](https://tinyurl.com/y8n9lumf)

### Reverse Allowed

![reverseRectangleArea](https://user-images.githubusercontent.com/17255804/85623093-2281b000-b668-11ea-96d0-adf7a4d7482b.gif)

By default the selection will reversed itself if user try to do a negative rectangle. This can be disabled by settings `reversedAllowed` to false. This can be finer tuned by using `horizontalReverseAllowed` or `verticalReverseAllowed` to only disable on a particular axis.

```js
import Qaterial as Qaterial

Qaterial.RectangleAreaHandler
{
  horizontalReverseAllowed: true
  verticalReverseAllowed: true
}
```

[QaterialOnline](https://tinyurl.com/yav7bqgr)

### Minimum Size

By default the minimum size of made with start/end is 0. This behavior can be changed by setting `minSize`.

```js
import Qaterial as Qaterial

Qaterial.RectangleAreaHandler
{
  minSize: Qt.vector2d(0.1, 0.1)
}
```

> When using `minSize`, it automatically disable `reverse` behavior

## Customization

A `RectangleAreaHandler` is made a 4 `handle` and 4 `handleLinker` that can be customized.

![RectangleAreaHandlerCustomizedDemo](https://user-images.githubusercontent.com/17255804/85398291-4c967d80-b555-11ea-9db0-28b3c302a7ee.gif)

* `handle`: x, y, width, height are set by the loader. It should have a `hovered` property.
* `handleLinked`: x, y are set by the loader. It should have a `hovered` and `horizontal` property.
  * When `horizontal` is **true**, `width` is set by loader, `height` should be set by the item.
  * When `horizontal` is **false**, `height` is set by loader, `width` should be set by the item.

```js
import QtQuick
import Qaterial as Qaterial
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

[QaterialOnline](https://tinyurl.com/yar7gk2e)
