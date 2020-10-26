import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.SplashScreenWindow
{
  id: window

  width: 480
  height: 270
  image: "https://cdn.pixabay.com/photo/2018/11/14/20/50/hd-3816045_960_720.jpg"

  text: "Loading ..."
  version: Qaterial.Version.readable

  property int dots: 1

  Timer
  {
    interval: 1000;running: true;repeat: true
    onTriggered: function()
    {
      ++window.dots
      let text = "Loading "
      for(let i = 0; i < window.dots; ++i)
        text += '.'

      window.text = text
      if(window.dots == 3)
        window.dots = 0
    }
  }
}
