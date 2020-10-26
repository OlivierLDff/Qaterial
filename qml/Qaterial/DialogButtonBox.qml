/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

T.DialogButtonBox
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding)

  spacing: Qaterial.Style.dialog.spacing
  padding: Qaterial.Style.dialog.padding
  alignment: Qt.AlignRight
  buttonLayout: T.DialogButtonBox.AndroidLayout

  property color foregroundColor: Qaterial.Style.accentColor
  property color backgroundColor: Qaterial.Style.backgroundColor

  //delegate: Qaterial.FlatButton { foregroundColor: _control.foregroundColor; onClicked: _list.positionViewAtBeginning() }
  delegate: Qaterial.FlatButton {}

  contentItem: ListView
  {
    id: _list
    model: _control.contentModel
    spacing: _control.spacing
    orientation: ListView.Horizontal
    boundsBehavior: Flickable.StopAtBounds
    snapMode: ListView.SnapToItem
  } // ListView

  background: Rectangle
  {
    implicitHeight: Qaterial.Style.dialog.buttonRectImplicitHeight
    radius: Qaterial.Style.dialog.radius
    color: _control.backgroundColor
    // Rounded corners should be only at the top or at the bottom
    //topPadding: _control.position === T.DialogButtonBox.Footer ? -2 : 0
    //bottomPadding: _control.position === T.DialogButtonBox.Header ? -2 : 0
    //clip: true
  } // Rectangle
} // DialogButtonBox
