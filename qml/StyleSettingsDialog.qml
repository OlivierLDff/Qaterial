/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12
import QtQuick.Layouts 1.12

import Qaterial 1.0

Dialog
{
    id: themeDialog
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    horizontalPadding: 0
    modal: true
    focus: true
    title: "Settings"

    standardButtons: Dialog.Ok | Dialog.Cancel
    onAccepted: {
        themeDialog.close()
    }
    onRejected: {
        themeDialog.close()
    }

    drawSeparator: true

    contentItem: Flickable
    {
        //width: themeDialog.width
        implicitHeight: 400//settingsColumn.implicitHeight
        contentWidth: width
        contentHeight: settingsColumn.implicitHeight

        clip: true
        Column
        {
            id: settingsColumn
            width: parent.width
            spacing: 0

            SwitchDelegate
            {
                width: parent.width
                text: "Debug Icon Label"
                checked: Style.debug.drawDebugIconLabel
                onCheckedChanged:
                {
                    Style.debug.drawDebugIconLabel = checked
                }
            }

            SwitchDelegate
            {
                width: parent.width
                text: "Debug Buttons"
                checked: Style.debug.drawDebugButton
                onCheckedChanged:
                {
                    Style.debug.drawDebugButton = checked
                }
            }

            SwitchDelegate
            {
                width: parent.width
                text: "Debug Delegates"
                checked: Style.debug.drawDebugDelegate
                onCheckedChanged:
                {
                    Style.debug.drawDebugDelegate = checked
                }
            }

            SwitchDelegate
            {
                width: parent.width
                text: checked ? "Dark" : "Light"
                onCheckedChanged:
                {
                    Style.theme = checked ? Style.Theme.Dark : Style.Theme.Light
                }
                Component.onCompleted: checked = Style.theme===Style.Theme.Dark
            }

            SwitchDelegate
            {
                width: parent.width
                text: checked ? "Dense" : "Normal"
                onCheckedChanged:
                {
                    Style.dense = checked
                }
            }

            SwitchDelegate
            {
                width: parent.width
                text: "Reverse Color on Primary (Light)"
                checked: Style.foregroundReversedOnPrimaryLight
                onCheckedChanged:
                {
                    Style.foregroundReversedOnPrimaryLight = checked
                }
            }

            SwitchDelegate
            {
                width: parent.width
                text: "Reverse Color on Primary (Dark)"
                checked: Style.foregroundReversedOnPrimaryDark
                onCheckedChanged:
                {
                    Style.foregroundReversedOnPrimaryDark = checked
                }
            }

            SwitchDelegate
            {
                width: parent.width
                text: "Reverse Ripple on Primary (Light)"
                checked: Style.rippleReversedOnPrimaryLight
                onCheckedChanged:
                {
                    Style.rippleReversedOnPrimaryLight = checked
                }
            }

            SwitchDelegate
            {
                width: parent.width
                text: "Reverse Ripple on Primary (Dark)"
                checked: Style.rippleReversedOnPrimaryDark
                onCheckedChanged:
                {
                    Style.rippleReversedOnPrimaryDark = checked
                }
            }

            SwitchDelegate
            {
                width: parent.width
                text: "Reverse Color on Accent (Light)"
                checked: Style.foregroundReversedOnAccentLight
                onCheckedChanged:
                {
                    Style.foregroundReversedOnAccentLight = checked
                }
            }

            SwitchDelegate
            {
                width: parent.width
                text: "Reverse Color on Accent (Dark)"
                checked: Style.foregroundReversedOnAccentDark
                onCheckedChanged:
                {
                    Style.foregroundReversedOnAccentDark = checked
                }
            }

            SwitchDelegate
            {
                width: parent.width
                text: "Prefer Accent Color on Primary (Light)"
                checked: Style.preferAccentOnPrimaryLight
                onCheckedChanged:
                {
                    Style.preferAccentOnPrimaryLight = checked
                }
            }

            SwitchDelegate
            {
                width: parent.width
                text: "Prefer Accent Color on Primary (Dark)"
                checked: Style.preferAccentOnPrimaryDark
                onCheckedChanged:
                {
                    Style.preferAccentOnPrimaryDark = checked
                }
            }

            Label
            {
                text: "Primary Color"
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                width: parent.width
            }
            ListModel
            {
                id: colorModel
                ListElement { color: "#f44336"; materialColor: true }
                ListElement { color: "#E91E63"; materialColor: true }
                ListElement { color: "#9C27B0"; materialColor: true }
                ListElement { color: "#673AB7"; materialColor: true }
                ListElement { color: "#3F51B5"; materialColor: true }
                ListElement { color: "#2196F3"; materialColor: true }
                ListElement { color: "#03A9F4"; materialColor: true }
                ListElement { color: "#00BCD4"; materialColor: true }
                ListElement { color: "#009688"; materialColor: true }
                ListElement { color: "#4CAF50"; materialColor: true }
                ListElement { color: "#8BC34A"; materialColor: true }
                ListElement { color: "#CDDC39"; materialColor: true }
                ListElement { color: "#FFEB3B"; materialColor: true }
                ListElement { color: "#FFC107"; materialColor: true }
                ListElement { color: "#FF9800"; materialColor: true }
                ListElement { color: "#FF5722"; materialColor: true }
                ListElement { color: "0"; materialColor: false; colorString: "#303030" }
                ListElement { color: "0"; materialColor: false; colorString: "#212121" }

            }

            GridLayout
            {
                //width: parent.width
                columns: parent.width/45
                width: parent.width
                Repeater
                {
                    model: colorModel

                    delegate: Rectangle
                    {
                        id: icon
                        width: 40; height: 40
                        color: model.materialColor ? model.color : model.colorString
                        radius: 3
                        MouseArea
                        {
                            anchors.fill: parent
                            onClicked:
                            {
                                if(Style.theme == Style.Theme.Light)
                                {
                                    Style.primaryColorLight = model.materialColor ? model.color : model.colorString
                                }
                                else
                                {
                                    Style.primaryColorDark = model.materialColor ? model.color : model.colorString
                                }
                            }
                        }
                    }
                }
            }

            Label
            {
                text: "Accent Color"
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                width: parent.width
            }
            GridLayout
            {
                //width: parent.width
                columns: parent.width/45
                width: parent.width
                Repeater
                {
                    model: colorModel

                    delegate: Rectangle
                    {
                        id: icon
                        width: 40; height: 40
                        color: model.materialColor ? model.color : model.colorString
                        radius: 3
                        MouseArea
                        {
                            anchors.fill: parent
                            onClicked:
                            {
                                if(Style.theme == Style.Theme.Light)
                                {
                                    Style.accentColorLight = model.materialColor ? model.color : model.colorString
                                }
                                else
                                {
                                    Style.accentColorDark = model.materialColor ? model.color : model.colorString
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
