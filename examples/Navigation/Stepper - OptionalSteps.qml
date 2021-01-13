import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Item
{
  width: stepper.vertical ? stepper.width + 10 + _row.width : stepper.width
  height: stepper.vertical ? stepper.height : stepper.height + _row.height + 20

  Qaterial.Stepper
  {
    id: stepper
    //width: 600 //(for vertical: false)
    height: 400

    // Dimension properties
    // No need because we use default Components

    // Clickable property which allow the user to click on the step to display it
    clickable: true
    // Vertical property which display vertically the stepper instead of horizontally
    vertical: true

    model: Qaterial.StepperModel
    {
      Qaterial.StepperElement { text: "Point N°1" }
      Qaterial.StepperElement { text: "Point N°2, Optional";optional: true }
      Qaterial.StepperElement { text: "Point N°3, Optional";done: false;optional: true }
      Qaterial.StepperElement { text: "Point N°4" }
    } // StepperModel

    // separator: default
    // indicator: default
    // contentItem: default

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
    Qaterial.OutlineButton
    {
      visible: stepper.currentElement.optional
      text: "Skip"
      onClicked: stepper.currentIndex < stepper.count - 1 ? stepper.currentIndex++ : console.log(`currentIndex max`)
    } // OutlineButton

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

          // Check if every steps are done if they aren't optional
          for(let i = 0; i <= stepper.count - 1; i++)
          {
            if(!stepper.model.get(i)
              .done && !stepper.model.get(i)
              .optional)
            {
              finished = false;
              unfinishedStep = i + 1
            }
          }
          if(finished)
          {
            console.log(`Finish !`)
            // Here you can emit a finished() signal
          }
          else
          {
            console.log(`You haven't finished the step ${unfinishedStep}! You have to do it to finish the process`)
            stepper.currentElement.done = !stepper.currentElement.done
            // Here you can emit an unfinished() signal
          }
        }

        // When Done is clicked, go to next step
        if(stepper.currentIndex < stepper.count - 1 && done)
          stepper.currentIndex++
      }
    } // RaisedButton
  } // Row
} // Item
