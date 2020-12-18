import QtQuick 2.12
import QtQml 2.14
import Qaterial 1.0 as Qaterial

Column
{
  Qaterial.LabelHeadline6
  {
    text: "Volume"
  }
  Row
  {
    id: root
    spacing: 8
    Qaterial.ColorIcon
    {
      anchors.verticalCenter: parent.verticalCenter
      source: slider.value ? Qaterial.Icons.volumeMedium : Qaterial.Icons.volumeOff
    }
    Qaterial.Slider
    {
      id: slider
      width: 100
      value: 0.3
    }
    Qaterial.ColorIcon
    {
      anchors.verticalCenter: parent.verticalCenter
      source: Qaterial.Icons.volumeSource
    }
  }

  Qaterial.LabelHeadline6
  {
    text: "Disabled Slider"
  }

  Qaterial.Slider
  {
    x: -16
    value: slider.value
    enabled: false
  }
}
