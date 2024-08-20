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
      if(!active)
        return

      if(splashScreenLoader.status === Loader.Ready && !applicationLoader.active)
      {
        applicationLoader.active = true
        if(splashScreenLoader.item)
        {
          console.log("SplashScreenLoaderApplication: SplashScreen loaded")
          splashScreenLoader.item.show()
        }
        else
        {
          console.error("SplashScreenLoaderApplication: SplashScreen loaded, but item is null")
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
          console.log("SplashScreenApplication: Application loaded")
          applicationLoader.item.show()

          console.log("Deactivate splashScreenLoader")
          Qt.callLater(_laterDeactiveSplashScreen)
        }
        else
        {
          console.error("SplashScreenApplication: Application loaded, but item is null")
        }
      }
    }
  }

  function _laterActiveSplashScreen() { splashScreenLoader.active = true }

  function _laterDeactiveSplashScreen() { splashScreenLoader.active = false }

  Component.onCompleted: () => Qt.callLater(_laterActiveSplashScreen)
}
