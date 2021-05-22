/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Controls

// Qaterial
import Qaterial 1.0 as Qaterial

// TO DO : improve that to use Qaterial.DialogManager
Qaterial.ItemDelegate
{
  id: _control

  signal accepted(int value)
  signal rejected()

  property alias model: _radioDialog.model
  property alias value: _radioDialog.currentIndex
  property alias delegate: _radioDialog.delegate
  property alias currentIndex: _radioDialog.currentIndex
  property alias title: _radioDialog.title

  Qaterial.RadioDialog
  {
    id: _radioDialog
    onAccepted: _control.accepted(currentIndex)
    onRejected: _control.rejected()
  } // RadioDialog

  onClicked: _radioDialog.open()
} // ItemDelegate
