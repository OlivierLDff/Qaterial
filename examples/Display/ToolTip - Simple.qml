import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Row
{
  spacing: 50
  Qaterial.FlatButton
  {
    id: button1
    text: "Simple"
    highlighted: false

    Qaterial.ToolTip
    {
      text: "Simple ToolTip"
      visible: button1.hovered || button1.pressed
    } // ToolTip
  } // FlatButton
  Qaterial.FlatButton
  {
    id: button2
    text: "Delayed"
    highlighted: false

    Qaterial.ToolTip
    {
      text: "ToolTip Delayed"
      delay: 300
      visible: button2.hovered || button2.pressed
    } // ToolTip
  } // FlatButton
  Qaterial.FlatButton
  {
    id: button3
    text: "Timeout"
    highlighted: false

    Qaterial.ToolTip
    {
      text: "ToolTip Timeout"
      visible: button3.hovered || button3.pressed
      timeout: 800
    } // ToolTip
  } // FlatButton
  Qaterial.FlatButton
  {
    id: button4
    text: "Customized"
    highlighted: false

    Qaterial.ToolTip
    {
      id: customizedTooltip
      text: "Customized ToolTip"
      visible: button4.hovered || button4.pressed
      font: Qaterial.Style.textTheme.hint2

      leftPadding: 4
      rightPadding: 6

      contentItem: Qaterial.IconLabel
      {
        text: customizedTooltip.text
        font: customizedTooltip.font
        icon.source: Qaterial.Icons.accountCircle
        color: Qaterial.Style.snackbarTextColor()
      }

      background: Rectangle
      {
        implicitHeight: 24
        color: Qaterial.Style.snackbarColor()
        opacity: Qaterial.Style.toolTip.opacity
        radius: height / 2
      } // Rectangle
    } // ToolTip
  } // FlatButton
} // Row
