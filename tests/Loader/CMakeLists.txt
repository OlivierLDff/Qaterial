set(QATERIAL_TEST_LOADER QaterialTestLoader)
message(STATUS "Add Test: ${QATERIAL_TEST_LOADER}")

# Create our app
add_executable(${QATERIAL_TEST_LOADER} QaterialTestLoader.cpp)

# We assume that Qaterial is available somewhere. You should have a look at 'cmake/FetchQaterial.cmake'
target_link_libraries(${QATERIAL_TEST_LOADER} PRIVATE Qaterial)

# AUTOMOC isn't necessary here, but it's a hello world
# AUTORCC is to compile the .qrc files
set_target_properties(${QATERIAL_TEST_LOADER} PROPERTIES FOLDER "${QATERIAL_FOLDER_PREFIX}/Test")

# Fix gcc7 bug major/minor
if(QATERIAL_ENABLE_PCH AND COMMAND target_precompile_headers)
  target_precompile_headers(${QATERIAL_TEST_LOADER} PRIVATE ${PROJECT_SOURCE_DIR}/src/Qaterial/Pch/Pch.hpp)
endif()

file(GLOB_RECURSE QML_FILES ${PROJECT_SOURCE_DIR}/qml/*.qml)

foreach(QML_FILE ${QML_FILES})

  file(READ ${QML_FILE} QML_FILE_TXT)
  string(FIND "${QML_FILE_TXT}" "pragma Singleton" MATCH_SINGLETON)

  if(${MATCH_SINGLETON} EQUAL -1)

    get_filename_component(QML_FILE_NAME ${QML_FILE} NAME_WE)
    message(STATUS "Add test : ${QATERIAL_TEST_LOADER}_${QML_FILE_NAME}")
    add_test(NAME ${QATERIAL_TEST_LOADER}_${QML_FILE_NAME} COMMAND "$<TARGET_FILE:${QATERIAL_TEST_LOADER}>" "${QML_FILE}")

  endif()

endforeach()
