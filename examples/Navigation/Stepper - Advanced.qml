import QtQuick 2.14
import Qaterial 1.0 as Qaterial

Item
{
  width: stepper.vertical ? stepper.width + 10 + _row.width : stepper.width
  height: stepper.vertical ? stepper.height : stepper.height + supportingTextLabel.height + _row.height + 20

  Qaterial.Stepper
  {
    id: stepper
    y: 10

    readonly property int indicatorSize: 48

    // Dimension properties
    indicatorWidth: indicatorSize
    indicatorHeight: indicatorSize

    contentItemWidth: 100
    contentItemHeight: 20

    // General properties
    clickable: true
    vertical: false

    model: Qaterial.StepperModel
    {
      Qaterial.StepperElement
      {
        text: "Point N°1";
        supportingText: "This is Point N°1's supportingText"
        property string iconName: Qaterial.Icons.apps
      }
      Qaterial.StepperElement
      {
        text: "Point N°2";
        supportingText: "Quisque enim augue, consequat et odio venenatis, dictum semper massa. Aliquam erat volutpat. Morbi ornare cursus risus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse tempus lacus ut sapien convallis, eu iaculis nulla feugiat. Fusce diam urna, cursus nec congue eget, bibendum non quam. In hac habitasse platea dictumst. Sed nec fermentum purus, id scelerisque nulla. "
        optional: true
        property string iconName: Qaterial.Icons.alien
      }
      Qaterial.StepperElement
      {
        text: "Point N°3";
        supportingText: "This is Point N°3's supportingText"
        property string iconName: Qaterial.Icons.fullscreenExit
      }
      Qaterial.StepperElement
      {
        text: "Point N°4";
        supportingText: "This is Point N°4's supportingText : ALERT STEP"
        alertMessage: "It's an alert Message !"
        property string iconName: Qaterial.Icons.alertOctagram
      }
      Qaterial.StepperElement
      {
        text: "Point N°5";
        supportingText: "This is Point N°5's supportingText"
        property string iconName: Qaterial.Icons.batteryCharging100
      }
    } // StepperModel

    nextRole: "newNextElementRole"

    separator: Rectangle
    {
      property Qaterial.StepperElement previous
      property Qaterial.StepperElement newNextElementRole
      property int index
      property bool highlighted:
      {
        // If previous null just check if next is done
        if(previous == null)
          return newNextElementRole.done
        // Idem for next
        if(newNextElementRole == null)
          return previous.done
        // If both aren't null
        return previous.done && newNextElementRole.done
      }
      color: highlighted ? Qaterial.Style.accentColor : Qaterial.Style.dividersColor()
      height: 8;
      radius: 4
    } // Rectangle

    indicator: Qaterial.ColorIcon
    {
      anchors.centerIn: parent
      iconSize: stepper.indicatorSize

      // Properties injected by the HorizontalStepper when detected allowing to acces to data as
      // element: the element displayed
      // index: the index of the element displayed
      // done: the "done" property of the model
      // alertMessage: the "alertMessage" property of the model
      property Qaterial.StepperElement element
      property bool done: element ? element.done : false
      property string alertMessage: element ? element.alertMessage : ""

      readonly property bool isAlertStep: alertMessage !== ""

      color:
      {
        if(isAlertStep)
          return Qaterial.Style.red
        return done ? Qaterial.Style.accentColor : Qaterial.Style.dividersColor()
      }
      source: element.iconName
    } // ColorIcon

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
      font.bold: isCurrent
      horizontalAlignment: stepper.vertical ? Text.AlignLeft : Text.AlignHCenter
      color:
      {
        if(isAlertStep)
          return Qaterial.Style.red
        return isCurrent ? Qaterial.Style.accentColor : Qaterial.Style.primaryTextColor()
      }
    } // Label
  } // HorizontalStepper

  // It can be interesting to display steps supportingText
  Qaterial.Label
  {
    id: supportingTextLabel

    width: stepper.vertical ? _row.width : (stepper.width - 20)
    x: stepper.vertical ? (stepper.width + 10) : (stepper.width / 2 - width / 2)
    y: stepper.vertical ? (_row.y - height) : (stepper.height + 10)

    text: stepper.currentElement.supportingText
    textType: Qaterial.Style.TextType.Body2
    horizontalAlignment: Text.AlignHCenter

    wrapMode: Text.Wrap
    elide: Text.ElideRight
    maximumLineCount: stepper.vertical ? 10 : 3
  } // Label

  // Buttons allowing to switch and validate steps
  Row
  {
    id: _row

    x: stepper.vertical ? (stepper.width + 10) : (stepper.width / 2 - width / 2)
    y: stepper.vertical ? (stepper.height / 2 - height / 2) : (stepper.height + supportingTextLabel.height + 20)
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

          /// Check if every steps are done if they aren't optional
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
