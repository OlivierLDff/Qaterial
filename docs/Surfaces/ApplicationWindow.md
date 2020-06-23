---
layout: default
title: Application Window
---

# Application Window

[ApplicationWindow](https://doc.qt.io/qt-5/qml-qtquick-controls2-applicationwindow.html) is a [Window](https://doc.qt.io/qt-5/qml-qtquick-window-window.html) which makes it convenient to add a [menu bar](https://doc.qt.io/qt-5/qml-qtquick-controls2-applicationwindow.html#menuBar-attached-prop), [header](https://doc.qt.io/qt-5/qml-qtquick-controls2-applicationwindow.html#header-attached-prop) and [footer](https://doc.qt.io/qt-5/qml-qtquick-controls2-applicationwindow.html#footer-attached-prop) item to the window.

You can declare ApplicationWindow as the root item of your application, and run it by using [QQmlApplicationEngine](https://doc.qt.io/qt-5/qqmlapplicationengine.html). In this way you can control the window's properties, appearance and layout from QML.

## WindowLayoutSave

`WindowLayoutSave` is an easy to use Item that will save and restore its target `Window` properties: `x`, `y`, `width`, `height`. It will also respect `minimumWidth` and `minimumHeight`.

```js
import Qaterial 1.0 as Qaterial

Qaterial.ApplicationWindow
{
  id: window

  width: 500
  height: 300

  minimumWidth: 100
  minimumHeight: 100

  // Save and restore x, y, width, height
  Qaterial.WindowLayoutSave { }
}
```

Example can be found in `examples/WindowSaveLayout.qml`.

### Properties

**target**

The target of the `WindowLayoutSave` is defaulted to the attached property `Window.window`. This can be overwritten if wanted. The target is expected to have `x`, `y`, `width`, `height`, `minimumWidth`, `minimumHeight` properties.

**enable**

Enable of disable the WindowLayoutSave restoring behavior. By default it's true.

**visible**

When using a `WindowSaveLayout`, the `ApplicationWindow`'s `visible` property should be left at false. When constructing, the `WindowLayoutSave` will change `ApplicationWindow` `visible` to true.

If you need to manage the visible property of the Window by yourself, then set visible of `WindowLayoutSave` to false.

```js
import Qaterial 1.0 as Qaterial

Qaterial.ApplicationWindow
{
	Qaterial.WindowLayoutSave { visible: false }
    Component.onCompleted: () => visible = true
}
```

**name**

 Window name to support multiple Window in the same application. This is used to create a custom `Settings` category for each window. If left empty, it will only be possible to support one Window in the application.

This property can also be used to remember multiple location, for user profile for example.

### Note

`WindowLayoutSave` is using [Settings](https://doc.qt.io/qt-5/qml-qt-labs-settings-settings.html). It require you to register your application with identifier.

Application specific settings are identified by providing application [name](https://doc.qt.io/qt-5/qcoreapplication.html#applicationName-prop), [organization](https://doc.qt.io/qt-5/qcoreapplication.html#organizationName-prop) and [domain](https://doc.qt.io/qt-5/qcoreapplication.html#organizationDomain-prop), or by specifying [fileName](https://doc.qt.io/qt-5/qml-qt-labs-settings-settings.html#fileName-prop).

```c++
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Some Company");
    app.setOrganizationDomain("somecompany.com");
    app.setApplicationName("Amazing Application");

    QQmlApplicationEngine engine("main.qml");
    return app.exec();
}
```