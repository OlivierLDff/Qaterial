/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0 as Qaterial

T.GroupBox
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding)

  spacing: Qaterial.Style.card.spacing
  horizontalPadding: Qaterial.Style.card.horizontalPadding
  verticalPadding: Qaterial.Style.card.verticalPadding

  topPadding: verticalPadding + (inlineTitle ? (implicitLabelWidth > 0 ? implicitLabelHeight / 2 + spacing : 0) : (
    implicitLabelWidth > 0 ? implicitLabelHeight + spacing : 0))

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  property color color: onPrimary ? Qaterial.Style.primaryColor : Qaterial.Style.backgroundColor
  property color borderColor: enabled ? Qaterial.Style.dividersColor() : Qaterial.Style.disabledDividersColor()
  property alias radius: _rect.radius

  property int textType: Qaterial.Style.TextType.Overline

  property bool inlineTitle: false

  label: Qaterial.Label
  {
    id: _label
    x: _control.leftPadding + (_control.inlineTitle ? (_control.verticalPadding) : 0)
    width: _control.availableWidth - x

    text: _control.title
    textType: _control.textType
    onPrimary: _control.onPrimary
    colorReversed: _control.colorReversed
    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter

    property bool drawline: Qaterial.Style.debug.drawDebugIconLabel
  } // Label

  background: Rectangle
  {
    id: _rect
    y: _control.inlineTitle ? label.implicitHeight / 2 : (_control.topPadding - _control.bottomPadding)
    implicitWidth: 200
    width: parent.width
    height: parent.height + (_control.inlineTitle ? (-label.implicitHeight / 2) : (-_control.topPadding + _control
      .bottomPadding))
    radius: Qaterial.Style.card.radius
    color: _control.inlineTitle ? "transparent" : _control.color
    border.color: _control.borderColor
    border.width: 1
    layer.enabled: _control.inlineTitle && _control.implicitLabelWidth
    layer.effect: OpacityMask
    {
      invert: true
      maskSource: Rectangle
      {
        color: "transparent"
        width: _rect.width
        height: _rect.height
        Rectangle
        {
          width: label.contentWidth + _control.verticalPadding * 2
          height: label.implicitHeight
          x: _control.leftPadding
          y: -height / 2
        } // Rectangle
      } // Rectangle
    } // OpacityMask
  } // Rectangle
} // GroupBox
