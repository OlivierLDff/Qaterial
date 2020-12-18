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
      Qaterial.LabelHeadline6
      {
        id: title
        text: "Packet Counter"
      }
      Qaterial.LabelCaption
      {
        text: "Secondary info"
      }
    }

    Qaterial.ToolSeparator
    {
      height: parent.height
    }

    Column
    {
      Qaterial.LabelOverline
      {
        id: info
        text: "Info "
      }
      Qaterial.LabelCaption
      {
        text: "1 Hz - Total : 14.5K"
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
      Qaterial.LabelOverline
      {
        text: "Data"
      }
      Qaterial.LabelCaption
      {
        text: "60 Hz - Total : 25M"
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
