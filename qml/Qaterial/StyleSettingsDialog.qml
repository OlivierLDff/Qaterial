/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Layouts 1.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.Dialog
{
  id: _themeDialog
  x: (parent.width - width) / 2
  y: (parent.height - height) / 2
  horizontalPadding: 0
  modal: true
  focus: true
  title: "Settings"

  standardButtons: Dialog.Ok | Dialog.Cancel
  onAccepted:
  {
    _themeDialog.close()
  }
  onRejected:
  {
    _themeDialog.close()
  }

  drawSeparator: true

  contentItem: Flickable
  {
    //width: _themeDialog.width
    implicitHeight: 400 //_settingsColumn.implicitHeight
    contentWidth: width
    contentHeight: _settingsColumn.implicitHeight

    clip: true
    Column
    {
      id: _settingsColumn
      width: parent.width
      spacing: 0

      Qaterial.SwitchDelegate
      {
        width: parent.width
        text: "Debug Icon Label"
        checked: Qaterial.Style.debug.drawDebugIconLabel
        onCheckedChanged:
        {
          Qaterial.Style.debug.drawDebugIconLabel = checked
        }
      } // SwitchDelegate

      Qaterial.SwitchDelegate
      {
        width: parent.width
        text: "Debug Buttons"
        checked: Qaterial.Style.debug.drawDebugButton
        onCheckedChanged:
        {
          Qaterial.Style.debug.drawDebugButton = checked
        }
      } // SwitchDelegate

      Qaterial.SwitchDelegate
      {
        width: parent.width
        text: "Debug Delegates"
        checked: Qaterial.Style.debug.drawDebugDelegate
        onCheckedChanged:
        {
          Qaterial.Style.debug.drawDebugDelegate = checked
        }
      } // SwitchDelegate

      Qaterial.SwitchDelegate
      {
        width: parent.width
        text: checked ? "Dark" : "Light"
        onCheckedChanged:
        {
          Qaterial.Style.theme = checked ? Qaterial.Style.Theme.Dark : Qaterial.Style.Theme.Light
        }
        Component.onCompleted: checked = Qaterial.Style.theme === Qaterial.Style.Theme.Dark
      } // SwitchDelegate

      Qaterial.SwitchDelegate
      {
        width: parent.width
        text: checked ? "Dense" : "Normal"
        onCheckedChanged:
        {
          Qaterial.Style.dense = checked
        }
      } // SwitchDelegate

      Qaterial.SwitchDelegate
      {
        width: parent.width
        text: "Reverse Color on Primary (Light)"
        checked: Qaterial.Style.foregroundReversedOnPrimaryLight
        onCheckedChanged:
        {
          Qaterial.Style.foregroundReversedOnPrimaryLight = checked
        }
      } // SwitchDelegate

      Qaterial.SwitchDelegate
      {
        width: parent.width
        text: "Reverse Color on Primary (Dark)"
        checked: Qaterial.Style.foregroundReversedOnPrimaryDark
        onCheckedChanged:
        {
          Qaterial.Style.foregroundReversedOnPrimaryDark = checked
        }
      } // SwitchDelegate

      Qaterial.SwitchDelegate
      {
        width: parent.width
        text: "Reverse Ripple on Primary (Light)"
        checked: Qaterial.Style.rippleReversedOnPrimaryLight
        onCheckedChanged:
        {
          Qaterial.Style.rippleReversedOnPrimaryLight = checked
        }
      } // SwitchDelegate

      Qaterial.SwitchDelegate
      {
        width: parent.width
        text: "Reverse Ripple on Primary (Dark)"
        checked: Qaterial.Style.rippleReversedOnPrimaryDark
        onCheckedChanged:
        {
          Qaterial.Style.rippleReversedOnPrimaryDark = checked
        }
      } // SwitchDelegate

      Qaterial.SwitchDelegate
      {
        width: parent.width
        text: "Reverse Color on Accent (Light)"
        checked: Qaterial.Style.foregroundReversedOnAccentLight
        onCheckedChanged:
        {
          Qaterial.Style.foregroundReversedOnAccentLight = checked
        }
      } // SwitchDelegate

      Qaterial.SwitchDelegate
      {
        width: parent.width
        text: "Reverse Color on Accent (Dark)"
        checked: Qaterial.Style.foregroundReversedOnAccentDark
        onCheckedChanged:
        {
          Qaterial.Style.foregroundReversedOnAccentDark = checked
        }
      } // SwitchDelegate

      Qaterial.SwitchDelegate
      {
        width: parent.width
        text: "Prefer Accent Color on Primary (Light)"
        checked: Qaterial.Style.preferAccentOnPrimaryLight
        onCheckedChanged:
        {
          Qaterial.Style.preferAccentOnPrimaryLight = checked
        }
      } // SwitchDelegate

      Qaterial.SwitchDelegate
      {
        width: parent.width
        text: "Prefer Accent Color on Primary (Dark)"
        checked: Qaterial.Style.preferAccentOnPrimaryDark
        onCheckedChanged:
        {
          Qaterial.Style.preferAccentOnPrimaryDark = checked
        }
      } // SwitchDelegate

      Qaterial.Label
      {
        text: "Primary Color"
        horizontalAlignment: Label.AlignHCenter
        verticalAlignment: Label.AlignVCenter
        width: parent.width
      } // Label

      ListModel
      {
        id: _colorModel
        ListElement { color: "#f44336";materialColor: true }
        ListElement { color: "#E91E63";materialColor: true }
        ListElement { color: "#9C27B0";materialColor: true }
        ListElement { color: "#673AB7";materialColor: true }
        ListElement { color: "#3F51B5";materialColor: true }
        ListElement { color: "#2196F3";materialColor: true }
        ListElement { color: "#03A9F4";materialColor: true }
        ListElement { color: "#00BCD4";materialColor: true }
        ListElement { color: "#009688";materialColor: true }
        ListElement { color: "#4CAF50";materialColor: true }
        ListElement { color: "#8BC34A";materialColor: true }
        ListElement { color: "#CDDC39";materialColor: true }
        ListElement { color: "#FFEB3B";materialColor: true }
        ListElement { color: "#FFC107";materialColor: true }
        ListElement { color: "#FF9800";materialColor: true }
        ListElement { color: "#FF5722";materialColor: true }
        ListElement { color: "0";materialColor: false;colorString: "#303030" }
        ListElement { color: "0";materialColor: false;colorString: "#212121" }
      } // ListModel

      GridLayout
      {
        //width: parent.width
        columns: parent.width / 45
        width: parent.width
        Repeater
        {
          model: _colorModel

          delegate: Rectangle
          {
            id: _icon
            width: 40;height: 40
            color: model.materialColor ? model.color : model.colorString
            radius: 3
            MouseArea
            {
              anchors.fill: parent
              onClicked:
              {
                if(Qaterial.Style.theme == Qaterial.Style.Theme.Light)
                {
                  Qaterial.Style.primaryColorLight = model.materialColor ? model.color : model.colorString
                } // if
                else
                {
                  Qaterial.Style.primaryColorDark = model.materialColor ? model.color : model.colorString
                } // else
              } // onClicked
            } // MouseArea
          } // Rectangle
        } // Repeater
      } // GridLayout

      Qaterial.Label
      {
        text: "Accent Color"
        horizontalAlignment: Label.AlignHCenter
        verticalAlignment: Label.AlignVCenter
        width: parent.width
      }
      GridLayout
      {
        //width: parent.width
        columns: parent.width / 45
        width: parent.width
        Repeater
        {
          model: _colorModel

          delegate: Rectangle
          {
            id: _icon
            width: 40;height: 40
            color: model.materialColor ? model.color : model.colorString
            radius: 3
            MouseArea
            {
              anchors.fill: parent
              onClicked:
              {
                if(Qaterial.Style.theme == Qaterial.Style.Theme.Light)
                {
                  Qaterial.Style.accentColorLight = model.materialColor ? model.color : model.colorString
                } // if
                else
                {
                  Qaterial.Style.accentColorDark = model.materialColor ? model.color : model.colorString
                } // else
              } // onCLicked
            } // MouseArea
          } // Rectangle
        } // Repeater
      } // GridLayout
    } // Column
  } // Flickable
} // Dialog
