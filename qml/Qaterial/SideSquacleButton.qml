import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.SquacleButton
{
  id: control
  readonly property bool horizontal: indicatorPosition === Qaterial.Style.Position.Top || indicatorPosition ===
    Qaterial.Style.Position.Bottom

  property int indicatorPosition: Qaterial.Style.Position.Left

  topInset: horizontal ? 8 : 8
  bottomInset: horizontal ? 8 : 8
  leftInset: horizontal ? 8 : 12
  rightInset: horizontal ? 8 : 12

  Qaterial.SideSelectIndicator
  {
    x:
    {
      if(control.indicatorPosition === Qaterial.Style.Position.Left)
        return -width / 2
      if(control.indicatorPosition === Qaterial.Style.Position.Right)
        return parent.width - width / 2

      return parent.width / 2 - width / 2
    }

    y:
    {
      if(control.indicatorPosition === Qaterial.Style.Position.Top)
        return -height / 2
      if(control.indicatorPosition === Qaterial.Style.Position.Bottom)
        return parent.height - height / 2

      return parent.height / 2 - height / 2
    }

    color: control.color

    active: control.active
    pressed: control.highlighted || control.pressed
    hovered: control.hovered
    horizontal: control.horizontal
  }

  //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
}
