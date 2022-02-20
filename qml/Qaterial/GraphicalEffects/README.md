# QtGraphicalEffects

Graphical Effects for Qt, with original features but for Qt6, ported from qt/qtgraphicaleffects

## Usage

### Use as a submodule, without installing to the global QML import paths

1. Clone qtgraphicaleffects repo to your project

2. Add following lines to your CMakeLists.txt
```cmake
add_subdirectory(QtGraphicalEffects) # where 'QtGraphicalEffects' is the path to QtGraphicalEffects

# These two lines make Qt Creator recognize QGE QML module.
list(APPEND QML_DIRS "${CMAKE_CURRENT_BINARY_DIR}/") # As above
set(QML_IMPORT_PATH "${QML_DIRS}" CACHE STRING "Qt Creator 4.1 extra qml import paths")
```

3. Add following lines to your `main.cpp`

```cpp
// QQmlApplicationEngine engine;
// to make sure QGE module can be found at runtime.
engine.addImportPath(app.applicationDirPath());
```

### Installing to global QML import path

(TODO)

## License

Following Qt, it's licensed under both BSD and FDL.
