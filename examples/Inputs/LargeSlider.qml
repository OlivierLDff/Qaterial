import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Row
{
  Qaterial.LargeSlider
  {
    color: Qaterial.Style.amber
    orientation: Qt.Vertical
    height: 350
  }
  Qaterial.LargeSlider
  {
    color: Qaterial.Style.teal
    orientation: Qt.Vertical
    width: 100
    height: 350
    handleSize: 40
    handleRadius: 4
    value: 0.5
  }
  Column
  {
    Row
    {
      Qaterial.LargeSlider
      {
        color: Qaterial.Style.red
        orientation: Qt.Vertical
      }
      Qaterial.LargeSlider
      {
        color: Qaterial.Style.green
        orientation: Qt.Vertical
        width: 100
        value: 0.2
      }
      Qaterial.LargeSlider
      {
        color: Qaterial.Style.blue
        orientation: Qt.Vertical
        width: 200
        value: 0.4
      }
      Qaterial.LargeSlider
      {
        color: Qaterial.Style.amber
        orientation: Qt.Vertical
        handleSize: 32
        handleRadius: 4
        value: 0.6
      }
      Qaterial.LargeSlider
      {
        color: Qaterial.Style.pink
        orientation: Qt.Vertical
        width: 100
        handleSize: 32
        handleRadius: 4
        value: 0.8
        inlineBorderWidth: 0
      }
      Qaterial.LargeSlider
      {
        color: Qaterial.Style.purple
        orientation: Qt.Vertical
        width: 200
        handleSize: 32
        handleRadius: 4
        value: 1
        inlineBorderWidth: 0
      }
      Qaterial.LargeSlider
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
        Qaterial.LargeSlider
        {
          color: Qaterial.Style.teal
          orientation: Qt.Horizontal
        }
        Qaterial.LargeSlider
        {
          color: Qaterial.Style.indigo
          orientation: Qt.Horizontal
          height: 100
          value: 1
        }
      }
      Qaterial.LargeSlider
      {
        color: Qaterial.Style.yellow
        orientation: Qt.Horizontal
        height: 150
        value: 0.5
      }
      Column
      {
        Qaterial.LargeSlider
        {
          color: Qaterial.Style.red
          orientation: Qt.Horizontal
          handleSize: 32
          handleRadius: 4
          handleBorderColor: Qaterial.Style.amber
          inlineBorderWidth: 0
          foregroundColor: Qaterial.Style.amber
        }
        Qaterial.LargeSlider
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
      Qaterial.LargeSlider
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
      }
    } // Row
  } // Column
} // Row
