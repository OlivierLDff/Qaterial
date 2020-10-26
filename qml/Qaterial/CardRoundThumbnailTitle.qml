/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: _control
  implicitHeight: Math.max(_cardTitle.implicitHeight, _roundImage.implicitHeight) + topPadding + bottomPadding
  implicitWidth: _roundImage.implicitWidth + _cardTitle.implicitWidth + rightPadding + topPadding + spacing

  property alias headerText: _cardTitle.headerText
  property alias subHeaderText: _cardTitle.subHeaderText
  property alias thumbnail: _roundImage.source
  property double imageSize: Qaterial.Style.card.roundImageSize
  property double spacing: Qaterial.Style.card.roundImageSpacing
  property alias textSpacing: _cardTitle.spacing
  property bool mirrored: false

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  readonly property bool imagePresent: _roundImage.source != ""

  property bool drawline: Qaterial.Style.debug.drawDebugIconLabel

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "red"
    visible: _control.drawline
    z: 10
  } // DebugRectangle

  Qaterial.CardTitle
  {
    id: _cardTitle
    anchors.right: _control.mirrored && _control.imagePresent ? _roundImage.left : _control.right
    anchors.left: !_control.imagePresent || _control.mirrored ? _control.left : _roundImage.right
    anchors.rightMargin: _control.mirrored && _control.imagePresent ? _control.spacing : _control.rightPadding
    anchors.leftMargin: !_control.mirrored && _control.imagePresent ? _control.spacing : _control.leftPadding
    onPrimary: _control.onPrimary
    colorReversed: _control.colorReversed
  } // CardTitle

  Qaterial.RoundImage
  {
    id: _roundImage
    width: imageSize
    height: imageSize
    anchors.rightMargin: _control.mirrored ? _control.rightPadding : 0
    anchors.leftMargin: _control.mirrored ? 0 : _control.leftPadding
    anchors.verticalCenter: parent.verticalCenter

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "blue"
      z: 5
      visible: _control.drawline
    } // DebugRectangle

    function reanchors()
    {
      anchors.right = undefined
      anchors.left = undefined
      if(_control.mirrored)
        anchors.right = _control.right
      else
        anchors.left = _control.left
    } // function reanchors()
  } // RoundImage

  function reanchors()
  {
    _roundImage.reanchors()
  }

  onMirroredChanged: Qt.callLater(reanchors)
  Component.onCompleted: reanchors()
}
