/**
 * Copyright (C) Paul Cales 2020
 * Contact: cales.paul@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Control
{
  id: _control
  implicitWidth: Qaterial.Style.delegate.implicitWidth
  implicitHeight: contentItem.implicitHeight + _rangeSlider.implicitHeight

  property string text
  property string secondaryText

  signal firstMoved()
  signal secondMoved()

  function firstDecrease() { _rangeSlider.first.decrease() }

  function secondDecrease() { _rangeSlider.second.decrease() }

  function firstIncrease() { _rangeSlider.first.increase() }

  function secondIncrease() { _rangeSlider.second.increase() }

  function firstValueAt(position) { return _rangeSlider.valueAt(firstPosition) }

  function secondValueAt(position) { return _rangeSlider.valueAt(secondPosition) }

  property alias first: _rangeSlider.first
  property alias second: _rangeSlider.second
  property alias from: _rangeSlider.from
  property alias to: _rangeSlider.to
  property alias snapMode: _rangeSlider.snapMode
  property alias live: _rangeSlider.live
  property alias stepSize: _rangeSlider.stepSize

  spacing: 8

  leftPadding: Qaterial.Style.card.verticalPadding
  rightPadding: Qaterial.Style.card.verticalPadding

  contentItem: Item
  {
    implicitHeight: _textLabel.implicitHeight
    implicitWidth: _textLabel.implicitWidth + _secondaryLabel.implicitWidth

    Qaterial.Label
    {
      id: _textLabel
      text: _control.text
      textType: Style.TextType.Body1
    } // Label

    Qaterial.Label
    {
      id: _secondaryLabel
      x: _textLabel.implicitWidth + _control.spacing
      anchors.baseline: _textLabel.baseline
      text: _control.secondaryText
      textType: Style.TextType.Hint
    } // Label

    Qaterial.RangeSlider
    {
      id: _rangeSlider
      y: _textLabel.implicitHeight

      width: _control.width - _control.leftPadding - _control.rightPadding
      x: leftPadding

      first.onMoved: _control.firstMoved()
      second.onMoved: _control.secondMoved()

      parent: _control
    } // RangeSlider
  } // Item
} // Control
