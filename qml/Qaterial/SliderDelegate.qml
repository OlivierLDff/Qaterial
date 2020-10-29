/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
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
  implicitHeight: contentItem.implicitHeight + _slider.implicitHeight

  property string text
  property string secondaryText

  signal moved()

  function decrease() { _slider.decrease() }

  function increase() { _slider.increase() }

  function valueAt(position) { return _slider.valueAt(position) }

  property alias value: _slider.value
  property alias from: _slider.from
  property alias to: _slider.to
  property alias snapMode: _slider.snapMode
  property alias live: _slider.live
  property alias position: _slider.position
  property alias pressed: _slider.pressed
  property alias stepSize: _slider.stepSize

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
      textType: Qaterial.Style.TextType.Body1
    } // Label

    Qaterial.Label
    {
      id: _secondaryLabel
      x: _textLabel.implicitWidth + _control.spacing
      anchors.baseline: _textLabel.baseline
      text: _control.secondaryText
      textType: Qaterial.Style.TextType.Hint
    } // Label

    Qaterial.Slider
    {
      id: _slider
      y: _textLabel.implicitHeight

      width: _control.width - _control.leftPadding - _control.rightPadding
      x: leftPadding

      onMoved: _control.moved()

      parent: _control
    } // Slider
  } // Item
} // Control
