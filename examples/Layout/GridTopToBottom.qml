import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Row
{
  id: root

  height: 100

  function layoutTypeToString(type)
  {
    switch (type)
    {
      case Qaterial.Layout.ExtraLarge:
        return "Extra Large"
      case Qaterial.Layout.Large:
        return "Large"
      case Qaterial.Layout.Medium:
        return "Medium"
      case Qaterial.Layout.Small:
        return "Small"
      case Qaterial.Layout.ExtraSmall:
        return "Extra Small"
    }
    return "Unknown"
  }

  Column
  {
    anchors.verticalCenter: parent.verticalCenter
    width: 100

    Qaterial.Label
    {
      anchors.right: parent.right
      text: `${root.height.toFixed(0)} dp`
      textType: Qaterial.Style.TextType.Title
      color: Qaterial.Colors.pink
    }

    Qaterial.Label
    {
      anchors.right: parent.right
      text: `Layout : ${root.layoutTypeToString(grid.type)}`
      textType: Qaterial.Style.TextType.Caption
    }
  }

  Item
  {
    anchors.bottom: parent.bottom
    anchors.top: parent.top

    width: 24

    Rectangle
    {
      anchors.left: parent.left
      anchors.right: parent.right

      height: 2
      color: Qaterial.Colors.pink
    }

    Rectangle
    {
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.bottom: parent.bottom
      anchors.top: parent.top

      width: 2

      color: Qaterial.Colors.pink
    }

    Rectangle
    {
      anchors.bottom: parent.bottom
      anchors.left: parent.left
      anchors.right: parent.right

      height: 2

      color: Qaterial.Colors.pink
    }
  }

  SequentialAnimation
  {
    running: true
    loops: Animation.Infinite
    NumberAnimation { target: root;property: "height";to: 100;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "height";to: 360;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "height";to: 600;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "height";to: 960;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "height";to: 1280;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
  }

  Item
  {
    height: 1
    width: 16
  }

  Qaterial.DebugRectangle
  {
    anchors.verticalCenter: parent.verticalCenter

    implicitWidth: 1000
    height: parent.height

    Qaterial.DebugGridOverlay
    {
      anchors.fill: parent

      leftPadding: grid.leftPadding
      rightPadding: grid.rightPadding
      topPadding: grid.topPadding
      bottomPadding: grid.bottomPadding

      spacing: grid.spacing
      columns: grid.columns

      flow: grid.flow
    }

    Qaterial.Grid
    {
      id: grid

      height: parent.height

      flow: Flow.TopToBottom

      spacing: 16
      leftPadding: 16
      rightPadding: 16
      topPadding: 16
      bottomPadding: 16

      Qaterial.DebugRectangle
      {
        Qaterial.Layout.extraLarge: Qaterial.Layout.FillQuarter
        Qaterial.Layout.large: Qaterial.Layout.FillQuarter
        Qaterial.Layout.medium: Qaterial.Layout.FillQuarter
        Qaterial.Layout.small: Qaterial.Layout.FillQuarter
        Qaterial.Layout.extraSmall: Qaterial.Layout.FillQuarter

        implicitWidth: 100
      }

      Qaterial.DebugRectangle
      {
        Qaterial.Layout.extraLarge: Qaterial.Layout.FillHalf
        Qaterial.Layout.large: Qaterial.Layout.FillHalf
        Qaterial.Layout.medium: Qaterial.Layout.FillHalf
        Qaterial.Layout.small: Qaterial.Layout.FillHalf
        Qaterial.Layout.extraSmall: Qaterial.Layout.FillHalf

        implicitWidth: 100
      }

      Qaterial.DebugRectangle
      {
        Qaterial.Layout.extraLarge: Qaterial.Layout.FillQuarter
        Qaterial.Layout.large: Qaterial.Layout.FillQuarter
        Qaterial.Layout.medium: Qaterial.Layout.FillQuarter
        Qaterial.Layout.small: Qaterial.Layout.FillQuarter
        Qaterial.Layout.extraSmall: Qaterial.Layout.FillQuarter

        implicitWidth: 100
      }

      Qaterial.DebugRectangle
      {
        implicitWidth: 100

        border.color: Qaterial.Colors.green
      }

      Qaterial.DebugRectangle
      {
        implicitWidth: 100

        border.color: Qaterial.Colors.green
      }

      Qaterial.DebugRectangle
      {
        implicitWidth: 100

        border.color: Qaterial.Colors.green
      }

      Qaterial.DebugRectangle
      {
        implicitWidth: 100

        border.color: Qaterial.Colors.green
      }

      Qaterial.DebugRectangle
      {
        implicitWidth: 100

        border.color: Qaterial.Colors.green
      }

      Qaterial.DebugRectangle
      {
        implicitWidth: 100
        Qaterial.Layout.extraLarge: Qaterial.Layout.FillHalf + Qaterial.Layout.FillTwelfth

        border.color: Qaterial.Colors.green
      }

      Qaterial.DebugRectangle
      {
        Qaterial.Layout.extraLarge: Qaterial.Layout.FillParent
        Qaterial.Layout.large: Qaterial.Layout.FillParent
        Qaterial.Layout.medium: Qaterial.Layout.FillHalf
        Qaterial.Layout.small: Qaterial.Layout.FillParent
        Qaterial.Layout.extraSmall: Qaterial.Layout.FillParent

        implicitWidth: 100

        border.color: Qaterial.Colors.blue
      }
    }
  }
}
