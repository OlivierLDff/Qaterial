/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

QtObject
{
  property
  var acceptedCallback
  property
  var appliedCallback
  property
  var rejectedCallback
  property
  var helpRequestedCallback

  property string text
  property string title
  property string iconSource
  property color iconColor

  property int standardButtons
} // QtObject
