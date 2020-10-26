import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Item
{
  width: stepper.vertical ? stepper.width + 10 + _row.width : stepper.width
  height: stepper.vertical ? stepper.height : stepper.height + _row.height + 10

  Qaterial.Stepper
  {
    id: stepper
    width: 600
    //height: 400 //(for vertical: true)

    // Dimension properties
    indicatorWidth: 40
    indicatorHeight: indicatorWidth

    contentItemWidth: 100
    contentItemHeight: 20

    // Clickable property which allow the user to click on the step to display it
    clickable: true
    // Vertical property which display vertically the stepper instead of horizontally
    vertical: false

    model: Qaterial.StepperModel
    {
      Qaterial.StepperElement { text: "Point N°1" }
      Qaterial.StepperElement { text: "Point N°2";alertMessage: "I'm an alertMessage" }
      Qaterial.StepperElement { text: "Point N°3";alertMessage: "Me too" }
      Qaterial.StepperElement { text: "Point N°4" }
    } // StepperModel

    // separator : default
    indicator: Rectangle
    {
      id: indicatorCircle

      // Properties injected by the HorizontalStepper when detected allowing to acces to data as
      // element: the element displayed
      // index: the index of the element displayed
      // done: the "done" property of the model
      // alertMessage: the "alertMessage" property of the model
      property Qaterial.StepperElement element
      property int index
      property bool done: element ? element.done : false
      property string alertMessage: element ? element.alertMessage : ""

      readonly property bool isCurrent: index === stepper.currentIndex
      readonly property bool isAlertStep: alertMessage !== ""

      width: 40
      height: 40
      radius: width / 2
      color:
      {
        if(stepper.currentIndex >= index)
          return done ? Qaterial.Style.accentColor : Qaterial.Style.dividersColor()
        return Qaterial.Style.dividersColor()
      }

      Component
      {
        id: doneIcon
        Qaterial.ColorIcon
        {
          anchors.centerIn: parent
          color: Qaterial.Style.primaryTextColor()
          source: Qaterial.Icons.check
        } // ColorIcon
      } // Component
      Component
      {
        id: stepNumber
        Qaterial.Label
        {
          anchors.centerIn: parent
          text: indicatorCircle.index + 1
          textType: Qaterial.Style.TextType.Button
        } // Label
      } // Component
      Component
      {
        id: alertIcon
        Qaterial.ColorIcon
        {
          color: Qaterial.Style.red
          source: Qaterial.Icons.alertOutline
        } // ColorIcon
      }

      Loader
      {
        anchors.centerIn: parent
        sourceComponent:
        {
          if(indicatorCircle.isAlertStep)
            return indicatorCircle.done ? doneIcon : alertIcon
          return indicatorCircle.done ? doneIcon : stepNumber
        }
      } // Loader
    } // indicator: Rectangle

    contentItem: Qaterial.Label
    {
      width: 100
      height: 20

      property Qaterial.StepperElement element
      property int index
      property bool done: element ? element.done : false
      property string alertMessage: element ? element.alertMessage : ""

      readonly property bool isCurrent: index === stepper.currentIndex
      readonly property bool isAlertStep: alertMessage !== ""

      text:
      {
        if(isAlertStep)
          return done ? element.text : alertMessage
        return element.text
      }
      horizontalAlignment: stepper.vertical ? Text.AlignLeft : Text.AlignHCenter
      font.bold: isCurrent
      color:
      {
        if(isAlertStep)
          return Qaterial.Style.red
        return isCurrent ? Qaterial.Style.accentColor : Qaterial.Style.primaryTextColor()
      }
    } // Label
  } // HorizontalStepper

  // Buttons allowing to switch and validate steps
  Row
  {
    id: _row

    x: stepper.vertical ? (stepper.width + 10) : (stepper.width / 2 - width / 2)
    y: stepper.vertical ? (stepper.height / 2 - height / 2) : (stepper.height + 10)
    spacing: 10

    Qaterial.OutlineButton
    {
      id: _backButton
      text: "Back"
      onClicked: stepper.currentIndex >= 1 ? stepper.currentIndex-- : console.log(`currentIndex min`)
    } // OutlineButton
    Qaterial.RaisedButton
    {
      text: "Next"
      onClicked: stepper.currentIndex < stepper.count - 1 ? stepper.currentIndex++ : console.log(`currentIndex max`)
    } // RaisedButton

    Qaterial.RaisedButton
    {
      property bool done: stepper.currentElement.done

      text:
      {
        if(stepper.currentIndex === stepper.count - 1)
          return done ? "Cancel" : "Finish"
        return done ? "Cancel" : "Done"
      }
      onClicked:
      {
        stepper.currentElement.done = !stepper.currentElement.done

        // If this is the last Steps you want to know it
        if(stepper.currentIndex === stepper.count - 1 && done)
        {
          let finished = true
          let unfinishedStep = -1

          // Check if every steps are done
          for(let i = 0; i <= stepper.count - 1; i++)
          {
            if(!stepper.model.get(i)
              .done)
            {
              finished = false;
              unfinishedStep = i + 1
            }
          }
          if(finished)
            console.log(`Finish !`)
          else
          {
            console.log(`You haven't finished the step ${unfinishedStep}! You have to do it to finish the process`)
            stepper.currentElement.done = !stepper.currentElement.done
          }
        }

        // When Done is clicked, go to next step
        if(stepper.currentIndex < stepper.count - 1 && done)
          stepper.currentIndex++
      }
    } // RaisedButton
  } // Row
} // Item
