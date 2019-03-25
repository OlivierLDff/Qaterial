#
#	Download Script by Olivier Le Doeuff
#
## CMAKE INPUT	
#	
#	-QSUPERMACROS_REPOSITORY : QBC repository url
#	-QSUPERMACROS_TAG : QBC git tag
#
## CMAKE OUTPUT
# 
#

MESSAGE(STATUS "Build QSuperMacros Started")
# repository path & tag
IF( NOT QSUPERMACROS_REPOSITORY )
	SET( QSUPERMACROS_REPOSITORY "https://github.com/OlivierLDff/QSuperMacros.git" CACHE STRING "QSuperMacros repository, can be a local URL" FORCE )
ENDIF()
MESSAGE(STATUS "QSuperMacros repository folder: " ${QSUPERMACROS_REPOSITORY})

IF( NOT DEFINED QSUPERMACROS_TAG )
	SET( QSUPERMACROS_TAG master CACHE STRING "QSuperMacros git tag" FORCE )
ENDIF()
MESSAGE( STATUS "QSuperMacros repository tag: " ${QSUPERMACROS_TAG} )

INCLUDE( ${PROJECT_SOURCE_DIR}/cmake/DownloadProject.cmake )

DOWNLOAD_PROJECT(PROJ 	QSuperMacros
	GIT_REPOSITORY 		${QSUPERMACROS_REPOSITORY}
	GIT_TAG 			${QSUPERMACROS_TAG}
	UPDATE_DISCONNECTED 1
	QUIET
	)

ADD_SUBDIRECTORY( ${QSuperMacros_SOURCE_DIR} ${QSuperMacros_BINARY_DIR} )