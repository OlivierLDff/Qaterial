/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0 as Qaterial

T.Page
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    contentWidth + leftPadding + rightPadding,
    implicitHeaderWidth,
    implicitFooterWidth)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding +
    (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0) +
    (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

  property color backgroundColor: Qaterial.Style.backgroundColor

  background: Rectangle
  {
    color: _control.backgroundColor
  } // Rectangle
} // Page
