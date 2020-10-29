/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.13
import QtQuick.Templates 2.13 as T
import QtQuick.Controls 2.13

// Qaterial
import Qaterial 1.0 as Qaterial

T.SplitView
{
  id: _control
  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding)

  property color handleColor: T.SplitHandle.pressed ? Qaterial.Style.primaryTextColor() :
    Qt.lighter(Qaterial.Style.secondaryTextColor(), T.SplitHandle.hovered ? 1.2 : 1.1)
  property color handleBackgroundColor: Qaterial.Style.theme === Qaterial.Style.Theme.Dark ? "#24262A" : Qaterial
    .Style.disabledDividersColor()

  handle: Rectangle
  {
    implicitWidth: _control.orientation === Qt.Horizontal ? 6 : _control.width
    implicitHeight: _control.orientation === Qt.Horizontal ? _control.height : 6
    color: _control.handleBackgroundColor

    Rectangle
    {
      color: _control.handleColor
      width: _control.orientation === Qt.Horizontal ? thickness : length
      height: _control.orientation === Qt.Horizontal ? length : thickness
      radius: thickness
      x: (parent.width - width) / 2
      y: (parent.height - height) / 2

      property int length: parent.T.SplitHandle.pressed ? 3 : 8
      readonly property int thickness: parent.T.SplitHandle.pressed ? 3 : 1

      Behavior on length
      {
        NumberAnimation { duration: 100 } // NumberAnimation
      } // Behavior
    } // Rectangle
  } // Rectangle
} // SplitView
