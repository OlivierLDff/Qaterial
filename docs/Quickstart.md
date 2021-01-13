---
layout: default
title: 🚀 Getting Start
nav_order: 1
---

# 🚀 Getting Start

A C++ Hello World project is located [here](https://github.com/OlivierLDff/QaterialHelloWorld).

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

## 🔨 Configure & Build

Run [CMake](https://cmake.org/) to configure and build the project. It's recommended to avoid in source build.


```cmake
mkdir build && cd build
cmake ..
cmake --build . -j
./HelloWorld
```

Depending on the environment you might need to add more info to the `cmake ..` step. Use `cmake -DCMAKE_PREFIX_PATH=/path/to/qt/installation ..` to choose other qt installation than the one provided by the system. This is mandatory for example on windows.
The `./HelloWorld` might differ. For example with msvc it might be `./Debug/HelloWorld.exe` or `./Release/HelloWorld.exe`.
You might also need to deploy qt dlls near your executable. Or update your path for the app to find them.

### Customize environment variable for easy development.

#### Windows

* **Qt5_DIR**: Give a default Qt5 installation for path for the `find_package` command. Example: `C:\Qt\5.15.0\msvc2019_64`.
* **QML2_IMPORT_PATH**: Indicate where to look for qml files & plugins. Example Value: ` .;C:\Qt\5.15.0\msvc2019_64\qml;./Debug;./Release`
* **QT_PLUGIN_PATH**: Path where the application is looking for plugins like platform plugin or svg, ... Example: `.;C:\Qt\5.15.0\msvc2019_64\plugins;C:\Qt\5.15.0\msvc2019_64\qml`.

