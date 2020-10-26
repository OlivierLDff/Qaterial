import QtQuick 2.12
import QtQuick.Controls 2.14
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  function copy(textToCopy)
  {
    Qaterial.Clipboard.text = textToCopy
    Qaterial.SnackbarManager.show(`ToolTip Position Copied! \n'${textToCopy}'`)
  }

  width: 2 * bottomLeft.width + rectangle.width + 2 * bottomRight.width
  height: 2 * top.height + rectangle.height + 2 * bottom.height + label.height + 20

  Qaterial.Label
  {
    id: label
    x: (parent.width - width) / 2
    y: 5
    width: parent.width
    horizontalAlignment: Text.AlignHCenter

    wrapMode: Text.Wrap
    elide: Text.ElideRight
    text: "ToolTip are displayed spaced apart by \"margins/2\" pixels from their parent's border (default: margins = 12)"
    textType: Qaterial.Style.TextType.Caption
  }

  Rectangle
  {
    id: rectangle
    anchors.centerIn: parent
    width: 370
    height: 150
    color: "transparent"
    border.color: Qaterial.Style.dividersColor()
    radius: 4

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: topLeft
      x: -width
      y: -height
      text: "TopLeft"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "TopLeft"
        visible: topLeft.hovered || topLeft.pressed
        position: Qaterial.Style.Position.TopLeft
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.TopLeft")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: topStart
      x: 0
      y: -height
      text: "TopStart"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "TopStart"
        visible: topStart.hovered || topStart.pressed
        position: Qaterial.Style.Position.TopStart
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.TopStart")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: top
      x: (parent.width - width) / 2
      y: -height
      text: "Top"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "Top"
        visible: top.hovered || top.pressed
        position: Qaterial.Style.Position.Top
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.Top")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: topEnd
      x: parent.width - width
      y: -height
      text: "TopEnd"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "TopEnd"
        visible: topEnd.hovered || topEnd.pressed
        position: Qaterial.Style.Position.TopEnd
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.TopEnd")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: topRight
      x: parent.width
      y: -height
      text: "TopRight"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "TopRight"
        visible: topRight.hovered || topRight.pressed
        position: Qaterial.Style.Position.TopRight
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.TopRight")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: rightStart
      x: parent.width
      y: 0
      text: "RightStart"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "RightStart"
        visible: rightStart.hovered || rightStart.pressed
        position: Qaterial.Style.Position.RightStart
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.RightStart")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: right
      x: parent.width
      y: (parent.height - height) / 2
      text: "Right"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "Right"
        visible: right.hovered || right.pressed
        position: Qaterial.Style.Position.Right
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.Right")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: rightEnd
      x: parent.width
      y: parent.height - height
      text: "RightEnd"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "RightEnd"
        visible: rightEnd.hovered || rightEnd.pressed
        position: Qaterial.Style.Position.RightEnd
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.RightEnd")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: bottomRight
      x: parent.width
      y: parent.height
      text: "BottomRight"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "BottomRight"
        visible: bottomRight.hovered || bottomRight.pressed
        position: Qaterial.Style.Position.BottomRight
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.BottomRight")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: bottomEnd
      x: parent.width - width
      y: parent.height
      text: "BottomEnd"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "BottomEnd"
        visible: bottomEnd.hovered || bottomEnd.pressed
        position: Qaterial.Style.Position.BottomEnd
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.BottomEnd")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: bottom
      x: (parent.width - width) / 2
      y: parent.height
      text: "Bottom"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "Bottom"
        visible: bottom.hovered || bottom.pressed
        position: Qaterial.Style.Position.Bottom
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.Bottom")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: bottomStart
      x: 0
      y: parent.height
      text: "BottomStart"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "BottomStart"
        visible: bottomStart.hovered || bottomStart.pressed
        position: Qaterial.Style.Position.BottomStart
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.BottomStart")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: bottomLeft
      x: -width
      y: parent.height
      text: "BottomLeft"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "BottomLeft"
        visible: bottomLeft.hovered || bottomLeft.pressed
        position: Qaterial.Style.Position.BottomLeft
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.BottomLeft")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: leftEnd
      x: -width
      y: parent.height - height
      text: "LeftEnd"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "LeftEnd"
        visible: leftEnd.hovered || leftEnd.pressed
        position: Qaterial.Style.Position.LeftEnd
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.LeftEnd")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: left
      x: -width
      y: (parent.height - height) / 2
      text: "Left"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "Left"
        visible: left.hovered || left.pressed
        position: Qaterial.Style.Position.Left
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.Left")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: leftStart
      x: -width
      y: 0
      text: "LeftStart"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "LeftStart"
        visible: leftStart.hovered || leftStart.pressed
        position: Qaterial.Style.Position.LeftStart
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.LeftStart")
    } // FlatButton

    Qaterial.FlatButton
    {
      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
      id: center
      x: (parent.width - width) / 2
      y: (parent.height - height) / 2
      text: "Center"
      highlighted: false

      Qaterial.ToolTip
      {
        text: "Center"
        visible: center.hovered || center.pressed
        position: Qaterial.Style.Position.Center
      } // ToolTip

      onClicked: root.copy("Qaterial.Style.Position.Center")
    } // FlatButton
  } // Rectangle
} // Item
