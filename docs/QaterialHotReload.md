---
layout: default
title: ♨️ Qaterial Hot Reload
nav_order: 5
---

# ♨️ Qaterial Hot Reload

**QaterialHotReload** is an app that load a `.qml` file, and reloads it each time the file is saved on the system.

![QaterialHotReload](https://user-images.githubusercontent.com/17255804/85396672-6c787200-b552-11ea-814e-12ae2c6db0e9.gif)

## Position anchors

Helpers button can apply anchors to your qml object.

![QaterialHotReloadAnchors](https://user-images.githubusercontent.com/17255804/85396675-6d110880-b552-11ea-80aa-fd79855346bc.gif)

* FullScreen: `anchors.fill: parent`
* Horizontal Center: `anchors.horizontalCenter: parent.horizontalCenter`
* Vertical Center: `anchors.verticalCenter: parent.verticalCenter`
* Left: `anchors.left: parent.left`
* Right: `anchors.right: parent.right`
* Bottom: `anchors.bottom: parent.bottom`
* Top: `anchors.top: parent.top`

## Build & Execute

Add the flag `-DQATERIAL_ENABLE_TOOLS=ON` when configuring the project with cmake to create the executable.

``` bash
cmake -DQATERIAL_ENABLE_TOOLS=ON ..
cmake --build . --target QaterialHotReload
./tools/HotReload/QaterialHotReload
```