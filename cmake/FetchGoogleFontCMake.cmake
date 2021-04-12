include(FetchContent)

set(FETCHGOOGLEFONTCMAKE_REPOSITORY "https://github.com/OlivierLDff/FetchGoogleFontCMake.git" CACHE STRING "FetchGoogleFontCMake repository, can be a local URL")
set(FETCHGOOGLEFONTCMAKE_TAG "master" CACHE STRING "FetchGoogleFontCMake git tag")

FetchContent_Declare(
  FetchGoogleFontCMake
  GIT_REPOSITORY ${FETCHGOOGLEFONTCMAKE_REPOSITORY}
  GIT_TAG        ${FETCHGOOGLEFONTCMAKE_TAG}
)

FetchContent_MakeAvailable(FetchGoogleFontCMake)
