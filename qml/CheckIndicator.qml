/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

Rectangle
{
    id: indicatorItem
    implicitWidth: MaterialStyle.checkIndicator.implicitWidth
    implicitHeight: MaterialStyle.checkIndicator.implicitHeight
    color: "transparent"
    border.color: !control.enabled ? MaterialStyle.hintTextColor()
        : checkState !== Qt.Unchecked ? MaterialStyle.accentColor : MaterialStyle.secondaryTextColor()
    border.width: checkState !== Qt.Unchecked ? width / 2 : 2
    radius: MaterialStyle.checkIndicator.radius

    property Item control
    property int checkState: control.checkState

    Behavior on border.width
    {
        NumberAnimation
        {
            duration: 100
            easing.type: Easing.OutCubic
        } // NumberAnimation
    } // Behavior

    Behavior on border.color
    {
        ColorAnimation
        {
            duration: 100
            easing.type: Easing.OutCubic
        } // ColorAnimation
    } // Behavior

    ColorIcon
    {
        id: checkImage
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        iconSize: MaterialStyle.checkIndicator.iconWidth
        source: "qrc:/Qaterial/Images/check.svg"
        color: "white"

        scale: checkState === Qt.Checked ? 1 : 0
        Behavior on scale { NumberAnimation { duration: 100 } }
    } // ColorIcon

    Rectangle
    {
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: MaterialStyle.checkIndicator.partiallyCheckedWidth
        height: MaterialStyle.checkIndicator.partiallyCheckedHeight
        color: "white"

        scale: checkState === Qt.PartiallyChecked ? 1 : 0
        Behavior on scale { NumberAnimation { duration: 100 } }
    } // Rectangle

    states:
    [
        State
        {
            name: "checked"
            when: checkState === Qt.Checked
        }, // State
        State
        {
            name: "partiallychecked"
            when: checkState === Qt.PartiallyChecked
        } // State
    ]

    transitions: Transition
    {
        SequentialAnimation
        {
            NumberAnimation
            {
                target: indicatorItem
                property: "scale"
                // Go down 2 pixels in size.
                to: 1 - 2 / indicatorItem.width
                duration: 120
            } // NumberAnimation
            NumberAnimation
            {
                target: indicatorItem
                property: "scale"
                to: 1
                duration: 120
            } // NumberAnimation
        } // SequentialAnimation
    } // Transition
} // Rectangle
