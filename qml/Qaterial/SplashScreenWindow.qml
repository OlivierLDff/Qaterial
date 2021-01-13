import QtQuick 2.0
import QtQuick.Window 2.0
import Qaterial 1.0 as Qaterial
import QtQuick.Controls.Material 2.12

Window
{
  id: window

  property alias from: splashScreen.from
  property alias to: splashScreen.to
  property alias value: splashScreen.value
  property alias indeterminate: splashScreen.indeterminate

  property alias image: splashScreen.image
  property alias padding: splashScreen.padding
  property alias text: splashScreen.text
  property alias version: splashScreen.version

  width: 400
  height: 200

  color: Qaterial.Style.backgroundColor
  flags: Qt.SplashScreen

  // Ugly trick for now : todo remove
  Material.theme: Qaterial.Style.theme
  Material.primary: Qaterial.Style.primaryColor
  Material.background: Qaterial.Style.backgroundColor
  Material.accent: Qaterial.Style.accentColor
  Material.foreground: Qaterial.Style.foregroundColor

  Qaterial.SplashScreen
  {
    id: splashScreen
    anchors.fill: parent
  }

  Component.onCompleted: () => visible = true
}
