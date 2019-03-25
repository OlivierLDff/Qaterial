/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12

T.MenuSeparator 
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    verticalPadding: MaterialStyle.menu.separatorHSmallPadding
    rightPadding: !mirrored ? MaterialStyle.menu.separatorWSmallPadding : MaterialStyle.menu.separatorWLargePadding
    leftPadding: mirrored ? MaterialStyle.menu.separatorWSmallPadding : MaterialStyle.menu.separatorWLargePadding

    property bool highlighted: false

    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    property color foregroundColor: !enabled ? (colorReversed ? MaterialStyle.disabledDividersColorReversed() : MaterialStyle.disabledDividersColor()) :
                    highlighted && accentColorAuthorized ? MaterialStyle.accentColor :
                    colorReversed ? MaterialStyle.dividersColorReversed() : MaterialStyle.dividersColor()

    property bool drawline: MaterialStyle.debug.drawDebugButton

    property double separatorImplicitWidth: MaterialStyle.menu.separatorImplicitWidth

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    } // DebugRectangle

    contentItem: Rectangle 
    {
        implicitWidth: control.separatorImplicitWidth
        implicitHeight: 1
        color: control.foregroundColor

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "red"
            visible: control.drawline
        } // DebugRectangle
    
    } // Rectangle
} // MenuSeparator
