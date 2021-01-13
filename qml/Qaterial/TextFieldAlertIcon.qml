/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.TextFieldIcon
{
  id: _control
  color: Qaterial.Style.errorColor
  source: Qaterial.Icons.alertCircle
  onVisibleChanged: function()
  {
    if(visible)
      _anim.start()
  }
  ErrorSequentialAnimation { id: _anim;target: _control; }
} // TextFieldIcon
