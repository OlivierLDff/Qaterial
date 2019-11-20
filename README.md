Qaterial
===============

A collection of helper for QtQuick and QtQuickControls to build faster UI using Qml. This library contain multiple override of QtQuickControls (Material) to match better google guideline and allow more customization.

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
