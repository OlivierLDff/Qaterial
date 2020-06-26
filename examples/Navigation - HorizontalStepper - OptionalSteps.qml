import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Item
{
  Qaterial.HorizontalStepper
  {
    id: stepper
    width: 600

    // Dimension properties
    indicatorWidth: 40
    indicatorHeight: 40
    contentItemHeight: 20
    indicatorBottomPadding: 0

    // Clickable property which allow the user to click on the step to display it
    clickable: true

    model: Qaterial.StepperModel
    {
      Qaterial.StepperElement { text: "Point N°1" }
      Qaterial.StepperElement { text: "Point N°2, Optional"; optional: true }
      Qaterial.StepperElement { text: "Point N°3, Optional"; done: true; optional: true }
      Qaterial.StepperElement { text: "Point N°4" }
    } // StepperModel

    // separator: default
    // indicator: default
    // contentItem: default

  } // HorizontalStepper

  // Buttons allowing to switch and validate steps
  Row
  {
    x: stepper.width/2 - width/2
    y: stepper.height + 10
    spacing: 10

    Qaterial.OutlineButton
    {
      id: _backButton
      text: "Back"
      onClicked: stepper.currentIndex >= 1 ? stepper.currentIndex -- : console.log(`currentIndex min`)
    } // OutlineButton
    Qaterial.RaisedButton
    {
      text: "Next"
      onClicked: stepper.currentIndex < stepper.count-1 ? stepper.currentIndex ++ : console.log(`currentIndex max`)
    } // RaisedButton
    Qaterial.OutlineButton
    {
      visible: stepper.currentElement.optional
      text: "Skip"
      onClicked: stepper.currentIndex < stepper.count-1 ? stepper.currentIndex ++ : console.log(`currentIndex max`)
    } // OutlineButton

    Qaterial.RaisedButton
    {
      property bool done: stepper.currentElement.done

      text:
      {
        if(stepper.currentIndex === stepper.count-1)
          return done ? "Cancel" : "Finish"
        return done ? "Cancel" : "Done"
      }
      onClicked:
      {
        stepper.currentElement.done = !stepper.currentElement.done

        // If this is the last Steps you want to know it
        if(stepper.currentIndex === stepper.count-1 && done)
        {
          let finished = true
          let unfinishedStep = -1

          // Check if every steps are done if they aren't optional
          for (let i = 0; i <= stepper.count-1; i++)
          {
            if(!stepper.model.get(i).done && !stepper.model.get(i).optional)
            {
              finished = false; unfinishedStep = i+1
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
        if(stepper.currentIndex < stepper.count-1 && done)
          stepper.currentIndex ++
      }
    } // RaisedButton
  } // Row
} // Item