include(FetchContent)

set(QATERIAL_REPOSITORY "https://github.com/OlivierLDff/Qaterial.git" CACHE STRING "Qaterial repository url")
set(QATERIAL_TAG master CACHE STRING "Qaterial git tag")

FetchContent_Declare(
  Qaterial
  GIT_REPOSITORY ${QATERIAL_REPOSITORY}
  GIT_TAG        ${QATERIAL_TAG}
  GIT_SHALLOW    1
)

FetchContent_MakeAvailable(Qaterial)