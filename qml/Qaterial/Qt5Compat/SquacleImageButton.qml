import QtQuick
import QtQuick.Controls
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects

// Qaterial
import Qaterial as Qaterial
import Qaterial.Qt5Compat as Qaterial

Qaterial.SquacleButton
{
  id: control

  padding: 8

  contentItem: Qaterial.ClipRRect
  {
    id: clipper

    radius: control.squared ? 16 : width / 2

    Behavior on radius { NumberAnimation { duration: 150;easing.type: Easing.InOutQuad } }

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
