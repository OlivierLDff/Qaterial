import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.HorizontalStepper
{
  // Icon displayed when the user validates a step
  // default: white checked icon
  validateIcon: Rectangle
  {
    color: Qaterial.Style.blueGrey
    width: 20
    height: width
    radius: width/2
  }
  // Icon displayed when a step has an alertMessage
  // default: red warning panel
  alertIcon: Qaterial.Label
  {
    text: "/!\\"
    font.bold: true
    color: Qaterial.Style.red
  }
  // Icon displayed to visually separate differents steps
  // default: thin gray rectangle
  separator: Rectangle
  {
    color: Qaterial.Style.blueGrey
    // width is set inside the HorizontalStepper
    height: 10
    radius: height/2
  }
}