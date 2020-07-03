include(FetchContent)

set(MATERIALDESIGNICONS_REPOSITORY "https://github.com/Templarian/MaterialDesign.git" CACHE STRING "MaterialDesignIcons repository url")
set(MATERIALDESIGNICONS_TAG master CACHE STRING "MaterialDesignIcons git tag")

FetchContent_Declare(
  MaterialDesignIcons
  GIT_REPOSITORY ${MATERIALDESIGNICONS_REPOSITORY}
  GIT_TAG        ${MATERIALDESIGNICONS_TAG}
  GIT_SHALLOW    1
)

FetchContent_MakeAvailable(MaterialDesignIcons)

set(MATERIALDESIGNICONS_ICONS_DIR "${materialdesignicons_SOURCE_DIR}/svg")