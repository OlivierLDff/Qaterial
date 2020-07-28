import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Row
{
  spacing: 20
  Qaterial.CircleSlice
  {
      id: _circleOne
      size: 100

      arcBegin: 240
      arcEnd: 50

      lineWidth: 10
  }

  Qaterial.CircleSlice
  {
    id: _circleTwo

    // Size of the circle
    size: 80

    //Color of the circle
    colorCircle: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
    colorBackground: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)

    // True for display the background
    showBackground: true

    arcBegin: 90
    arcEnd: 150

    // Displays a filled circle
    isPie: true
  }

  Qaterial.CircleSlice
  {
    id: _circleThree
    size: 150

    Qaterial.Label
    {
      text: `Validity`
      anchors.centerIn: parent
    }

    arcBegin: 90
    arcEnd: 260

    colorCircle: "purple"

    lineWidth: 30
  }
}
