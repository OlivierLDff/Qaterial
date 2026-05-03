set(QATERIAL_UNIT_TESTS QaterialUnitTests)
message(STATUS "Add Test: ${QATERIAL_UNIT_TESTS}")

qt_add_executable(${QATERIAL_UNIT_TESTS}
  CollectFontFilesTest.cpp
)

set_target_properties(${QATERIAL_UNIT_TESTS} PROPERTIES
  AUTOMOC ON
)

target_link_libraries(${QATERIAL_UNIT_TESTS} PRIVATE
  ${QATERIAL_TARGET}::${QATERIAL_TARGET}
  Qt::Core
  Qt::Test
)

if(QATERIAL_FOLDER_PREFIX)
  set_target_properties(${QATERIAL_UNIT_TESTS} PROPERTIES FOLDER "${QATERIAL_FOLDER_PREFIX}/Test")
endif()

add_test(NAME ${QATERIAL_UNIT_TESTS} COMMAND "$<TARGET_FILE:${QATERIAL_UNIT_TESTS}>")
