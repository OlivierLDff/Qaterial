---
layout: default
title: ⭐ Icons
---

# ⭐ Icons

Qaterial automatically package all svg icons from [MaterialDesignIcons](https://github.com/Templarian/MaterialDesign).

Path is `qrc:/Qaterial/Icons/<icon>.svg`.
For easy access, Qaterial also comes with a singleton `Icons` that provide a property for each svg files.

Example:


``` js
import QtQuick 2.0
import Qaterial 1.0 as Qaterial
Row
{
    Qaterial.Button { icon.source: Qaterial.Icons.add }
    Qaterial.Button { icon.source: 'qrc:/Qaterial/Icons/alert-circle.svg' }
}
```

## Find Icons

![icons](https://user-images.githubusercontent.com/17255804/86470477-d1df1680-bd3b-11ea-8602-d25f7f215df3.gif)

In file `qml/Icons.qml` all available icons are listed.
A convenient example `IconsListView` is also available to filter and search in the list.

[QaterialOnline](https://tinyurl.com/yb7tlx5n)

## Icon Component

A Simple `Icon` component display an icon with a color. 

```js
import Qaterial 1.0 as Qaterial

Qaterial.Icon
{
	icon: Qaterial.Icons.rocketLaunchOutline
    size: 32
    color: "#FF9800"
}
```

**Properties**

* `icon`: Path to the icon.
* `size`: Size of the icon, automatically set width & height. *Width & height can be set to different value is required.*
* `color`: Color of the icon. Default to primary text color.

## How to filter icons

By default all svg from MaterialDesignIcons are package in Qaterial (take 3-4Mb).
To filter which icons are going to be embedded use the CMake argument `QATERIAL_ICONS`.

This example demonstrate how to embed only icons starting with `ab`, `account`, and that contains `outline`
``` bash
cmake -DQATERIAL_ICONS="ab*;account*;*outline*" ..
```

By default `QATERIAL_ICONS` is equals to `"*.svg"`.