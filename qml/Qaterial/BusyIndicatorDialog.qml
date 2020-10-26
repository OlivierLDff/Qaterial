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

Qaterial.ModalDialog
{
  id: _control

  property alias text: _text.text
  width: undefined
  closePolicy: Popup.NoAutoClose

  contentItem: Item
  {
    implicitHeight: Math.floor(_busy.implicitHeight + _text.implicitHeight + Qaterial.Style.card.verticalPadding)

    implicitWidth: Qaterial.Style.dialog.implicitWidth - 2 * Qaterial.Style.card.horizontalPadding

    Qaterial.BusyIndicator
    {
      id: _busy
      anchors.horizontalCenter: parent.horizontalCenter
    } // BusyIndicator

    Qaterial.Label
    {
      id: _text

      text: _control.text
      anchors.horizontalCenter: parent.horizontalCenter
      y: _busy.height + Qaterial.Style.card.verticalPadding
      width: parent.width
      textType: Qaterial.Style.TextType.ListText
      color: Qaterial.Style.secondaryTextColor()
      elide: Text.ElideRight
      horizontalAlignment: Text.AlignHCenter
    } // Label
  } // Item
} // ModalDialog
