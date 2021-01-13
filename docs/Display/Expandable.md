---
layout: default
title: Expandable
---
# Expandable

![expandablesimple](https://user-images.githubusercontent.com/17255804/87765343-f8ab4b80-c817-11ea-8473-887a95a706e4.gif)

`Expandable` is a lightweight item that display a `header` and a `delegate`. The delegate is shown with an `animation` when `expanded` is set to true.

```js
import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.Expandable
{
  id: root

  header: Qaterial.ItemDelegate
  {
    id: _header
    text: "Header"
    onClicked: () => root.expanded = !root.expanded

    contentItem: Qaterial.LabelHeadline6
    {
      text: parent.text
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
    }

    Qaterial.DebugRectangle { anchors.fill: parent; border.color: Qaterial.Style.green }
  }

  delegate: Qaterial.LabelHeadline6
  {
    text: "Delegate"
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    height: 100

    Qaterial.DebugRectangle { anchors.fill: parent; border.color: Qaterial.Style.amber }
  }
}
```

[QaterialOnline](https://tinyurl.com/yxwxorvu)

## Customization

By it's own the `Expandable` doesn't provide any appearance. It need to be customized.

- `header`: `Component` display on top of the Expandable.
- `delegate`: `Component` display when `expanded` is **true** with `animation`.
- `animation`: Behavior on `delegate` height. There is a default implementation for that.

When `header` component is loaded, the loaded item can be accessed thru `headerItem`.

When `delegate` component is loaded, the loaded item can be accessed thru `delegateItem`.

## Properties

- `expanded`: **true** to expand the **Expandable**. *Default: false.*
- `animationOnDelegateHeight`: **true** to enable animation on delegate height changed. *Default: false*.

## Examples

### Animation

![expandableanimation](https://user-images.githubusercontent.com/17255804/87765347-f943e200-c817-11ea-9923-f83f1a900362.gif)

This example shows how to customize the `animation`.

```js
import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.Expandable
{
  id: root

  header: Qaterial.ItemDelegate
  {
    height: 32
    backgroundColor: Qaterial.Style.orange
    onClicked: () => root.expanded = !root.expanded
  }

  delegate: Rectangle
  {
    height: 64
    color: Qaterial.Style.teal
  }

  animation: NumberAnimation
  {
    duration: 500
    easing.type: Easing.OutCirc
  }
}
```

[QaterialOnline](https://tinyurl.com/y5p3f27n)

### Advanced

![expandableadvanced](https://user-images.githubusercontent.com/17255804/87765349-f9dc7880-c817-11ea-83fd-c9537a1f460a.gif)

This example shows how to create a complex `delegate`.

```js
import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.Expandable
{
  id: root
  width: parent.width

  header: Qaterial.ItemDelegate
  {
    id: _header
    width: root.width

    icon.source: Qaterial.Icons.account
    text: "Header"
    secondaryText: `expanded: ${root.expanded}`

    onClicked: () => root.expanded = !root.expanded

    Qaterial.DebugRectangle { anchors.fill: parent; border.color: "#E91E63"}
  } // Rectangle

  delegate: Column
  {
    Repeater
    {
      id: _repeater

      model: ListModel
      {
        ListElement { icon: "numeric-1-circle-outline"; color: "#2196F3" }
        ListElement { icon: "numeric-2-circle-outline"; color: "#4CAF50" }
        ListElement { icon: "numeric-3-circle-outline"; color: "#f44336" }
      } // ListModel

      delegate: Qaterial.ItemDelegate
      {
        width: root.width

        text: `Delegate ${index}`
        icon.source: `qrc:/Qaterial/Icons/${model.icon}.svg`

        Qaterial.DebugRectangle { anchors.fill: parent; border.color: model.color }

        onClicked: () => Qaterial.Logger.debug(`Element ${index+1} clicked`)
      } // ItemDelegate
    } // Repeater
  } // Item
} // Expandable
```

[QaterialOnline](https://tinyurl.com/y6nwwy5d)

### Dynamic Height

![expandableanimation](https://user-images.githubusercontent.com/17255804/88485962-8e627b80-cf7a-11ea-9ba2-c009687dc20b.gif)

By default if the height of the delegate is changing, the expandable is immediately replicating the change without animation. This is very useful for example an expandable is inside an expandable.

This behavior can be enabled with `animationOnDelegateHeight`.

[QaterialOnline](https://tinyurl.com/y2d6gdka)
