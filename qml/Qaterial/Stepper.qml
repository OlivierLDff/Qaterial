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

  implicitWidth: vertical ?
    (indicatorLeftPadding + indicatorWidth + indicatorRightPadding + contentItemWidth + contentItemHorizontalPadding) :
    (count * (contentItemWidth + 2 * contentItemHorizontalPadding))
  implicitHeight: vertical ?
    (count * (indicatorTopPadding + indicatorHeight + indicatorBottomPadding + separatorHeight / 2)) : (
      indicatorTopPadding + indicatorHeight + indicatorBottomPadding + contentItemHeight + 2 *
      contentItemVerticalPadding)

  // ──── General ──── //
  property bool clickable: true
  property bool vertical: false
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
  property int indicatorLeftPadding: indicatorHorizontalPadding
  property int indicatorRightPadding: indicatorHorizontalPadding

  property int indicatorVerticalPadding: 8
  property int indicatorTopPadding: indicatorVerticalPadding
  property int indicatorBottomPadding: indicatorVerticalPadding

  // ContentItem Dimensions
  property int contentItemWidth: 100
  property int contentItemHeight: 20

  property int contentItemVerticalPadding: 8
  property int contentItemHorizontalPadding: 8

  // Separator Dimensions
  property int separatorWidth: 10
  property int separatorHeight: 10

  // ──── Model of the Stepper ──── //
  // Qaterial owns a Qaterial.StepperModel item which is a list of Qaterial.StepperElement
  // Those elements contain text, done, optionnal, alertMessage and supportingText properties
  property Qaterial.StepperModel model

  // ──── Component resuming the step ──── //
  property Component indicator: Rectangle
  {
    width: indicatorWidth
    height: indicatorHeight

    property Qaterial.StepperElement element
    property int index
    readonly property bool done: element && element.done

    radius: width / 2
    color:
    {
      if(currentIndex >= index)
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
        text: index + 1
        textType: Qaterial.Style.TextType.Button
      } // Label
    } // Component
    Loader
    {
      anchors.centerIn: parent
      sourceComponent: done ? doneIcon : stepNumber
    } // Loader
  } // indicator : Rectangle

  // ──── Component representing the step displayed below the indicator ──── //
  property Component contentItem: Qaterial.Label
  {
    width: contentItemWidth
    height: contentItemHeight

    property Qaterial.StepperElement element
    property int index
    readonly property bool isCurrent: index === currentIndex

    text: element.text
    horizontalAlignment: vertical ? Text.AlignLeft : Text.AlignHCenter
    font.bold: isCurrent
    color: isCurrent ? Qaterial.Style.accentColor : Qaterial.Style.primaryTextColor()
  } // Label

  // ──── Component displayed between indicators to separate different steps ──── //
  property Component separator: Rectangle
  {
    color: Qaterial.Style.dividersColor()
    height: separatorHeight
    radius: separatorWidth
  }

  // If user wants to change name property to access model element
  property string elementRole: "element"
  property string previousRole: "previous"
  property string nextRole: "next"

  // ──── Private properties ──── //
  readonly property int _stepperWidth: width / count
  readonly property int _stepperHeight: height / count

  Repeater
  {
    id: _repeater

    model: root.model

    delegate: Item
    {
      id: _step
      x: root.vertical ? 0 : (model.index * root._stepperWidth)
      y: vertical ? (model.index * root._stepperHeight) : 0
      height: root.vertical ? _stepperHeight : root.height
      width: root.vertical ? root.width : root._stepperWidth

      readonly property Qaterial.StepperElement element: model.qtObject // QOlm functionality

      Loader
      {
        id: _indicatorLoader
        x: root.vertical ? root.indicatorLeftPadding : (root._stepperWidth / 2 - root.indicatorWidth / 2)
        y: root.vertical ? (root._stepperHeight / 2 - root.indicatorHeight / 2) : root.indicatorTopPadding

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
        x: root.vertical ?
          (root.indicatorLeftPadding + root.indicatorWidth + root.indicatorRightPadding) : (root._stepperWidth / 2 -
            root.contentItemWidth / 2)
        y: root.vertical ?
          (root._stepperHeight / 2 - root.contentItemHeight / 2) : (root.indicatorTopPadding + root.indicatorHeight +
            root.indicatorBottomPadding)

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

        //Qaterial.DebugRectangle { anchors.fill: parent }
      } // MouseArea
    } // Item
  } // Repeater

  Repeater
  {
    model: root.count - 1

    delegate: Loader
    {
      id: _separatorLoader

      x: root.vertical ?
        (root.indicatorLeftPadding + root.indicatorWidth / 2 - root.separatorWidth / 2) : (root._stepperWidth / 2 +
          root.indicatorWidth / 2 + root.indicatorLeftPadding + index * root._stepperWidth)

      y: root.vertical ?
        (root._stepperHeight / 2 + root.indicatorHeight / 2 + root.indicatorTopPadding + index * root
        ._stepperHeight) : (root.indicatorTopPadding + root.indicatorHeight / 2 - root.separatorHeight / 2)

      width: root.vertical ?
        root.separatorWidth : (root._stepperWidth - root.indicatorWidth - root.indicatorLeftPadding - root
          .indicatorRightPadding)
      height: root.vertical ?
        (root._stepperHeight - root.indicatorHeight - root.indicatorTopPadding - root.indicatorBottomPadding) : root
        .separatorHeight

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
        value: root.model.get(index + 1)
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
