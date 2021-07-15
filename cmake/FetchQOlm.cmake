if(TARGET QOlm::QOlm)
  return()
endif()

include(FetchContent)

set(QOLM_REPOSITORY "https://github.com/OlivierLDff/QOlm.git" CACHE STRING "QOlm repository url")
set(QOLM_TAG master CACHE STRING "QOlm git tag")

FetchContent_Declare(
  QOlm
  GIT_REPOSITORY ${QOLM_REPOSITORY}
  GIT_TAG        ${QOLM_TAG}
)

set(QOLM_FOLDER_PREFIX "Dependencies" CACHE STRING "Prefix folder for all QOlm generated targets in generated project (only decorative)")
set(QOLM_ENABLE_INSTALL ${QATERIAL_ENABLE_INSTALL} CACHE BOOL "Generate the install target")
FetchContent_MakeAvailable(QOlm)
