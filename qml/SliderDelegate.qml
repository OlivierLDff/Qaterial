/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12 as Q
import QtQuick.Layouts 1.12 as QL
import QtQuick.Controls 2.12 as QC2

// Qaterial
import Qaterial 1.0

QC2.Control
{
    id: control
    implicitWidth: Style.delegate.implicitWidth
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
    property alias live : _slider.live
    property alias position: _slider.position
    property alias pressed: _slider.pressed
    property alias stepSize: _slider.stepSize

    spacing: 8

    leftPadding: Style.card.verticalPadding
    rightPadding: Style.card.verticalPadding

    contentItem: Q.Item
    {
        implicitHeight: _textLabel.implicitHeight
        implicitWidth: _textLabel.implicitWidth + _secondaryLabel.implicitWidth

        Label
        {
            id: _textLabel
            text: control.text
            textType: Style.TextType.Body1
        }

        Label
        {
            id: _secondaryLabel
            x: _textLabel.implicitWidth + control.spacing
            y: Math.floor(_textLabel.height/2) - Math.floor(height/2)
            text: control.secondaryText
            textType: Style.TextType.Hint
        }

        Slider
        {
            id: _slider
            y: _textLabel.implicitHeight

            width: control.width - control.leftPadding - control.rightPadding
            x: leftPadding

            onMoved: control.moved()

            parent: control
        }
    }
}
