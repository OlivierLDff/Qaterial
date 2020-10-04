include(FetchContent)

set(MATERIALDESIGNICONS_REPOSITORY "https://github.com/OlivierLDff/MaterialDesignSvgo" CACHE STRING "MaterialDesignIcons repository url")
set(MATERIALDESIGNICONS_TAG master CACHE STRING "MaterialDesignIcons git tag")

FetchContent_Declare(
  MaterialDesignIcons
  GIT_REPOSITORY ${MATERIALDESIGNICONS_REPOSITORY}
  GIT_TAG        ${MATERIALDESIGNICONS_TAG}
  GIT_SHALLOW    1
)

message(STATUS "Download MaterialDesignIcons from ${MATERIALDESIGNICONS_REPOSITORY}")
FetchContent_MakeAvailable(MaterialDesignIcons)

set(MATERIALDESIGNICONS_ICONS_DIR "${materialdesignicons_SOURCE_DIR}/svg")
