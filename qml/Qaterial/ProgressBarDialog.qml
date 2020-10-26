/*
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.ModalDialog
{
  id: _control

  width: undefined

  property alias from: _progressBar.from
  property alias to: _progressBar.to
  property alias value: _progressBar.value

  property alias text: _text.text
  property alias textType: _text.textType
  property alias textColor: _text.color
  property alias textElide: _text.elide

  title: "Exporting Frames"

  contentItem: Item
  {
    implicitWidth: Qaterial.Style.dialog.implicitWidth - 2 * Qaterial.Style.card.horizontalPadding
    implicitHeight: Math.floor(_progressBar.implicitHeight + _text.implicitHeight + Qaterial.Style.card
      .verticalPadding)

    Qaterial.ProgressBar
    {
      id: _progressBar
      width: parent.width
      anchors.horizontalCenter: parent.horizontalCenter
    } // ProgressBar

    Qaterial.Label
    {
      id: _text

      width: parent.width
      y: _progressBar.height + Qaterial.Style.card.verticalPadding
      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: Text.AlignHCenter
    } // Label
  } //Item
} // ModalDialog
