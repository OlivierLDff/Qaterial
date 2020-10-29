import QtQuick 2.12
import QtQuick.Controls 2.12

import Qaterial 1.0 as Qaterial

Rectangle
{
  id: root
  implicitWidth: 280
  implicitHeight: 80
  radius: Qaterial.Style.dialog.radius
  color: Qaterial.Style.accentColor

  property string text

  Rectangle
  {
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height: parent.height / 2
    color: parent.color
  }

  Qaterial.Label
  {
    leftPadding: 20
    anchors.verticalCenter: parent.verticalCenter
    textType: Qaterial.Style.TextType.Heading
    text: root.text
    color: Qaterial.Style.textColorDark
  }
}
