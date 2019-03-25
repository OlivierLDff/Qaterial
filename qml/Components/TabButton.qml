/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

import QtGraphicalEffects 1.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12

T.TabButton 
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    leftPadding: ((icon.source != "" && !mirrored) ? MaterialStyle.tabButton.iconPadding : 
                                                   MaterialStyle.tabButton.padding) + leftInset
    rightPadding: ((icon.source != "" && mirrored) ? MaterialStyle.tabButton.iconPadding : 
                                                     MaterialStyle.tabButton.padding) + rightInset

    topInset: MaterialStyle.tabButton.topInset
    bottomInset: MaterialStyle.tabButton.bottomInset
    leftInset: MaterialStyle.tabButton.leftInset
    rightInset: MaterialStyle.tabButton.rightInset

    topPadding: useSmallFont ? MaterialStyle.tabButton.smallTopPadding : MaterialStyle.tabButton.topPadding
    bottomPadding: topPadding
    spacing: display === AbstractButton.TextUnderIcon ? (useSmallFont ? MaterialStyle.tabButton.smallSpacingVertical : MaterialStyle.tabButton.spacingVertical ) : (useSmallFont ? MaterialStyle.tabButton.smallSpacing : MaterialStyle.tabButton.spacing)

    font.family: MaterialStyle.tabButton.fontFamily
    font.pointSize: useSmallFont ? MaterialStyle.tabButton.smallFontPointSize : MaterialStyle.tabButton.fontPointSize
    font.capitalization: MaterialStyle.tabButton.fontCapitalisation
    font.styleName: MaterialStyle.tabButton.fontStyleName

    icon.width: MaterialStyle.tabButton.iconWidth
    icon.height: MaterialStyle.tabButton.iconWidth
    icon.color: foregroundColor

    property color foregroundColor: !enabled ? (colorReversed ? MaterialStyle.disabledTextColorReversed() : MaterialStyle.disabledTextColor()) :                                    
                                    (down || checked) ? (highlighted ? MaterialStyle.buttonAccentColor : (colorReversed ? MaterialStyle.primaryTextColorReversed() : MaterialStyle.primaryTextColor())) : 
                                        highlighted ? (colorReversed ? MaterialStyle.primaryTextColorReversed() : MaterialStyle.primaryTextColor()) :
                                                      (colorReversed ? MaterialStyle.secondaryTextColorReversed() : MaterialStyle.secondaryTextColor())

    property color backgroundColor: pressed ? MaterialStyle.backgroundColor : 
        !enabled ? (MaterialStyle.buttonDisabledColor) : (highlighted ? MaterialStyle.buttonAccentColor : MaterialStyle.buttonColor )

    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary
    property bool highlighted: onPrimary ? MaterialStyle.preferAccentOnPrimary : true
    property bool useSmallFont: hintText
    property bool hintText: false

    property alias elide: _iconLabel.elide

    property color rippleColor: MaterialStyle.rippleColor(onPrimary ? MaterialStyle.RippleBackground.Primary : MaterialStyle.RippleBackground.Background)

    display: hintText && !checked ? AbstractButton.IconOnly : AbstractButton.TextUnderIcon

    contentItem: IconLabel 
    {
        id: _iconLabel
        textType: MaterialStyle.TextType.Button
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
                            MaterialStyle.tabButton.minHeightWithIcon : 
                            control.useSmallFont ? MaterialStyle.tabButton.minHeightWithSmallIcon : 
                                MaterialStyle.tabButton.minHeight
                                
        implicitWidth: MaterialStyle.tabButton.minWidth
        clip: true
        pressed: control.pressed
        anchor: control
        active: control.down || control.visualFocus || control.hovered
        color: control.rippleColor
    } // Ripple
}
