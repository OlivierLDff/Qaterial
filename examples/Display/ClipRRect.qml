import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Row
{
  id: root

  property real radius

  spacing: 10

  Qaterial.ClipRRect
  {
    width: 96
    height: 96
    radius: root.radius

    Rectangle
    {
      anchors.fill: parent
      color: Qaterial.Colors.red

      Qaterial.Label
      {
        text: "ClipRRect"
        anchors.centerIn: parent
      }
    }
  }

  Qaterial.ClipRRect
  {
    width: 96
    height: 48
    radius: root.radius

    Rectangle
    {
      anchors.fill: parent
      color: Qaterial.Colors.orange

      Qaterial.Label
      {
        text: "ClipRRect"
        anchors.centerIn: parent
      }
    }
  }

  Qaterial.ClipRRect
  {
    width: 48
    height: 96
    radius: root.radius

    Rectangle
    {
      anchors.fill: parent
      color: Qaterial.Colors.pink

      Qaterial.Label
      {
        rotation: -90
        text: "ClipRRect"
        anchors.centerIn: parent
      }
    }
  }

  Qaterial.ClipRRect
  {
    width: 96
    height: 96
    radius: root.radius

    Image
    {
      anchors.fill: parent
      fillMode: Image.PreserveAspectCrop
      source: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Qt_logo_2016.svg/langfr-1280px-Qt_logo_2016.svg.png"
    }
  }

  SequentialAnimation
  {
    running: true
    loops: Animation.Infinite
    NumberAnimation { target: root;property: "radius";to: 24;duration: 500 }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "radius";to: 48;duration: 500 }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "radius";to: 0;duration: 500 }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "radius";to: 4;duration: 500 }
    PauseAnimation { duration: 1000 }
  }
}
