import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0 as Qaterial

T.Button
{
  id: control

  property color foregroundColor: Qaterial.Style.primaryTextColor()
  property color color: Qaterial.Style.accentColor
  property color backgroundColor: Qaterial.Style.dialogColor

  property bool active: highlighted || hovered || pressed
  property bool squared: active || visualFocus

  implicitWidth: implicitBackgroundWidth + leftInset + rightInset
  implicitHeight: implicitBackgroundHeight + topInset + bottomInset

  icon.color: active ? foregroundColor : color
  padding: width/4

  topInset: 8
  bottomInset: 8
  leftInset: 8
  rightInset: 8

  contentItem: Qaterial.Icon
  {
    icon: control.icon.source
    color: control.icon.color

    Behavior on color { ColorAnimation { duration: 150; easing.type: Easing.InOutQuad } }
  }

  background: Rectangle
  {
    id: backgroundRect

    implicitWidth: 48
    implicitHeight: 48

    radius: control.squared ? 16 : width/2
    color: control.active ? control.color : control.backgroundColor

    Behavior on color { ColorAnimation { duration: 150; easing.type: Easing.InOutQuad } }
    Behavior on radius { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }

    Qaterial.Ripple
    {
      id: ripple

      anchors.fill: parent

      pressed: control.pressed
      anchor: control
      active: control.down || control.visualFocus || control.hovered
      color: Qaterial.Style.rippleColor(Qaterial.Style.RippleBackground.Background)

      // trick because clipRadius isn't working in ripple private implementation (QTBUG-51894)
      layer.enabled: true
      layer.effect: OpacityMask
      {
        maskSource: Rectangle
        {
          width: backgroundRect.width
          height: backgroundRect.height
          radius: backgroundRect.radius
        } // Rectangle
      } // OpacityMask
    } // Ripple

    //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "red" }
  }
  //Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" }
}
