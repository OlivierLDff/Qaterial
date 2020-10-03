include(FetchContent)

set(QOLM_REPOSITORY "https://github.com/OlivierLDff/QOlm.git" CACHE STRING "QOlm repository url")
set(QOLM_TAG master CACHE STRING "QOlm git tag")

FetchContent_Declare(
  QOlm
  GIT_REPOSITORY ${QOLM_REPOSITORY}
  GIT_TAG        ${QOLM_TAG}
  GIT_SHALLOW    1
)

set(QOLM_FOLDER_PREFIX "Dependencies" CACHE STRING "Prefix folder for all QOlm generated targets in generated project (only decorative)")
FetchContent_MakeAvailable(QOlm)
