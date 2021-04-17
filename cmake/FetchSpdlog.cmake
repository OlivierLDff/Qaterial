include(FetchContent)

set(SPDLOG_REPOSITORY "https://github.com/gabime/spdlog" CACHE STRING "spdlog repository url")
set(SPDLOG_TAG "v1.x" CACHE STRING "spdlog git tag")

FetchContent_Declare(
  spdlog
  GIT_REPOSITORY ${SPDLOG_REPOSITORY}
  GIT_TAG        ${SPDLOG_TAG}
)

option(SPDLOG_ENABLE_PCH "Build static or shared library using precompiled header to speed up compilation time" ON)
FetchContent_MakeAvailable(spdlog)
set_target_properties(spdlog PROPERTIES FOLDER "Dependencies")
