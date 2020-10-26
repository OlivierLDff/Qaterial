// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: control

  property alias color: indicator.color

  property bool active
  property bool pressed
  property bool hovered
  property bool horizontal

  property int thickness: 8
  property int hoveredThickness: 24
  property int pressedThickness: 48

  // Any of
  // - Qaterial.Style.Position.Left
  // - Qaterial.Style.Position.Right
  // - Qaterial.Style.Position.Top
  // - Qaterial.Style.Position.Bottom
  property int indicatorClip: -1

  width:
  {
    if(horizontal)
    {
      if(control.pressed)
        return control.pressedThickness
      if(control.hovered)
        return control.hoveredThickness
      return 0
    }
    else
    {
      return control.active ? control.thickness : 0
    }
  }

  height:
  {
    if(horizontal)
    {
      return control.active ? control.thickness : 0
    }
    else
    {
      if(control.pressed)
        return control.pressedThickness
      if(control.hovered)
        return control.hoveredThickness
      return 0
    }
  }

  Behavior on width { NumberAnimation { duration: 150;easing.type: Easing.InOutQuad } }
  Behavior on height { NumberAnimation { duration: 150;easing.type: Easing.InOutQuad } }

  Item
  {
    id: clipper

    clip: control.indicatorClip !== -1

    width:
    {
      if(!clip || (control.indicatorClip !== Qaterial.Style.Position.Left) && control.indicatorClip !== Qaterial.Style
        .Position.Right)
        return control.width
      return control.width / 2
    }

    height:
    {
      if(!clip || (control.indicatorClip !== Qaterial.Style.Position.Top) && control.indicatorClip !== Qaterial.Style
        .Position.Bottom)
        return control.height
      return control.height / 2
    }

    Rectangle
    {
      id: indicator

      x:
      {
        if(control.indicatorClip === Qaterial.Style.Position.Right)
          return -width / 2
        return 0
      }

      y:
      {
        if(control.indicatorClip === Qaterial.Style.Position.Top)
          return -height / 2
        return 0
      }

      width: control.width
      height: control.height

      radius: width / 2
    }
  }

  //Qaterial.DebugRectangle { anchors.fill: clipper }
}
