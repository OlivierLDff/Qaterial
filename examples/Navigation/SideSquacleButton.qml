import QtQuick 2.0
import Qaterial 1.0 as Qaterial
import QtGraphicalEffects 1.12

Column
{
  spacing: 10

  Row
  {
    spacing: 10

    anchors.horizontalCenter: parent.horizontalCenter

    Qaterial.SideSquacleButton
    {
      icon.source: Qaterial.Icons.viewDashboard
      indicatorPosition: Qaterial.Style.Position.Left

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.SideSquacleButton
    {
      icon.source: Qaterial.Icons.rocketLaunchOutline
      indicatorPosition: Qaterial.Style.Position.Top

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.SideSquacleButton
    {
      icon.source: Qaterial.Icons.camera
      indicatorPosition: Qaterial.Style.Position.Right

      Qaterial.DebugRectangle { anchors.fill: parent }
    }

    Qaterial.SideSquacleButton
    {
      icon.source: Qaterial.Icons.humanGreeting
      indicatorPosition: Qaterial.Style.Position.Bottom

      Qaterial.DebugRectangle { anchors.fill: parent }
    }
  }

  Row
  {
    spacing: 10

    anchors.horizontalCenter: parent.horizontalCenter

    Qaterial.SideSquacleButton
    {
      icon.source: Qaterial.Icons.compassOutline
      indicatorPosition: Qaterial.Style.Position.Bottom

      color: Qaterial.Colors.pink500

      clip: true
    }

    Qaterial.SideSquacleImageButton
    {
      indicatorPosition: Qaterial.Style.Position.Bottom

      icon
      .source: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Qt_logo_2016.svg/langfr-1280px-Qt_logo_2016.svg.png"
      icon.width: 68
      icon.height: 68

      clip: true
    }

    Qaterial.SideSquacleImageButton
    {
      indicatorPosition: Qaterial.Style.Position.Bottom

      color: Qaterial.Colors.red500

      icon.source: "https://www.flaticon.com/svg/static/icons/svg/129/129498.svg"
      icon.width: 32
      icon.height: 32

      clip: true
    }

    Qaterial.SideSquacleImageButton
    {
      indicatorPosition: Qaterial.Style.Position.Bottom

      color: Qaterial.Colors.blue600
      backgroundColor: Qaterial.Colors.blueGray500

      icon.source: "https://www.flaticon.com/svg/static/icons/svg/3135/3135341.svg"
      icon.width: 40
      icon.height: 40

      clip: true
    }
  }
}
