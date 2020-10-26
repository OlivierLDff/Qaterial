import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.ItemDelegate
{
  id: root
  contentItem: Row
  {
    spacing: 4
    Item
    {
      anchors.verticalCenter: parent.verticalCenter
      width: 30
      height: 10
      Qaterial.ColorIcon
      {
        source: Qaterial.Icons.rocketLaunchOutline
        y: parent.height / 2 - height / 2
      }
    }
    Column
    {
      anchors.verticalCenter: parent.verticalCenter
      Qaterial.Label
      {
        id: title
        textType: Qaterial.Style.TextType.Title
        text: "Packet Counter"
      }
      Qaterial.Label
      {
        textType: Qaterial.Style.TextType.Caption
        text: "Secondary info"
      }
    }

    Qaterial.ToolSeparator
    {
      height: parent.height
    }

    Column
    {
      Qaterial.Label
      {
        id: info
        text: "Info "
        textType: Qaterial.Style.TextType.Overline
      }
      Qaterial.Label
      {
        text: "1 Hz - Total : 14.5K"
        textType: Qaterial.Style.TextType.Caption
      }

      Item
      {
        width: parent.width
        height: 20

        Rectangle
        {
          y: 10
          color: "#009688"
          width: 50
          height: 2
          rotation: 10

        }
        Rectangle
        {
          x: 47
          y: 12
          color: "#009688"
          width: 50
          height: 2
          rotation: -5

        }
      }
    }

    Qaterial.ToolSeparator
    {
      height: parent.height
    }

    Column
    {
      Qaterial.Label
      {
        text: "Data"
        textType: Qaterial.Style.TextType.Overline
      }
      Qaterial.Label
      {
        text: "60 Hz - Total : 25M"
        textType: Qaterial.Style.TextType.Caption
      }

      Item
      {
        width: parent.width
        height: 20

        Rectangle
        {
          y: 10
          color: "#4CAF50"
          width: 50
          height: 2
          rotation: -5

        }
        Rectangle
        {
          x: 47
          y: 12
          color: "#4CAF50"
          width: 50
          height: 2
          rotation: 10

        }
      }
    }

    Qaterial.ToolSeparator
    {
      height: parent.height
    }

    Qaterial.ColorIcon
    {
      source: Qaterial.Icons.chevronDown
      anchors.verticalCenter: parent.verticalCenter
    }
  }
}
