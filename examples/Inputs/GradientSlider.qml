import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Row
{
  Qaterial.GradientSlider
  {
    color: Qaterial.Style.amber
    orientation: Qt.Vertical
    height: 350
  }
  Qaterial.GradientSlider
  {
    color: Qaterial.Style.teal
    orientation: Qt.Vertical
    width: 100
    height: 350
    handleSize: 40
    handleRadius: 4
    value: 0.5

    gradient: Gradient
    {
      GradientStop
      {
        position: 0.000
        color: Qt.rgba(1, 0, 0, 1)
      }
      GradientStop
      {
        position: 0.167
        color: Qt.rgba(1, 1, 0, 1)
      }
      GradientStop
      {
        position: 0.333
        color: Qt.rgba(0, 1, 0, 1)
      }
      GradientStop
      {
        position: 0.500
        color: Qt.rgba(0, 1, 1, 1)
      }
      GradientStop
      {
        position: 0.667
        color: Qt.rgba(0, 0, 1, 1)
      }
      GradientStop
      {
        position: 0.833
        color: Qt.rgba(1, 0, 1, 1)
      }
      GradientStop
      {
        position: 1.000
        color: Qt.rgba(1, 0, 0, 1)
      }
    }
  }
  Column
  {
    Row
    {
      Qaterial.GradientSlider
      {
        color: Qaterial.Style.red
        orientation: Qt.Vertical
        backgroundColor: "transparent"
      }
      Qaterial.GradientSlider
      {
        color: Qaterial.Style.green
        orientation: Qt.Vertical
        width: 100
        value: 0.2
        backgroundColor: "transparent"

        gradient: Gradient
        {
          GradientStop
          {
            position: 0.0
            color: "#00000000"
          }
          GradientStop
          {
            position: 1.0
            color: "#FFFFFFFF"
          }
        }
      }
      Qaterial.GradientSlider
      {
        color: Qaterial.Style.blue
        orientation: Qt.Vertical
        width: 200
        value: 1
        backgroundColor: "transparent"
        gradient: Gradient
        {
          GradientStop
          {
            position: 0.0
            color: "#F0F0F0"
          }
          GradientStop
          {
            position: 0.5
            color: "#000000"
          }
          GradientStop
          {
            position: 1.0
            color: "#F0F0F0"
          }
        }
      }
      Qaterial.GradientSlider
      {
        color: Qaterial.Style.amber
        orientation: Qt.Vertical
        handleSize: 32
        handleRadius: 4
        value: 0.6

        gradient: Gradient
        {
          GradientStop
          {
            position: 0.0
            color: "#00000000"
          }
          GradientStop
          {
            position: 1.0
            color: "#FF000000"
          }
        }
      }
      Qaterial.GradientSlider
      {
        color: Qaterial.Style.pink
        orientation: Qt.Vertical
        width: 100
        handleSize: 32
        handleRadius: 4
        value: 0.8
        inlineBorderWidth: 0
      }
      Qaterial.GradientSlider
      {
        color: Qaterial.Style.purple
        orientation: Qt.Vertical
        width: 200
        handleSize: 32
        handleRadius: 4
        value: 1
        inlineBorderWidth: 0

        gradient: Gradient
        {
          GradientStop
          {
            position: 0.0
            color: "#00000000"
          }
          GradientStop
          {
            position: 1.0
            color: "#FF000000"
          }
        }
      }
      Qaterial.GradientSlider
      {
        color: Qaterial.Style.cyan
        orientation: Qt.Vertical
        width: 100
        handleSize: 32
        handleRadius: 4
        value: 0.5
        inlineBorderWidth: 8
      }
    }

    Row
    {
      Column
      {
        Qaterial.GradientSlider
        {
          color: Qaterial.Style.teal
          orientation: Qt.Horizontal
        }
        Qaterial.GradientSlider
        {
          color: Qaterial.Style.indigo
          orientation: Qt.Horizontal
          height: 100
          value: 1

          gradient: Gradient
          {
            GradientStop
            {
              position: 0.0
              color: "#00000000"
            }
            GradientStop
            {
              position: 1.0
              color: "#FF000000"
            }
          }
        }
      }
      Qaterial.GradientSlider
      {
        color: Qaterial.Style.yellow
        orientation: Qt.Horizontal
        height: 150
        value: 0.5

        gradient: Gradient
        {
          GradientStop
          {
            position: 0.000
            color: Qt.rgba(1, 0, 0, 1)
          }
          GradientStop
          {
            position: 0.167
            color: Qt.rgba(1, 1, 0, 1)
          }
          GradientStop
          {
            position: 0.333
            color: Qt.rgba(0, 1, 0, 1)
          }
          GradientStop
          {
            position: 0.500
            color: Qt.rgba(0, 1, 1, 1)
          }
          GradientStop
          {
            position: 0.667
            color: Qt.rgba(0, 0, 1, 1)
          }
          GradientStop
          {
            position: 0.833
            color: Qt.rgba(1, 0, 1, 1)
          }
          GradientStop
          {
            position: 1.000
            color: Qt.rgba(1, 0, 0, 1)
          }
        }
      }
      Column
      {
        Qaterial.GradientSlider
        {
          color: Qaterial.Style.red
          orientation: Qt.Horizontal
          handleSize: 32
          handleRadius: 4
          handleBorderColor: Qaterial.Style.amber
          inlineBorderWidth: 0
          foregroundColor: Qaterial.Style.amber
        }
        Qaterial.GradientSlider
        {
          color: Qaterial.Style.green
          orientation: Qt.Horizontal
          height: 100
          handleSize: 32
          handleRadius: 4
          value: 1
          handleBorderColor: Qaterial.Style.amber
          inlineBorderWidth: 0
          foregroundColor: Qaterial.Style.amber
        }
      }
      Qaterial.GradientSlider
      {
        color: Qaterial.Style.blueGrey
        orientation: Qt.Horizontal
        height: 150
        handleSize: 32
        handleRadius: 4
        value: 0.5
        handleBorderColor: Qaterial.Style.amber
        inlineBorderWidth: 0
        foregroundColor: Qaterial.Style.amber

        gradient: Gradient
        {
          GradientStop { position: 0.0;color: "red" }
          GradientStop { position: 0.33;color: "yellow" }
          GradientStop { position: 1.0;color: "green" }
        }
      }
    } // Row
  } // Column
} // Row
