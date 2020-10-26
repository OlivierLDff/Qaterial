import QtQuick 2.12
import QtQuick.Controls 2.12
import Qaterial 1.0 as Qaterial

Column
{
  id: root
  property color color: Qaterial.Style.red

  spacing: 8

  Row
  {
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 16

    Qaterial.ColorButton
    {
      color: root.color
      onClicked: function()
      {
        const textToCopy = `${root.color.toString().toUpperCase()}`
        Qaterial.Clipboard.text = textToCopy
        Qaterial.SnackbarManager.show(`Color Copied! \n'${textToCopy}'`)
      }

      ToolTip.text: "Click to copy"
      ToolTip.visible: hovered || pressed
    }

    Qaterial.Label
    {
      anchors.verticalCenter: parent.verticalCenter
      width: 200
      textType: Qaterial.Style.TextType.Heading
      text: `Color: ${root.color.toString().toUpperCase()}`
    }
  }

  Qaterial.ToolSeparator
  {
    width: parent.width
    orientation: Qt.Horizontal
  }

  Row
  {
    spacing: 16
    Column
    {
      Qaterial.Label
      {
        textType: Qaterial.Style.TextType.Overline
        text: `Red: ${redSlider.value.toFixed(2)}`
      }

      Qaterial.ColorRedSlider
      {
        id: redSlider
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.color

        onMoved: () => root.color = getNewColor()
      }

      Qaterial.Label
      {
        textType: Qaterial.Style.TextType.Overline
        text: `Green: ${greenSlider.value.toFixed(2)}`
      }

      Qaterial.ColorGreenSlider
      {
        id: greenSlider
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.color

        onMoved: () => root.color = getNewColor()
      }

      Qaterial.Label
      {
        textType: Qaterial.Style.TextType.Overline
        text: `Blue: ${blueSlider.value.toFixed(2)}`
      }

      Qaterial.ColorBlueSlider
      {
        id: blueSlider
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.color

        onMoved: () => root.color = getNewColor()
      }
    } // Column

    Qaterial.ToolSeparator
    {
      height: parent.height
      orientation: Qt.Vertical
    }

    Column
    {
      Qaterial.Label
      {
        textType: Qaterial.Style.TextType.Overline
        text: `Hue: ${hueSlider.value.toFixed(2)}`
      }

      Qaterial.HsvColorHueSlider
      {
        id: hueSlider
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.color

        onMoved: () => root.color = getNewColor()
      }

      Qaterial.Label
      {
        textType: Qaterial.Style.TextType.Overline
        text: `Saturation: ${saturationSlider.value.toFixed(2)}`
      }

      Qaterial.HsvColorSaturationSlider
      {
        id: saturationSlider
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.color

        onMoved: () => root.color = getNewColor()
      }

      Qaterial.Label
      {
        textType: Qaterial.Style.TextType.Overline
        text: `Value: ${valueSlider.value.toFixed(2)}`
      }

      Qaterial.HsvColorValueSlider
      {
        id: valueSlider
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.color

        onMoved: () => root.color = getNewColor()
      }
    } // Column

    Qaterial.ToolSeparator
    {
      height: parent.height
      orientation: Qt.Vertical
    }

    Column
    {
      Qaterial.Label
      {
        textType: Qaterial.Style.TextType.Overline
        text: `Hue: ${hueSliderHsl.value.toFixed(2)}`
      }

      Qaterial.HslColorHueSlider
      {
        id: hueSliderHsl
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.color

        onMoved: () => root.color = getNewColor()
      }

      Qaterial.Label
      {
        textType: Qaterial.Style.TextType.Overline
        text: `Saturation: ${saturationSliderHsl.value.toFixed(2)}`
      }

      Qaterial.HslColorSaturationSlider
      {
        id: saturationSliderHsl
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.color

        onMoved: () => root.color = getNewColor()
      }

      Qaterial.Label
      {
        textType: Qaterial.Style.TextType.Overline
        text: `Lightness: ${valueSliderHsl.value.toFixed(2)}`
      }

      Qaterial.HslColorLightnessSlider
      {
        id: valueSliderHsl
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.color

        onMoved: () => root.color = getNewColor()
      }
    } // Column

    Qaterial.ToolSeparator
    {
      height: parent.height
      orientation: Qt.Vertical
    }

    Qaterial.ColorAlphaSlider
    {
      id: alphaSlider
      orientation: Qt.Vertical
      //anchors.horizontalCenter: parent.horizontalCenter
      color: root.color

      onMoved: () => root.color = getNewColor()
    }
  } // Row

  Flow
  {
    width: parent.width
    Repeater
    {
      model: ['#f44336', '#E91E63', '#9C27B0', '#673AB7', '#3F51B5', '#2196F3', '#03A9F4', '#00BCD4', '#009688',
        '#4CAF50', '#8BC34A', '#CDDC39', '#FFEB3B', '#FFC107', '#FF9800', '#FF5722', '#9E9E9E', '#607D8B', '#263238',
        '#212121', '#3E2723', '#000000', '#FFFFFF'
      ]
      delegate: Qaterial.ColorMiniButton
      {
        color: modelData
        onClicked: function()
        {
          root.color = modelData
        }

        ToolTip.text: modelData
        ToolTip.visible: hovered || pressed
      }
    }
  }
} // Row
