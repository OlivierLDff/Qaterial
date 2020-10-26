import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

import Qaterial 1.0 as Qaterial

T.Button
{
  id: control

  // Scale the contentItem on hovered. Very nice with number, not that much with [a-zA-Z] text
  property bool zoomLabelOnHovered: true

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding)

  topInset: Qaterial.Style.fab.flatInset
  bottomInset: Qaterial.Style.fab.flatInset
  leftInset: Qaterial.Style.fab.flatInset
  rightInset: Qaterial.Style.fab.flatInset

  horizontalPadding: Qaterial.Style.roundIcon.size / 4

  contentItem: Qaterial.Label
  {
    text: control.text
    textType: Qaterial.Style.TextType.Button

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    scale: (control.hovered && control.zoomLabelOnHovered) ? 1.10 : 1

    Binding on color
    {
      when: control.highlighted && !control.checked
      value: Qaterial.Style.accentColor
    }
    // Qaterial.DebugRectangle { anchors.fill: parent; border.color: "red" }
  } // Label

  background: Rectangle
  {
    readonly property color checkedColor: Qaterial.Style.accentColor
    readonly property color hoveredColor: Qaterial.Style.rippleColor(Qaterial.Style.RippleBackground.AccentLight)

    implicitWidth: Qaterial.Style.roundIcon.size - Qaterial.Style.fab.flatInset * 2
    implicitHeight: Qaterial.Style.roundIcon.size - Qaterial.Style.fab.flatInset * 2

    radius: height / 2
    color:
    {
      if(control.checked)
        return checkedColor
      return control.hovered ? hoveredColor : "transparent"
    }
    // Qaterial.DebugRectangle { anchors.fill: parent; border.color: "green" }
  }
  // Qaterial.DebugRectangle { anchors.fill: parent; border.color: "violet" }
}
