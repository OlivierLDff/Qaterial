import QtQuick 2.13
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.12

Item
{
  id: root

  implicitWidth: 100
  implicitHeight: 100

  property color color: "yellow"
  property real black
  property real white

  LinearGradient
  {
    anchors.fill: parent
    start: Qt.point(0, 0)
    end: Qt.point(parent.width, 0)
    gradient: Gradient
    {
      GradientStop { position: 0.0;color: "white" }
      GradientStop { position: 1.0;color: root.color }
    }
  }

  LinearGradient
  {
    anchors.fill: parent
    start: Qt.point(0, 0)
    end: Qt.point(0, parent.height)
    gradient: Gradient
    {
      GradientStop { position: 0.0;color: "transparent" }
      GradientStop { position: 1.0;color: "black" }
    }
  }

  Rectangle
  {
    y: 200;width: 16;height: 200
    radius: width / 2
    transformOrigin: Item.TopLeft
    rotation: -90
    gradient: Gradient
    {
      GradientStop
      {
        position: 0.000
        color: Qt.rgba(1, 0, 0, 1)
      }
      GradientStop
      {
        position: 0.167
        color: Qt.rgba(1, 1, 0, 1)
      }
      GradientStop
      {
        position: 0.333
        color: Qt.rgba(0, 1, 0, 1)
      }
      GradientStop
      {
        position: 0.500
        color: Qt.rgba(0, 1, 1, 1)
      }
      GradientStop
      {
        position: 0.667
        color: Qt.rgba(0, 0, 1, 1)
      }
      GradientStop
      {
        position: 0.833
        color: Qt.rgba(1, 0, 1, 1)
      }
      GradientStop
      {
        position: 1.000
        color: Qt.rgba(1, 0, 0, 1)
      }
    }
  }

  LinearGradient
  {
    y: 250;
    width: 200
    height: 16
    start: Qt.point(0, 0)
    end: Qt.point(width, 0)

    source: Rectangle
    {
      width: 200
      height: 16
      radius: 8
    }

    gradient: Gradient
    {
      GradientStop
      {
        position: 0.000
        color: Qt.rgba(1, 0, 0, 1)
      }
      GradientStop
      {
        position: 0.167
        color: Qt.rgba(1, 1, 0, 1)
      }
      GradientStop
      {
        position: 0.333
        color: Qt.rgba(0, 1, 0, 1)
      }
      GradientStop
      {
        position: 0.500
        color: Qt.rgba(0, 1, 1, 1)
      }
      GradientStop
      {
        position: 0.667
        color: Qt.rgba(0, 0, 1, 1)
      }
      GradientStop
      {
        position: 0.833
        color: Qt.rgba(1, 0, 1, 1)
      }
      GradientStop
      {
        position: 1.000
        color: Qt.rgba(1, 0, 0, 1)
      }
    }
  }
}
