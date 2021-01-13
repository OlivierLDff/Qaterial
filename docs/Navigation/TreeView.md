---
layout: default
title: 🌴 Tree View
---

# 🌴 Tree View

Tree views can be used to represent a file system navigator displaying folders and files, an item representing a folder can be expanded to reveal the contents of the folder, which may be files, folders, or both.

A TreeView displays data from models created from built-in QML types like [ListModel](https://doc.qt.io/qt-5/qml-qtqml-models-listmodel.html) and [XmlListModel](https://doc.qt.io/qt-5/qml-qtquick-xmllistmodel-xmllistmodel.html), or custom model classes defined in C++ that inherit from [QAbstractItemModel](https://doc.qt.io/qt-5/qabstractitemmodel.html) or [QAbstractListModel](https://doc.qt.io/qt-5/qabstractlistmodel.html).

A TreeView has a `model`, which defines the data to be displayed, and a `itemDelegate`, which defines how the data should be displayed. Items in a TreeView are laid out vertically. Tree views are inherently flickable because TreeView inherits from [Flickable](https://doc.qt.io/qt-5/qml-qtquick-flickable.html).

* The `model` must have a `children` role, giving a list of children that will be expanded.
* The `model` must have a `expanded` role to control if the `Expandable` is expanded or not.

The TreeView doesn't provide a `itemDelegate` by it's own. You should provide your own:

```js
import Qaterial 1.0 as Qaterial
Qaterial.TreeView
{
  itemDelegate: Qaterial.ItemDelegate
  {
    property QtObject model
    property int depth
    property int index

    text: `${index} : ${model.text}`
    leftPadding: depth*20

    onClicked: () => model.expanded = !model.expanded
  }
}
```

The itemDelegate component should have `model`, `depth` and `index` properties.

* `model` : Pointer to the current object in the model that the delegate should represent.
* `index`: Offset in the current ListView.
* `depth`: Depth of the current ListView. It start at 0. This can be used for indenting

## Basic tree view

![Basic tree view](https://user-images.githubusercontent.com/17255804/88517561-4df11500-cfef-11ea-9588-72d76682cbbe.gif)

For convenience Qaterial provide a basic `TreeModel` and `TreeElement` objects that can be used as follow:

```js
import Qaterial 1.0 as Qaterial

Qaterial.TreeModel
{
  Qaterial.TreeElement
  {
    text: "Applications"
    Qaterial.TreeElement { text: "Calendar" }
    Qaterial.TreeElement { text: "Chrome" }
    Qaterial.TreeElement { text: "Webstorm" }
  }
  Qaterial.TreeElement
  {
    text: "Documents"
    Qaterial.TreeElement { text: "OSS" }
    Qaterial.TreeElement
    {
      text: "Qaterial"
      Qaterial.TreeElement
      {
        text: "src"
        Qaterial.TreeElement { text: "main.cpp" }
      }
      Qaterial.TreeElement
      {
        text: "qml"
        Qaterial.TreeElement { text: "main.qml" }
        Qaterial.TreeElement { text: "main.qrc" }
      }
      Qaterial.TreeElement { text: "CMakeLists.txt" }
    }
  }
}
```

The `TreeModel` support dynamic insertion and deletion. It is based on [QOlm](https://olivierldff.github.io/QOlm/), so check the doc there for the API.

## Json Tree View

![jsonTreeView](https://user-images.githubusercontent.com/17255804/88517915-e38ca480-cfef-11ea-8f8e-107e51b38b06.gif)

It is also possible to use a JSON model that needs to be inserted inside a `ListModel`. Each element should have an `expanded` and `children` field.

```js
import QtQuick 2.14

ListModel
{
  id: model
  Component.onCompleted: function()
  {
    const data =
    [
      {
        "expanded":false,
        "children":[
          {
            "expanded":false,
            "children":[
              {
                "expanded":false,
                "depth":0,
                "children":[

                ],
                "label":"101 (ubuntu-xenial)",
                "type":"lxc"
              },
              {
                "expanded":false,
                "depth":0,
                "children":[

                ],
                "label":"100 (pvetest-stretch)",
                "type":"qemu"
              }
            ],
            "label":"debianpro",
            "type":"node",
            "depth":0
          }
        ],
        "label":"debianpro",
        "type":"remote",
        "depth":0
      }
    ]

    model.clear()
    data.forEach(function(row) {
        model.append(row);
    })
  }
}
```

## Customized tree view

### Custom icons, border