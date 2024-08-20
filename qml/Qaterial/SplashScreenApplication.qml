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
      {
        applicationLoader.active = true
        if(splashScreenLoader.item)
        {
          splashScreenLoader.item.show()
        }
        else
        {
          console.error("SplashScreenApplication: SplashScreen loaded, but item is null")
        }
      }
    }
  }

  Loader
  {
    id: applicationLoader
    active: false

    onStatusChanged: function()
    {
      if(applicationLoader.status === Loader.Ready)
      {
        if(applicationLoader.item)
        {
          applicationLoader.item.show()
          splashScreenLoader.item.close()
        }
        else
        {
          console.error("SplashScreenApplication: Application loaded, but item is null")
        }
      }
    }
  }

  function _laterActiveSplashScreen() { splashScreenLoader.active = true }

  Component.onCompleted: () => Qt.callLater(_laterActiveSplashScreen)
}
