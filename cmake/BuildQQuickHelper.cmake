#
#	Download Script by Olivier Le Doeuff
#
## CMAKE INPUT	
#	
#	-QQUICKMATERIALHELPER_REPOSITORY : QQuickMaterialHelper repository url
#	-QQUICKMATERIALHELPER_TAG : QQuickMaterialHelper git tag
#
## CMAKE OUTPUT
# 
#

MESSAGE(STATUS "Build QQuickMaterialHelper Started")
# repository path & tag
IF( NOT QQUICKMATERIALHELPER_REPOSITORY )
	SET( QQUICKMATERIALHELPER_REPOSITORY "https://github.com/OlivierLDff/QQuickMaterialHelper.git" CACHE STRING "QQuickMaterialHelper repository, can be a local URL" FORCE )
ENDIF()
MESSAGE(STATUS "QQuickMaterialHelper repository folder: " ${QQUICKMATERIALHELPER_REPOSITORY})

IF( NOT DEFINED QQUICKMATERIALHELPER_TAG )
	SET( QQUICKMATERIALHELPER_TAG master CACHE STRING "QQuickMaterialHelper git tag" FORCE )
ENDIF()
MESSAGE( STATUS "QQuickMaterialHelper repository tag: " ${QQUICKMATERIALHELPER_TAG} )

INCLUDE( ${PROJECT_SOURCE_DIR}/cmake/DownloadProject.cmake )

DOWNLOAD_PROJECT(PROJ 	QQuickMaterialHelper
	GIT_REPOSITORY 		${QQUICKMATERIALHELPER_REPOSITORY}
	GIT_TAG 			${QQUICKMATERIALHELPER_TAG}
	UPDATE_DISCONNECTED 1
	QUIET
	)

ADD_SUBDIRECTORY( ${QQuickMaterialHelper_SOURCE_DIR} ${QQuickMaterialHelper_BINARY_DIR} )