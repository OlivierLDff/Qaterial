import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Column
{
  id: root

  width: 360

  spacing: 8

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
    text: `Layout : ${grid.fixedPadding}`
    textType: Qaterial.Style.TextType.Caption
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

  Item
  {
    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width - parent.width % 2
    implicitHeight: page.height

    Qaterial.Page
    {
      id: page

      width: parent.width
      height: 500
      header: Qaterial.ToolBar
      {
        Qaterial.AppBarButton
        {
          icon.source: Qaterial.Icons.menu
        }
      }

      background: Rectangle
      {
        implicitHeight: Qaterial.Style.toolbar.implicitHeight
        color: Qaterial.Style.backgroundColor

        layer.enabled: true
        layer.effect: Qaterial.ElevationEffect
        {
          elevation: 2
          fullWidth: true
        } // ElevationEffect

        radius: 4
      } // Rectangle

      Column
      {
        width: parent.width

        Qaterial.Label
        {
          text: "Fixed Grid"
          textType: Qaterial.Style.TextType.Subheading

          leftPadding: grid.leftPadding
          topPadding: grid.spacing
          bottomPadding: grid.spacing
        }

        Qaterial.FixedGrid
        {
          id: grid
          width: parent.width

          Repeater
          {
            delegate: Qaterial.Card
            {
              parent: grid

              implicitWidth: implicitBackgroundWidth + leftInset + rightInset

              height: 100

              Qaterial.Layout.extraSmall: modelData
              Qaterial.Layout.small: modelData
              Qaterial.Layout.medium: modelData
              Qaterial.Layout.large: modelData
              Qaterial.Layout.extraLarge: modelData

              Qaterial.Label
              {
                anchors.centerIn: parent
                text: `${parent.width.toFixed(0)} dp`
              }
            }

            Component.onCompleted: function()
            {
              model = [Qaterial.Layout.FillParent,
                Qaterial.Layout.FillHalf, Qaterial.Layout.FillHalf,
                Qaterial.Layout.FillQuarter, Qaterial.Layout.FillQuarter,
                Qaterial.Layout.FillQuarter, Qaterial.Layout.FillQuarter
              ]
            }
          }
        } // FluidGrid
      }
    }

    Qaterial.DebugGridOverlay
    {
      id: debugOverlay

      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      anchors.bottom: parent.bottom
      width: parent.width - parent.width % 2

      leftPadding: grid.leftPadding
      rightPadding: grid.rightPadding
      topPadding: grid.topPadding
      bottomPadding: grid.bottomPadding

      spacing: grid.spacing
      columns: grid.columns

      flow: grid.flow

      opacity: 0
    }
  }

  Item
  {
    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width - parent.width % 2
    height: 24

    Repeater
    {
      model: grid.columns > 0 ? grid.columns : 0
      delegate: Item
      {
        width: oneBlockSize
        height: parent.height
        x: grid.leftPadding + oneBlockSize * (index) + grid.spacing * index

        readonly property int paddingLessWidth: grid.width - grid.leftPadding - grid.rightPadding
        readonly property real oneBlockSize: Math.floor(paddingLessWidth - (grid.columns - 1) * grid.spacing) / grid
          .columns

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
    }
  }

  SequentialAnimation
  {
    running: true
    loops: Animation.Infinite
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: debugOverlay;property: "opacity";to: 0.1;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "width";to: 600;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "width";to: 960;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "width";to: 1280;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: debugOverlay;property: "opacity";to: 0;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: root;property: "width";to: 360;duration: 1000;easing.type: Easing.OutQuad }
    PauseAnimation { duration: 1000 }
    NumberAnimation { target: debugOverlay;property: "opacity";to: 0;duration: 1000;easing.type: Easing.OutQuad }
  }

}
