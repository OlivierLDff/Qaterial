---
layout: default
title: ♨️ Qaterial Hot Reload
nav_order: 5
---

# ♨️ Qaterial Hot Reload

**QaterialHotReload** is an app that load a `.qml` file, and reloads it each time the file is saved on the system.

![](./images/QaterialHotReload.gif)

## Build & Execute

Add the flag `-DQATERIAL_ENABLE_TOOLS=ON` when configuring the project with cmake to create the executable.

``` bash
cmake -DQATERIAL_ENABLE_TOOLS=ON ..
cmake --build . --target QaterialHotReload
./tools/HotReload/QaterialHotReload
```