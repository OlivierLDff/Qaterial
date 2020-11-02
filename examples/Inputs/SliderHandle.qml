import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Row
{
  id: root

  property bool pressed

  spacing: 40

  Timer
  {
    interval: 1000;running: true;repeat: true
    onTriggered: () => root.pressed = !root.pressed
  }

  Column
  {
    spacing: 60

    Row
    {
      spacing: 20

      Qaterial.SliderHandle {}

      Qaterial.SliderHandle
      {
        // focus and hovered are render the same
        hasFocus: true
        hovered: true
        pressed: root.pressed
      }

      Qaterial.SliderHandle
      {
        enabled: true
      }

      Qaterial.SliderHandle
      {
        enabled: true
        hasFocus: true
        hovered: true
        pressed: root.pressed
      }
    } // Row

    Row
    {
      spacing: 20

      Qaterial.SliderHandle
      {
        borderWidth: 2
      }

      Qaterial.SliderHandle
      {
        borderWidth: 2
        // focus and hovered are render the same
        hasFocus: true
        hovered: true
        pressed: root.pressed
      }

      Qaterial.SliderHandle
      {
        borderWidth: 2
        enabled: true
      }

      Qaterial.SliderHandle
      {
        borderWidth: 2
        enabled: true
        hasFocus: true
        hovered: true
        pressed: root.pressed
      }
    } // Row

    Row
    {
      spacing: 20

      Qaterial.SliderHandle
      {
        size: 20
      }

      Qaterial.SliderHandle
      {
        size: 20
        // focus and hovered are render the same
        hasFocus: true
        hovered: true
        pressed: root.pressed
      }

      Qaterial.SliderHandle
      {
        size: 20
        enabled: true
      }

      Qaterial.SliderHandle
      {
        size: 20
        enabled: true
        hasFocus: true
        hovered: true
        pressed: root.pressed
      }
    } // Row
  } // Column

  Column
  {
    spacing: 30
    Row
    {
      spacing: 40

      Qaterial.SliderHandle
      {
        width: 50
        enabled: true
      }

      Qaterial.SliderHandle
      {
        width: 50
        clipRipple: true
        enabled: true
        hasFocus: true
        hovered: true
        pressed: root.pressed
      }
    } // Row

    Row
    {
      spacing: 40

      Qaterial.SliderHandle
      {
        width: 50
        height: 50
        radius: 4
        enabled: true
        color: Qaterial.Style.blue
      }

      Qaterial.SliderHandle
      {
        width: 50
        height: 50
        radius: 4
        clipRipple: true
        enabled: true
        hasFocus: true
        hovered: true
        pressed: root.pressed
      }
    } // Row

    Row
    {
      spacing: 20

      Qaterial.SliderHandle
      {
        color: Qaterial.Style.red
        width: 20
        height: 50
        radius: 4
        borderWidth: 2
      }

      Qaterial.SliderHandle
      {
        color: Qaterial.Style.red
        width: 20
        height: 50
        radius: 4
        enabled: true
        borderWidth: 2
      }

      Qaterial.SliderHandle
      {
        borderColor: Qaterial.Style.red
        width: 20
        height: 50
        clipRipple: true
        enabled: true
        hasFocus: true
        hovered: true
        pressed: root.pressed
        borderWidth: 2
      }

      Qaterial.SliderHandle
      {
        color: Qaterial.Style.green
        width: 30
        height: 50
        clipRipple: true
        enabled: true
        hasFocus: true
        hovered: true
        pressed: root.pressed
        radius: 2
        borderWidth: 1
      }
    } // Row
  } // Column
} // Row
