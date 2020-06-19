---
layout: default
title: ⭐ Icons
nav_order: 6
---

# ⭐ Icons

Qaterial comes with lots of material icons. They can all be found in `qrc:/Qaterial/Icons/<icon>.svg`. For easy access, Qaterial also comes with a singleton `Icons`.

Example:


``` js

Qaterial.Button
{
    icon.source: Qaterial.Icons.add
}

```

## How to add new Icons

Lost of Material Icons can be found in [materialdesignicons](https://materialdesignicons.com/)

* Download and copy the `svg` file in `qml/Icons`.
* Add the file in `qml/Qaterial.qrc`
* Add an alias to the file in `qml/Icons.qml`