include(FetchContent)

set(SFPM_REPOSITORY "https://github.com/OlivierLDff/SortFilterProxyModel.git" CACHE STRING "SortFilterProxyModel repository url")
set(SFPM_TAG master CACHE STRING "SortFilterProxyModel git tag")

FetchContent_Declare(
  SortFilterProxyModel
  GIT_REPOSITORY ${SFPM_REPOSITORY}
  GIT_TAG        ${SFPM_TAG}
)

FetchContent_MakeAvailable(SortFilterProxyModel)