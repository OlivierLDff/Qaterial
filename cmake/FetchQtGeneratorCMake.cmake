include(FetchContent)

set(QTGENERATORCMAKE_REPOSITORY "https://github.com/OlivierLDff/QtGeneratorCMake.git" CACHE STRING "QtGeneratorCMake repository, can be a local URL")
set(QTGENERATORCMAKE_TAG "master" CACHE STRING "QtGeneratorCMake git tag")

FetchContent_Declare(
  QtGeneratorCMake
  GIT_REPOSITORY ${QTGENERATORCMAKE_REPOSITORY}
  GIT_TAG        ${QTGENERATORCMAKE_TAG}
  GIT_SHALLOW    1
)

FetchContent_MakeAvailable(QtGeneratorCMake)
