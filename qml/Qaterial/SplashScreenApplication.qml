import QtQuick

Item
{
  property alias splashScreen: splashScreenLoader.sourceComponent
  property alias window: applicationLoader.sourceComponent

  Loader
  {
    id: splashScreenLoader
    active: false

    onStatusChanged: function()
    {
      if(splashScreenLoader.status === Loader.Ready)
        applicationLoader.active = true
    }
  }

  Loader
  {
    id: applicationLoader
    active: false

    onStatusChanged: function()
    {
      if(applicationLoader.status === Loader.Ready)
        splashScreenLoader.active = false
    }
  }

  function _laterActiveSplashScreen() { splashScreenLoader.active = true }

  Component.onCompleted: () => Qt.callLater(_laterActiveSplashScreen)
}
