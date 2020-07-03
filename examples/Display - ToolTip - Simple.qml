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
      visible: button1.hovered
    } // ToolTip
  } // FlatButton
  Qaterial.FlatButton
  {
    id: button3
    text: "Delayed"
    highlighted: false

    Qaterial.ToolTip
    {
      text: "ToolTip Delayed"
      delay: 300
      visible: button3.hovered
    } // ToolTip
  } // FlatButton
  Qaterial.FlatButton
  {
    id: button4
    text: "Timeout"
    highlighted: false

    Qaterial.ToolTip
    {
      text: "ToolTip Timeout"
      visible: button4.hovered
      timeout: 800
    } // ToolTip
  } // FlatButton
} // Row