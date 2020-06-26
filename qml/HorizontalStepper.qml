/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.14
import QtQml 2.14

// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  implicitWidth: 500
  implicitHeight: indicatorTopPadding + indicatorHeight + indicatorBottomPadding + contentItemHeight + 2*contentItemVerticalPadding

  // ──── General ──── //
  property bool clickable: true
  readonly property int count: model.count

  // Actual Step
  property int currentIndex: 0
  // Actual Element
  readonly property Qaterial.StepperElement currentElement: model.get(currentIndex)

  // ──── Dimensions NEEDED to display elements ──── //

  // Indicator Dimensions
  property int indicatorWidth: 32
  property int indicatorHeight: 32
  property int indicatorHorizontalPadding: 8
  property int indicatorVerticalPadding: 8
  property int indicatorTopPadding: indicatorVerticalPadding
  property int indicatorBottomPadding: indicatorVerticalPadding

  // ContentItem Dimensions
  property int contentItemHeight: 32
  property int contentItemVerticalPadding: 8

  // ──── Model of the Stepper ──── //
  // Qaterial owns a Qaterial.StepperModel item which is a list of Qaterial.StepperElement
  // Those elements contain text, done, optionnal, alertMessage and supportingText properties
  property Qaterial.StepperModel model

  // ──── Component resuming the step ──── //
  property Component indicator: Rectangle
  {
    width: indicatorWidth
    height: indicatorHeight
    radius: width/2
    color:
    {
      if(currentIndex >= index)
        return done ? Qaterial.Style.accentColor : Qaterial.Style.dividersColor()
      return Qaterial.Style.dividersColor()
    }

    property Qaterial.StepperElement element
    property int index
    property bool done: element && element.done

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
        text: index + 1
        textType: Qaterial.Style.TextType.Button
      } // Label
    } // Component
    Loader
    {
      anchors.centerIn: parent
      sourceComponent: done ? doneIcon : stepNumber
    } // Loader
  } // indicator: Rectangle

  // ──── Component representing the step displayed below the indicator ──── //
  property Component contentItem: Qaterial.Label
  {
    property Qaterial.StepperElement element
    property int index
    readonly property bool isCurrent: index === currentIndex

    text: element.text
    horizontalAlignment: Text.AlignHCenter
    font.bold: isCurrent
    color: isCurrent ? Qaterial.Style.accentColor : "white"
  } // Label

  // ──── Component displayed between indicators to separate different steps ──── //
  property Component separator: Rectangle
  {
    color: Qaterial.Style.dividersColor()
    height: 8
    radius: 4
  }

  // If user wants to change name property to access model element
  property string elementRole: "element"
  property string previousRole: "previous"
  property string nextRole: "next"

  // ──── Private properties ──── //
  readonly property int _stepperWidth: width/count
  readonly property int _indicatorYPosition: indicatorTopPadding + indicatorHeight/2

  Repeater
  {
    id: _repeater

    model: root.model

    delegate: Item
    {
      id: _step
      x: model.index * _stepperWidth
      height: root.height
      width: _stepperWidth

      readonly property Qaterial.StepperElement element: model.qtObject // QOlm functionality

      Loader
      {
        id: _indicatorLoader
        y: root.indicatorTopPadding
        anchors.horizontalCenter: parent.horizontalCenter

        sourceComponent: root.indicator

        Binding
        {
          target: _indicatorLoader.item
          when: _indicatorLoader.item && _indicatorLoader.item.hasOwnProperty(root.elementRole)
          property: root.elementRole
          value: _step.element
          restoreMode: Binding.RestoreNone
        } // Binding for element

        Binding
        {
          target: _indicatorLoader.item
          when: _indicatorLoader.item && _indicatorLoader.item.hasOwnProperty("index")
          property: "index"
          value: model.index
          restoreMode: Binding.RestoreNone
        } // Binding for index

        // done, optional and alertMessage are accessible with element.done / .optional / .alertMessage

      } // Loader

      Loader
      {
        id: _contentItemLoader

        anchors.horizontalCenter: parent.horizontalCenter
        y: _indicatorYPosition + root.indicatorHeight/2
           + root.indicatorBottomPadding + root.contentItemVerticalPadding

        sourceComponent: root.contentItem

        Binding
        {
          target: _contentItemLoader.item
          when: _contentItemLoader.item && _contentItemLoader.item.hasOwnProperty(root.elementRole)
          property: root.elementRole
          value: _step.element
          restoreMode: Binding.RestoreNone
        } // Binding for element

        Binding
        {
          target: _contentItemLoader.item
          when: _contentItemLoader.item && _contentItemLoader.item.hasOwnProperty("index")
          property: "index"
          value: model.index
          restoreMode: Binding.RestoreNone
        } // Binding for index

        // done, optional and alertMessage are accessible with element.done / .optional / .alertMessage

      } // Loader

      MouseArea
      {
        anchors.fill: parent
        enabled: root.clickable
        onClicked: () => root.currentIndex = model.index
      } // MouseArea
    } // Item
  } // Repeater

  Repeater
  {
    model: root.count - 1

    delegate: Loader
    {
      id: _separatorLoader

      x: _stepperWidth/2 + root.indicatorWidth/2 + index*_stepperWidth + root.indicatorHorizontalPadding
      y: _indicatorYPosition - item.height/2
      width: _stepperWidth - root.indicatorWidth - 2*root.indicatorHorizontalPadding

      sourceComponent: root.separator

      Binding
      {
        target: _separatorLoader.item
        when: _separatorLoader.item && _separatorLoader.item.hasOwnProperty(root.previousRole)
        property: root.previousRole
        value: root.model.get(index)
        restoreMode: Binding.RestoreNone
      } // Binding for previous

      Binding
      {
        target: _separatorLoader.item
        when: _separatorLoader.item && _separatorLoader.item.hasOwnProperty(root.nextRole)
        property: root.nextRole
        value: root.model.get(index+1)
        restoreMode: Binding.RestoreNone
      } // Binding for next

      Binding
      {
        target: _separatorLoader.item
        when: _separatorLoader.item && _separatorLoader.item.hasOwnProperty("index")
        property: "index"
        value: model.index
        restoreMode: Binding.RestoreNone
      } // Binding for index
    } // Loader
  } // Repeater
} // Item