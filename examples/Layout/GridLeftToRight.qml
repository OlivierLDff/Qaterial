import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Column
{
  id: root

  width: 100

  Qaterial.Label
  {
    anchors.horizontalCenter: parent.horizontalCenter
    text: `${root.width.toFixed(0)} dp`
    textType: Qaterial.Style.TextType.Title
    color: Qaterial.Colors.pink
  }

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

  Qaterial.Label
  {
    anchors.horizontalCenter: parent.horizontalCenter
    text: `Layout : ${root.layoutTypeToString(grid.type)}`
    textType: Qaterial.Style.TextType.Caption
  }

  Qaterial.Label
  {
    anchors.horizontalCenter: parent.horizontalCenter
    text: `Columns : ${grid.columns}`
    textType: Qaterial.Style.TextType.Hint
  }

  Item
  {
    width: parent.width
    height: 24

    Rectangle
    {
      anchors.top: parent.top
      anchors.bottom: parent.bottom

      width: 2
      color: Qaterial.Colors.pink
    }

    Rectangle
    {
      anchors.verticalCenter: parent.verticalCenter
      anchors.right: parent.right
      anchors.left: parent.left

      height: 2

      color: Qaterial.Colors.pink
    }

    Rectangle
    {
      anchors.right: parent.right
      anchors.top: parent.top
      anchors.bottom: parent.bottom

      width: 2

      color: Qaterial.Colors.pink
    }
  }

  SequentialAnimation
  {
    running: true
    loops: Animation.Infinite
    NumberAnimation { target: root;property: "width";to: 100;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "width";to: 360;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "width";to: 600;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "width";to: 960;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "width";to: 1280;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "width";to: 1600;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
  }

  Item
  {
    width: 1
    height: 16
  }

  Qaterial.DebugRectangle
  {
    anchors.horizontalCenter: parent.horizontalCenter

    implicitHeight: 600
    width: parent.width

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

      // Columns can be override by user
      // Otherwise it is breakpoint dependant
      //columns: 2

      width: parent.width

      leftPadding: 16
      rightPadding: 16
      topPadding: 8
      bottomPadding: 8

      Qaterial.DebugRectangle
      {
        Qaterial.Layout.extraLarge: Qaterial.Layout.FillQuarter
        Qaterial.Layout.large: Qaterial.Layout.FillQuarter
        Qaterial.Layout.medium: Qaterial.Layout.FillQuarter
        Qaterial.Layout.small: Qaterial.Layout.FillQuarter
        Qaterial.Layout.extraSmall: Qaterial.Layout.FillParent

        implicitHeight: 50
      }

      Qaterial.DebugRectangle
      {
        Qaterial.Layout.extraLarge: Qaterial.Layout.FillHalf
        Qaterial.Layout.large: Qaterial.Layout.FillHalf
        Qaterial.Layout.medium: Qaterial.Layout.FillHalf
        Qaterial.Layout.small: Qaterial.Layout.FillHalf
        Qaterial.Layout.extraSmall: Qaterial.Layout.FillParent

        implicitHeight: 50
      }

      Qaterial.DebugRectangle
      {
        Qaterial.Layout.extraLarge: Qaterial.Layout.FillQuarter
        Qaterial.Layout.large: Qaterial.Layout.FillQuarter
        Qaterial.Layout.medium: Qaterial.Layout.FillQuarter
        Qaterial.Layout.small: Qaterial.Layout.FillQuarter
        Qaterial.Layout.extraSmall: Qaterial.Layout.FillParent

        implicitHeight: 50
      }

      Qaterial.DebugRectangle
      {
        implicitHeight: 50

        border.color: Qaterial.Colors.blue
        Qaterial.Layout.large: Qaterial.Layout.FillQuarter
        Qaterial.Layout.extraLarge: Qaterial.Layout.FillSixth
      }

      Qaterial.DebugRectangle
      {
        implicitHeight: 50

        border.color: Qaterial.Colors.blue
        Qaterial.Layout.large: Qaterial.Layout.FillQuarter
        Qaterial.Layout.extraLarge: Qaterial.Layout.FillSixth
      }

      Qaterial.DebugRectangle
      {
        implicitHeight: 50

        border.color: Qaterial.Colors.blue
        Qaterial.Layout.large: Qaterial.Layout.FillQuarter
        Qaterial.Layout.extraLarge: Qaterial.Layout.FillSixth
      }

      Qaterial.DebugRectangle
      {
        implicitHeight: 50

        border.color: Qaterial.Colors.blue
        Qaterial.Layout.large: Qaterial.Layout.FillQuarter
        Qaterial.Layout.extraLarge: Qaterial.Layout.FillSixth
      }

      Qaterial.DebugRectangle
      {
        Qaterial.Layout.extraLarge: Qaterial.Layout.FillThird
        Qaterial.Layout.large: Qaterial.Layout.FillParent
        Qaterial.Layout.medium: Qaterial.Layout.FillHalf
        Qaterial.Layout.small: Qaterial.Layout.FillParent
        Qaterial.Layout.extraSmall: Qaterial.Layout.FillParent

        implicitHeight: 50

        border.color: Qaterial.Colors.green
      }

      Qaterial.DebugRectangle
      {
        Qaterial.Layout.extraLarge: Qaterial.Layout.FillParent
        Qaterial.Layout.large: Qaterial.Layout.FillParent
        Qaterial.Layout.medium: Qaterial.Layout.FillHalf
        Qaterial.Layout.small: Qaterial.Layout.FillParent
        Qaterial.Layout.extraSmall: Qaterial.Layout.FillParent

        implicitHeight: 50

        border.color: Qaterial.Colors.green
      }
    } // Grid
  } // DebugRectangle
}
