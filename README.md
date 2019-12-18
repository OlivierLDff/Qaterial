Qaterial
===============

A collection Material Components to build UI using Qml. The project [QaterialGallery](https://github.com/OlivierLDff/QaterialGallery) demonstrate the use of the library and show example, how to use components.
This library is still under development so big changes might happened. If you intend to use this in your project, you should use a stable version because master change often.

*This is a hard fork from QtQuickMaterialHelper. Aim of this fork is mainly to rename the library with a shorter name, and shorter path.*

## Dependencies

- *QtCore QtGui QtQuick QtQuickControls2*

## CMake

### Build

```bash
git clone https://github.com/OlivierLDff/Qaterial
cd Qaterial && mkdir build && cd build
cmake -DCMAKE_PREFIX_PATH="path/to/Qt/toolchain" -DQATERIAL_BUILD_SHARED=ON -DQATERIAL_USE_NAMESPACE=ON -DQATERIAL_BUILD_DOC=ON ..
make
```

### Input

- **QATERIAL_TARGET** : Name of the library target. *Default : "Qaterial"*
- **QATERIAL_PROJECT** : Name of the project. *Default : "Qaterial"*
- **QATERIAL_BUILD_SHARED** : Build shared library [ON OFF]. *Default: OFF.*
- **QATERIAL_BUILD_STATIC** : Build static library [ON OFF]. *Default: ON.*
- **QATERIAL_USE_NAMESPACE** : If the library compile with a namespace [ON OFF]. *Default: ON.*
- **QATERIAL_NAMESPACE** : Namespace for the library. Only relevant if QATERIAL_USE_NAMESPACE is ON. *Default: "Qqh".*

### Output

- **QATERIAL_TARGET** : Output target to link to.
- **QATERIAL_VERSION** : Current version of the library
