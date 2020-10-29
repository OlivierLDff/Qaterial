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
      text: "Customized ToolTip"
      visible: button4.hovered || button4.pressed
      backgroupRadius: height / 2
      textType: Qaterial.Style.TextType.Display1
    } // ToolTip
  } // FlatButton
} // Row
