import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Item
{
  width: stepper.width
  height: stepper.height

  Qaterial.Stepper
  {
    id: stepper

    // Stepper has implicitWidth / Height

    // Dimension properties
    indicatorWidth: 64
    indicatorHeight: indicatorWidth

    contentItemWidth: 150
    contentItemHeight: 32

    separatorHeight: 10
    separatorWidth: 10

    // Clickable property which allow the user to click on the step to display it
    clickable: false
    // Vertical property which display vertically the stepper instead of horizontally
    vertical: false

    // HorizontalStepper model is a StepperModel Item which is a list of StepperElement
    // Those StepperElement can have properties like text, done, alertMessage, etc ...
    model: Qaterial.StepperModel
    {
      Qaterial.StepperElement {}
      Qaterial.StepperElement {}
      Qaterial.StepperElement {}
    } // StepperModel

    // Separator, Indicator and ContentItem are 3 customizable Components
    separator: Rectangle
    {
      color: Qaterial.Style.accentColor
      height: 10
      width: 10
    }
    indicator: Rectangle
    {
      color: "pink"
      width: 64
      height: 64
    }
    contentItem: Rectangle
    {
      color: Qaterial.Style.blue
      width: 150
      height: 32
    }
  } // HorizontalStepper
} // Item
