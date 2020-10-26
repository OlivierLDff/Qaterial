import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.SquacleButton
{
  id: control

  padding: 8

  contentItem: Item
  {
    id: _imageClipper

    property real radius: control.squared ? 16 : width / 2
    Behavior on radius { NumberAnimation { duration: 150;easing.type: Easing.InOutQuad } }

    layer.enabled: true
    layer.effect: OpacityMask
    {
      maskSource: Rectangle
      {
        width: _imageClipper.width
        height: _imageClipper.height
        radius: _imageClipper.radius
      } // Rectangle
    }

    Image
    {
      source: control.icon.source
      fillMode: Image.PreserveAspectFit
      anchors.centerIn: parent

      width: control.icon.width
      height: control.icon.height
    }
  }
}
