/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQml.Models 2.12
import QtQuick 2.0

// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: root
  width: 500
  height: 100

  readonly property int _count: model.count
  readonly property int _stepperWidth: width/_count

  // Actual Step
  property int currentIndex: 0

  //User has to update iconSize if he changed validateIcon
  property int iconSize: 32
  property int separatorPadding: 8

  // Icon displayed when the user validates a step
  property Component validateIcon: Qaterial.ColorIcon
  {
    color: "white"
    source: Qaterial.Icons.check
  } // ColorIcon

  // Icon displayed when a step has an alertMessage
  property Component alertIcon: Qaterial.ColorIcon
  {
    color: Qaterial.Style.red
    source: Qaterial.Icons.alert_outline
  } // ColorIcon

  // Icon displayed to visually separate differents steps
  property Component separator: Rectangle
  {
    color: Qaterial.Style.dividersColor()
    width: 10
    height: 3
    radius: 4
  } // ColorIcon

  // Model of the steppers
  // Qaterial owns a Qaterial.StepperModel item which is a list of Qaterial.StepperElement
  // Those elements contain text, done, optionnal, alertMessage and supportingText properties
  property QtObject model: Qaterial.StepperModel // StepperModel -> QOlm -> QAbstractListMOdel -> QtObject
  {
    Qaterial.StepperElement // StepperElement -> QtObject
    {
      text: "Point N°1"
      done: false
      optional: false
      supportingText: "This is the Point N°1's supporting text"
    }
    Qaterial.StepperElement
    {
      text: "Point N°2"
      done: true
      optional: false
      supportingText: "This is the Point N°2's supporting text"
    }
    Qaterial.StepperElement
    {
      text: "Point N°3"
      done: false
      optional: true
      supportingText: "This is the Point N°3's supporting text"
    }
    Qaterial.StepperElement
    {
      text: "Point N°4"
      done: false
      optional: false
      alertMessage: "This is an alert message"
      supportingText: "This is the Point N°4's supporting text"
    }
    Qaterial.StepperElement
    {
      text: "Point N°5"
      done: false
      optional: false
      supportingText: "This is the Point N°5's supporting text"
    }
  } // StepperModel

  // Signal emitted when every non-optionnal steps are done
  signal finished()
  // Signal emitted when the user validates the last step if an non-optionnal step isn't done
  signal missingStep(int index)

  Repeater
  {
    id: _repeater

    model: root.model

    delegate: Qaterial.RawMaterialButton
    {
      x: index * _stepperWidth
      width: _stepperWidth
      height: root.height

      backgroundColor: "transparent"

      onClicked: root.currentIndex = index

      readonly property Qaterial.StepperElement element: root.model.get(index)
      readonly property bool isAlertStep: element.alertMessage !== ""

      Rectangle
      {
        id: _iconBackground

        anchors.centerIn: parent
        width: root.iconSize
        height: width
        radius: width/2

        color:
        {
          if(root.currentIndex >= index)
          {
            if(isAlertStep)
              return element.done ? Qaterial.Style.dividersColor() : "transparent"
            return element.done ? Qaterial.Style.accentColor : Qaterial.Style.dividersColor()
          }
          return isAlertStep ? "transparent" : Qaterial.Style.dividersColor()
        }

        Qaterial.Label
        {
          anchors.centerIn: parent
          visible: isAlertStep ? false : !model.done
          text: index + 1
          textType: Qaterial.Style.TextType.Button
        }

        Loader
        {
          id: _iconLoader
          visible: isAlertStep ? true : model.done
          anchors.centerIn: parent
          sourceComponent: isAlertStep ? alertIcon : validateIcon
        } // Loader
      } // Rectangle

      Qaterial.Label
      {
        visible: isAlertStep
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height/2 - root.iconSize
        width: _stepperWidth

        text: model.text
        wrapMode: Text.Wrap
        elide: Text.ElideRight
        maximumLineCount: 1
        horizontalAlignment: Text.AlignHCenter
        font.bold: index === root.currentIndex

        color: Qaterial.Style.red
      } // Label

      Qaterial.Label
      {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height/2 + root.iconSize/2 + root.separatorPadding
        width: _stepperWidth

        text: isAlertStep ? model.alertMessage : model.text
        wrapMode: Text.Wrap
        elide: Text.ElideRight
        maximumLineCount: 3
        horizontalAlignment: Text.AlignHCenter
        font.bold: index === root.currentIndex

        color:
        {
          if(isAlertStep)
            return Qaterial.Style.red
          return (index === root.currentIndex) ? Qaterial.Style.accentColor : "white"
        }
      } // Label
    } // RawMaterialButton
  } // Repeater

  Repeater
  {
    anchors.centerIn: root

    model: root._count - 1

    delegate: Loader
    {
      id: _separatorLoader

      anchors.verticalCenter: parent.verticalCenter
      x: _stepperWidth/2 + root.iconSize/2 + index*_stepperWidth + root.separatorPadding
      width: _stepperWidth - root.iconSize - 2*root.separatorPadding

      sourceComponent: separator
    } // Loader
  } // Repeater

  Qaterial.Label
  {
    id: _supportingTextLabel
    y: root.height  + root.iconSize
    x: _backButton.leftInset
    width: root.width

    text: root.model.get(root.currentIndex).supportingText
    textType: Qaterial.Style.TextType.Caption
    wrapMode: Text.Wrap
    elide: Text.ElideRight
    maximumLineCount: 3

    color: root.model.get(root.currentIndex).alertMessage !== "" ? Qaterial.Style.red : "white"
  }

  Row
  {
    y: root.height + _supportingTextLabel.height + (root.height / 2)
    spacing: 10

    //readonly property Qaterial.StepperElement element: root.model.get(root.currentIndex)

    Qaterial.OutlineButton
    {
      id: _backButton
      text: "Back"
      onClicked: root.currentIndex >= 1 ? root.currentIndex -- : console.log(`currentIndex min`)
    } // OutlineButton

    Qaterial.RaisedButton
    {
      text: "Next"
      onClicked: root.currentIndex < root._count-1 ? root.currentIndex ++ : console.log(`currentIndex max`)
    } // RaisedButton

    Qaterial.OutlineButton
    {
      visible: root.model.get(root.currentIndex).optional
      text: "Skip"
      onClicked: root.currentIndex < root._count-1 ? root.currentIndex ++ : console.log(`currentIndex max`)
    } // OutlineButton

    Qaterial.RaisedButton
    {
      property bool done: root.model.get(root.currentIndex).done

      text:
      {
        if(root.currentIndex === root._count-1)
          return done ? "Cancel" : "Finish"
        return done ? "Cancel" : "Done"
      }

      onClicked:
      {
        root.model.get(root.currentIndex).done = !root.model.get(root.currentIndex).done

        if(root.currentIndex === root._count-1 && done)
        {
          let finished = true
          let unfinishedStep = -1
          for (let i = 0; i <= root._count-1; i++)
          {
            if(!root.model.get(i).done && !root.model.get(i).optional)
            {
              finished = false
              unfinishedStep = i + 1
            }
          }
          if(finished)
          {
            console.log(`Finish !`)
            root.finished()
          }
          else
          {
            console.log(`You haven't finished the step ${unfinishedStep}! You have to do it to finish the process`)
            root.missingStep(unfinishedStep)
          }
        }

        if(root.currentIndex < root._count-1 && done)
          root.currentIndex ++
      }
    } // RaisedButton
  } // Row
} // Item