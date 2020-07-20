---
layout: default
title: 🚀 Getting Start
nav_order: 1
---

# 🚀 Getting Start

A C++ Hello World project is located in `tools/HelloWorld`.

|      File      |                         Description                          |
| :------------: | :----------------------------------------------------------: |
| CMakeLists.txt |                 Project to build HelloWorld.                 |
| HelloWorld.cpp | Entry point of the program that register Qaterial, then open `HelloWorld.qml` |
| HelloWorld.qml |       Main qml file that create an `ApplicationWindow`       |
| HelloWorld.qrc | Ressource file that embedded `HelloWorld.qml` in the virtual file system `qrc`. |

**HelloWorld.cpp**

``` c++
// ──── INCLUDE ────

#include <Qaterial/Qaterial.hpp>

#include <QGuiApplication>
#include <QQmlApplicationEngine>

// ──── FUNCTIONS ────

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Important to find 'import Qaterial 1.0' in qml
    // Qaterial module is located in qrc:Qaterial/
    engine.addImportPath("qrc:///");

    // Load Qaterial.
    qaterial::loadQmlResources();
    qaterial::registerQmlTypes();

    // Load QaterialHelloWorld
    Q_INIT_RESOURCE(HelloWorld);

   	// This path is defined by the prefix in HelloWorld.qrc
    engine.load(QUrl("qrc:/Qaterial/HelloWorld/HelloWorld.qml"));
    if(engine.rootObjects().isEmpty())
        return -1;
    
    // Start event loop
    return QGuiApplication::exec();
}

```

**HelloWorld.qml**

```js
import Qaterial 1.0 as Qaterial

Qaterial.ApplicationWindow
{
  width: 400
  height: 200
  visible: true

  Qaterial.Label
  {
    text: 'Hello World'
    anchors.centerIn: parent
  }
}
```

**HelloWorld.qrc**

```xml
<RCC>
    <qresource prefix="/Qaterial/HelloWorld">
        <file>HelloWorld.qml</file>
    </qresource>
</RCC>
```

**CMakeLists.txt**

```cmake
# Download Qaterial
cmake_minimum_required( VERSION 3.14 FATAL_ERROR)

project(QaterialHelloWorld VERSION 1.0.0 LANGUAGES CXX)

# Download & Configure Qaterial as part of your build system
include(FetchContent)
FetchContent_Declare(
  Qaterial
  GIT_REPOSITORY https://github.com/OlivierLDff/Qaterial.git
  GIT_TAG        master
  GIT_SHALLOW    1
)
FetchContent_MakeAvailable(Qaterial)

# Create app
add_executable(QaterialHelloWorld HelloWorld.cpp HelloWorld.qrc)

# Link to qaterial
target_link_libraries(QaterialHelloWorld PRIVATE Qaterial)

# AUTORCC is required to compile the .qrc files
set_target_properties(QaterialHelloWorld PROPERTIES AUTOMOC TRUE)
```

