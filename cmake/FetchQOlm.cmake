include(FetchContent)

set(QOLM_REPOSITORY "https://github.com/OlivierLDff/QOlm.git" CACHE STRING "QOlm repository url")
set(QOLM_TAG master CACHE STRING "QOlm git tag")

FetchContent_Declare(
  QOlm
  GIT_REPOSITORY ${QOLM_REPOSITORY}
  GIT_TAG        ${QOLM_TAG}
  GIT_SHALLOW    1
)

FetchContent_MakeAvailable(QOlm)