import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Column
{
  id: root

  spacing: Qaterial.Style.largeSpacing

  Row
  {
    anchors.horizontalCenter: parent.horizontalCenter

    spacing: Qaterial.Style.largeSpacing

    Column
    {
      spacing: Qaterial.Style.smallSpacing

      Qaterial.Icon
      {
        anchors.horizontalCenter: parent.horizontalCenter
        icon: Qaterial.Icons.abacus
      }

      Qaterial.Label { text: "enabled" }
    }

    Column
    {
      spacing: Qaterial.Style.smallSpacing

      Qaterial.Icon
      {
        anchors.horizontalCenter: parent.horizontalCenter
        icon: Qaterial.Icons.abacus
        enabled: false
      }

      Qaterial.Label { text: "disabled" }
    }
  }

  Row
  {
    anchors.horizontalCenter: parent.horizontalCenter

    spacing: Qaterial.Style.largeSpacing

    Column
    {
      anchors.bottom: parent.bottom

      spacing: Qaterial.Style.smallSpacing

      Qaterial.Icon
      {
        anchors.horizontalCenter: parent.horizontalCenter

        icon: Qaterial.Icons.accountHardHat
        color: Qaterial.Colors.red
        size: Qaterial.Style.smallIcon

        Qaterial.DebugRectangle { anchors.fill: parent }
      }

      Qaterial.Label
      {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "small"
      }
    }

    Column
    {
      anchors.bottom: parent.bottom

      spacing: Qaterial.Style.smallSpacing

      Qaterial.Icon
      {
        anchors.horizontalCenter: parent.horizontalCenter

        icon: Qaterial.Icons.accountHardHat
        color: Qaterial.Colors.green
        size: Qaterial.Style.mediumIcon

        Qaterial.DebugRectangle { anchors.fill: parent }
      }

      Qaterial.Label
      {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "medium"
      }
    }

    Column
    {
      anchors.bottom: parent.bottom

      spacing: Qaterial.Style.smallSpacing

      Qaterial.Icon
      {
        anchors.horizontalCenter: parent.horizontalCenter

        icon: Qaterial.Icons.accountHardHat
        color: Qaterial.Colors.blue
        size: Qaterial.Style.largeIcon

        Qaterial.DebugRectangle { anchors.fill: parent }
      }

      Qaterial.Label
      {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "large"
      }
    }
  }

  Row
  {
    anchors.horizontalCenter: parent.horizontalCenter

    spacing: Qaterial.Style.largeSpacing

    Column
    {
      anchors.bottom: parent.bottom

      spacing: Qaterial.Style.smallSpacing

      Qaterial.Icon
      {
        anchors.horizontalCenter: parent.horizontalCenter

        icon: "https://www.flaticon.com/svg/static/icons/svg/119/119591.svg"
        color: "transparent"
        size: Qaterial.Style.largeIcon
      }

      Qaterial.Label
      {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "transparent"
      }
    }

    Column
    {
      anchors.bottom: parent.bottom

      spacing: Qaterial.Style.smallSpacing

      Qaterial.Icon
      {
        anchors.horizontalCenter: parent.horizontalCenter

        icon: "https://www.flaticon.com/svg/static/icons/svg/119/119591.svg"
        color: "transparent"
        size: Qaterial.Style.largeIcon
        enabled: false
      }

      Qaterial.Label
      {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "disabled"
      }
    }
  }
}
