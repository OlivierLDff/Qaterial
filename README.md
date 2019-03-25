Qt Quick Material Helper
===============

A collection of helper for QtQuick and QtQuickControls to build faster UI using Qml. This library contain multiple override of QtQuickControls (Material) to match better google guideline and allow more customization.

## Dependencies

- [Doxygen](https://github.com/doxygen/doxygen) : To generate the documentation.
- [DoxygenBootstrapped](https://github.com/OlivierLDff/DoxygenBootstrapped) : Integrate doxygen with CMake. *v1.3.2*.
- *QtCore QtGui QtQuick QtQuickControls2*

## CMake

### Build

```bash
git clone https://github.com/OlivierLDff/QtQuickHelper
cd QQuickMaterialHelper && mkdir build && cd build
cmake -DQT_DIR="path/to/Qt/toolchain" -DQQUICKMATERIALHELPER_BUILD_SHARED=ON -DQQUICKMATERIALHELPER_USE_NAMESPACE=ON -DQQUICKMATERIALHELPER_BUILD_DOC=ON ..
make
```

### Input

- **QQUICKMATERIALHELPER_TARGET** : Name of the library target. *Default : "QQuickMaterialHelper"*
- **QQUICKMATERIALHELPER_PROJECT** : Name of the project. *Default : "QQuickMaterialHelper"*
- **QQUICKMATERIALHELPER_BUILD_SHARED** : Build shared library [ON OFF]. *Default: OFF.*
- **QQUICKMATERIALHELPER_BUILD_STATIC** : Build static library [ON OFF]. *Default: ON.*
- **QQUICKMATERIALHELPER_USE_NAMESPACE** : If the library compile with a namespace [ON OFF]. *Default: ON.*
- **QQUICKMATERIALHELPER_NAMESPACE** : Namespace for the library. Only relevant if QQUICKMATERIALHELPER_USE_NAMESPACE is ON. *Default: "Qqh".*

### Output

- **QQUICKMATERIALHELPER_TARGET** : Output target to link to.
- **QQUICKMATERIALHELPER_VERSION** : Current version of the library

### Integration in CMake project

The main goal of this CMake project is to big included into another CMake project.

```cmake
SET( QQUICKMATERIALHELPER_TARGET QQuickMaterialHelper )
SET( QQUICKMATERIALHELPER_PROJECT QQuickMaterialHelper )
SET( QQUICKMATERIALHELPER_BUILD_SHARED OFF )
SET( QQUICKMATERIALHELPER_BUILD_STATIC ON )
ADD_SUBDIRECTORY(${CMAKE_CURRENT_SOURCE_DIR}/path/to/QQuickMaterialHelper ${CMAKE_CURRENT_BINARY_DIR}/QQuickMaterialHelper_Build)
```

It is also possible to download the repository with the scripts inside `cmake/`. folder Simply call `BuildQQuickMaterialHelper.cmake`.

You will need:

- `DownloadProject.cmake`
- `DownloadProject.CMakeLists.cmake.in`
- `BuildQQuickMaterialHelper.cmake`

```cmake
SET( QQUICKMATERIALHELPER_TARGET QQuickMaterialHelper )
SET( QQUICKMATERIALHELPER_PROJECT QQuickMaterialHelper )
SET( QQUICKMATERIALHELPER_BUILD_SHARED OFF )
SET( QQUICKMATERIALHELPER_BUILD_STATIC ON )
SET( QQUICKMATERIALHELPER_USE_NAMESPACE ON )
SET( QQUICKMATERIALHELPER_REPOSITORY "https://github.com/OlivierLDff/QQuickMaterialHelper.git" )
SET( QQUICKMATERIALHELPER_TAG v1.0.1 )
INCLUDE(path/to/BuildQQuickMaterialHelper.cmake)
```