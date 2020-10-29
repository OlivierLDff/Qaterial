/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.ModalDialog
{
  id: _dialog

  property int hour
  property int minute
  property bool showMinutes
  property bool styleAm
  property bool am

  readonly property real _unfocusedOpacity: 0.8
  readonly property int _labelSize: Qaterial.Style.dense ? 24 : 32

  padding: 10

  standardButtons: Dialog.Ok | Dialog.Cancel

  header: Rectangle
  {
    id: _header
    color: Qaterial.Style.accentColor
    implicitHeight: 100
    radius: Qaterial.Style.dialog.radius

    function pad(num, size)
    {
      let s = num + "";
      while(s.length < size) s = "0" + s;
      return s;
    }

    Rectangle
    {
      // To hide header bottom corner radius
      anchors.right: parent.right;
      anchors.left: parent.left;
      anchors.bottom: parent.bottom
      height: parent.height / 2
      color: parent.color
    } // Rectangle

    Row
    {
      // Centering the ":" hour separator on 12h
      anchors.verticalCenter: parent.verticalCenter
      x: _dialog.width / 2 - _switchHourButton.width - _hourSeparator.width / 2

      Qaterial.FlatButton
      {
        id: _switchHourButton
        backgroundImplicitWidth: 10
        leftPadding: 4;rightPadding: 4
        leftInset: 0;rightInset: 0;topInset: 0;bottomInset: 0

        text: _header.pad(_dialog.hour, 2)
        textType: Qaterial.Style.TextType.Display3
        highlighted: false
        opacity: showMinutes ? _dialog._unfocusedOpacity : 1
        onClicked: _dialog.showMinutes = false
      } // Hour: FlatButton

      Qaterial.Label
      {
        id: _hourSeparator
        text: ":"
        textType: Qaterial.Style.TextType.Display3
        opacity: _dialog._unfocusedOpacity
      } // Hour Separator: Label

      Qaterial.FlatButton
      {
        id: _switchMinuteButton
        backgroundImplicitWidth: 10
        leftPadding: 4;rightPadding: 4
        leftInset: 0;rightInset: 0;topInset: 0;bottomInset: 0

        text: _header.pad(_dialog.minute, 2)
        textType: Qaterial.Style.TextType.Display3
        highlighted: false
        opacity: showMinutes ? 1 : _dialog._unfocusedOpacity
        onClicked: _dialog.showMinutes = true
      } // Minute: FlatButton

      Column
      {
        visible: styleAm
        anchors.verticalCenter: parent.verticalCenter
        spacing: 2

        Qaterial.FlatButton
        {
          id: _amButton

          backgroundImplicitWidth: 10
          backgroundImplicitHeight: 20
          leftInset: 0;rightInset: 0;topInset: 0;bottomInset: 0

          text: "AM"
          textType: Qaterial.Style.TextType.Subheading
          highlighted: false
          opacity: _dialog.am ? 1 : _dialog._unfocusedOpacity
          font.bold: true

          onClicked: _dialog.am = true
        } // AM: FlatButton

        Qaterial.FlatButton
        {
          id: _pmButton

          backgroundImplicitWidth: 10
          backgroundImplicitHeight: 20
          leftInset: 0;rightInset: 0;topInset: 0;bottomInset: 0

          text: "PM"
          textType: Qaterial.Style.TextType.Subheading
          highlighted: false
          opacity: _dialog.am ? _dialog._unfocusedOpacity : 1
          font.bold: true

          onClicked: _dialog.am = false
        } // PM: FlatButton
      } // Column
    } // Row
  } // header: Rectangle

  contentItem: Item
  {
    id: _contentItem
    implicitHeight: _loader.implicitHeight

    readonly property real radius: width / 2 - _dialog._labelSize / 2

    Rectangle
    {
      anchors.centerIn: parent
      width: parent.width + 8
      height: parent.height + 8
      radius: width / 2
      color: Qt.lighter(Qaterial.Style.dialogColor, 1.1)
    }

    Loader
    {
      id: _loader
      sourceComponent:
      {
        if(_dialog.showMinutes)
          return _circularMinutePickerComponent

        return _dialog.styleAm ? _amCircularHourPickerComponent : _euCircularHourPickerComponent
      }
    } // Loader

    Component
    {
      id: _euCircularHourPickerComponent
      Qaterial.EuCircularHourPicker
      {
        radius: _contentItem.radius
        hour: _dialog.hour
        onAccepted: (hour) => _dialog.hour = hour
      } // EuCircularHourPicker
    } // EuHour: Component

    Component
    {
      id: _amCircularHourPickerComponent
      Qaterial.AmCircularHourPicker
      {
        radius: _contentItem.radius
        hour: _dialog.hour
        onAccepted: (hour) => _dialog.hour = hour
      } // AmCircularHourPicker
    } // AmHour: Component

    Component
    {
      id: _circularMinutePickerComponent
      Qaterial.CircularMinutePicker
      {
        radius: _contentItem.radius
        minute: _dialog.minute
        onAccepted: (minute) => _dialog.minute = minute
      } // CircularMinutePicker
    } // Minute: Component
  } // contentItem : Item
}
