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
  id: root

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding)

  spacing: Qaterial.Style.dialog.spacing
  padding: Qaterial.Style.dialog.padding
  alignment: Qt.AlignRight
  buttonLayout: T.DialogButtonBox.AndroidLayout

  property alias backgroundColor: root.palette.base
  palette.base: Qaterial.Style.colorTheme.dialog

  delegate: Qaterial.FlatButton {}

  contentItem: Row
  {
    spacing: root.spacing

    Repeater
    {
      model: root.contentModel
    }
  } // Row

  background: Rectangle
  {
    implicitHeight: Qaterial.Style.dialog.buttonRectImplicitHeight
    radius: Qaterial.Style.dialog.radius
    color: root.palette.base

    Rectangle
    {
      anchors
      {
        right: parent.right
        left: parent.left
      }

      y: root.position === T.DialogButtonBox.Footer ? 0 : parent.height - height
      height: Qaterial.Style.dialog.radius

      color: root.palette.base
    }
  } // Rectangle
} // DialogButtonBox
