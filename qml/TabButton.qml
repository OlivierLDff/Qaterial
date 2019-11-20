/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

import QtGraphicalEffects 1.12

import Qaterial 1.0

T.TabButton
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    leftPadding: ((icon.source != "" && !mirrored) ? Style.tabButton.iconPadding :
                                                   Style.tabButton.padding) + leftInset
    rightPadding: ((icon.source != "" && mirrored) ? Style.tabButton.iconPadding :
                                                     Style.tabButton.padding) + rightInset

    topInset: Style.tabButton.topInset
    bottomInset: Style.tabButton.bottomInset
    leftInset: Style.tabButton.leftInset
    rightInset: Style.tabButton.rightInset

    topPadding: useSmallFont ? Style.tabButton.smallTopPadding : Style.tabButton.topPadding
    bottomPadding: topPadding
    spacing: display === AbstractButton.TextUnderIcon ? (useSmallFont ? Style.tabButton.smallSpacingVertical : Style.tabButton.spacingVertical ) : (useSmallFont ? Style.tabButton.smallSpacing : Style.tabButton.spacing)

    font.family: Style.textTypeToFontFamily(Style.TextType.Button)
    font.styleName: Style.textTypeToStyleName(Style.TextType.Button)
    font.pixelSize: useSmallFont ? Style.textTypeToPixelSize(Style.TextType.Hint) : Style.textTypeToPixelSize(Style.TextType.Button)
    font.capitalization: Style.fontCapitalization(Style.TextType.Button)
    font.letterSpacing:  Style.textTypeToLetterSpacing(Style.TextType.Button)

    icon.width: Style.tabButton.iconWidth
    icon.height: Style.tabButton.iconWidth
    icon.color: foregroundColor

    property color foregroundColor: !enabled ? (colorReversed ? Style.disabledTextColorReversed() : Style.disabledTextColor()) :
                                    (down || checked) ? (highlighted ? Style.buttonAccentColor : (colorReversed ? Style.primaryTextColorReversed() : Style.primaryTextColor())) :
                                        highlighted ? (colorReversed ? Style.primaryTextColorReversed() : Style.primaryTextColor()) :
                                                      (colorReversed ? Style.secondaryTextColorReversed() : Style.secondaryTextColor())

    property color backgroundColor: pressed ? Style.backgroundColor :
        !enabled ? (Style.buttonDisabledColor) : (highlighted ? Style.buttonAccentColor : Style.buttonColor )

    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary
    property bool highlighted: onPrimary ? Style.preferAccentOnPrimary : true
    property bool useSmallFont: hintText
    property bool hintText: false

    property alias elide: _iconLabel.elide

    property color rippleColor: Style.rippleColor(onPrimary ? Style.RippleBackground.Primary : Style.RippleBackground.Background)

    display: hintText && !checked ? AbstractButton.IconOnly : AbstractButton.TextUnderIcon

    contentItem: IconLabel
    {
        id: _iconLabel
        textType: Style.TextType.Button
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        icon: control.icon
        text: control.text
        font: control.font
        color: control.foregroundColor
    } // IconLabel

    background: Ripple
    {
        implicitHeight: (control.icon.source != "" &&
                        control.text != "" &&
                        control.display === AbstractButton.TextUnderIcon &&
                        !control.useSmallFont) ?
                            Style.tabButton.minHeightWithIcon :
                            control.useSmallFont ? Style.tabButton.minHeightWithSmallIcon :
                                Style.tabButton.minHeight

        implicitWidth: Style.tabButton.minWidth
        clip: true
        pressed: control.pressed
        anchor: control
        active: control.down || control.visualFocus || control.hovered
        color: control.rippleColor
    } // Ripple
}
