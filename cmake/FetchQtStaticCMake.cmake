include(FetchContent)

set(QTSTATICCMAKE_REPOSITORY "https://github.com/OlivierLDff/QtStaticCMake.git" CACHE STRING "QtStaticCMake repository, can be a local URL")
set(QTSTATICCMAKE_TAG "master" CACHE STRING "QtStaticCMake git tag")

FetchContent_Declare(
  QtStaticCMake
  GIT_REPOSITORY ${QTSTATICCMAKE_REPOSITORY}
  GIT_TAG        ${QTSTATICCMAKE_TAG}
  GIT_SHALLOW    1
)

FetchContent_MakeAvailable(QtStaticCMake)