import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  implicitWidth: row.implicitWidth + sliderColumn.implicitWidth
  implicitHeight: row.implicitHeight + sliderColumn.implicitHeight

  property bool active: state === 1 || state === 0
  property bool pressed: state === 1
  property bool hovered: state === 0

  property int state: 0

  Timer
  {
    interval: 500
    running: true
    repeat: true
    onTriggered: function()
    {
      ++root.state
      if(root.state == 3)
        root.state = 0
    }
  }

  Row
  {
    id: row

    anchors.horizontalCenter: parent.horizontalCenter

    spacing: 8

    Item
    {
      width: Math.max(sliderHoveredThickness.value, sliderPressedThickness.value) + 12
      height: Math.max(sliderHoveredThickness.value, sliderPressedThickness.value) + 12

      Qaterial.SideSelectIndicator
      {
        anchors.centerIn: parent

        active: root.active
        pressed: root.pressed
        hovered: root.hovered
        horizontal: false
      }
    }

    Item
    {
      width: Math.max(sliderHoveredThickness.value, sliderPressedThickness.value) + 12
      height: Math.max(sliderHoveredThickness.value, sliderPressedThickness.value) + 12

      Qaterial.SideSelectIndicator
      {
        anchors.centerIn: parent

        active: root.active
        pressed: root.pressed
        hovered: root.hovered
        horizontal: true
      }
    }

    Item
    {
      width: Math.max(sliderHoveredThickness.value, sliderPressedThickness.value) + 12
      height: Math.max(sliderHoveredThickness.value, sliderPressedThickness.value) + 12

      Qaterial.SideSelectIndicator
      {
        anchors.centerIn: parent

        active: root.active
        pressed: root.pressed
        hovered: root.hovered
        horizontal: true

        thickness: sliderThickness.value
        hoveredThickness: sliderHoveredThickness.value
        pressedThickness: sliderPressedThickness.value
        indicatorClip: Qaterial.Style.Position.Bottom
      }
    }

    Item
    {
      width: Math.max(sliderHoveredThickness.value, sliderPressedThickness.value) + 12
      height: Math.max(sliderHoveredThickness.value, sliderPressedThickness.value) + 12

      Qaterial.SideSelectIndicator
      {
        anchors.centerIn: parent

        active: root.active
        pressed: root.pressed
        hovered: root.hovered
        horizontal: true

        thickness: sliderThickness.value
        hoveredThickness: sliderHoveredThickness.value
        pressedThickness: sliderPressedThickness.value
        indicatorClip: Qaterial.Style.Position.Top
      }
    }

    Item
    {
      width: Math.max(sliderHoveredThickness.value, sliderPressedThickness.value) + 12
      height: Math.max(sliderHoveredThickness.value, sliderPressedThickness.value) + 12

      Qaterial.SideSelectIndicator
      {
        anchors.centerIn: parent

        active: root.active
        pressed: root.pressed
        hovered: root.hovered
        horizontal: false

        thickness: sliderThickness.value
        hoveredThickness: sliderHoveredThickness.value
        pressedThickness: sliderPressedThickness.value
        indicatorClip: Qaterial.Style.Position.Left
      }
    }

    Item
    {
      width: Math.max(sliderHoveredThickness.value, sliderPressedThickness.value) + 12
      height: Math.max(sliderHoveredThickness.value, sliderPressedThickness.value) + 12

      Qaterial.SideSelectIndicator
      {
        anchors.centerIn: parent

        active: root.active
        pressed: root.pressed
        hovered: root.hovered
        horizontal: false

        thickness: sliderThickness.value
        hoveredThickness: sliderHoveredThickness.value
        pressedThickness: sliderPressedThickness.value
        indicatorClip: Qaterial.Style.Position.Right
      }
    }
  }

  Qaterial.DebugRectangle { anchors.fill: row }

  Column
  {
    id: sliderColumn

    anchors.topMargin: 24
    anchors.top: row.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    Qaterial.SliderDelegate
    {
      id: sliderThickness

      text: "thickness"
      secondaryText: value

      from: 2
      to: 16
      value: 8
      stepSize: 1
    }

    Qaterial.SliderDelegate
    {
      id: sliderHoveredThickness

      text: "hoveredThickness"
      secondaryText: value

      from: 2
      to: sliderPressedThickness.value
      value: 24
      stepSize: 1
    }

    Qaterial.SliderDelegate
    {
      id: sliderPressedThickness

      text: "pressedThickness"
      secondaryText: value

      from: sliderHoveredThickness.value
      to: 200
      value: 48
      stepSize: 1
    }
  }
}
