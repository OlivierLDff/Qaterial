# Create app
add_executable(QaterialHelloWorld HelloWorld.cpp HelloWorld.qrc)

# Link to qaterial
target_link_libraries(QaterialHelloWorld PRIVATE Qaterial)

# AUTORCC is required to compile the .qrc files
set_target_properties(QaterialHelloWorld PROPERTIES AUTOMOC TRUE)
set_target_properties(QaterialHelloWorld PROPERTIES AUTORCC TRUE)

# copy qt5 dlls
get_target_property(_qmake_executable Qt5::qmake IMPORTED_LOCATION)
get_filename_component(_qt_bin_dir "${_qmake_executable}" DIRECTORY)
find_program(WINDEPLOYQT_EXECUTABLE windeployqt HINTS "${_qt_bin_dir}")
add_custom_command(
    TARGET QaterialHelloWorld
    POST_BUILD
    COMMAND ${WINDEPLOYQT_EXECUTABLE} --qmldir ${CMAKE_CURRENT_SOURCE_DIR}/../../ $<TARGET_FILE:QaterialHelloWorld>
)
