/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Window 2.12

import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0

T.Menu
{
    id: control

    property double elevation: MaterialStyle.menu.elevation

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    margins: 0
    verticalPadding: MaterialStyle.menu.verticalPadding

    transformOrigin: !cascade ? Item.Top : (mirrored ? Item.TopRight : Item.TopLeft)

    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    delegate: MenuItem { onPrimary: control.onPrimary; colorReversed: control.colorReversed }

    enter: Transition
    {
        // grow_fade_in
        NumberAnimation { property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
    } // Transition

    exit: Transition
    {
        // shrink_fade_out
        NumberAnimation { property: "scale"; from: 1.0; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
    } // Transition

    contentItem: ListView
    {
        implicitHeight: contentHeight

        model: control.contentModel
        interactive: Window.window ? contentHeight > Window.window.height : false
        clip: true
        currentIndex: control.currentIndex

        ScrollIndicator.vertical: ScrollIndicator {}
    } // ListView

    property color backgroundColor: MaterialStyle.dialogColor

    background: Rectangle
    {
        implicitWidth: MaterialStyle.menu.implicitWidth
        implicitHeight: MaterialStyle.menu.implicitHeight

        radius: MaterialStyle.menu.radius
        color: control.backgroundColor

        layer.enabled: control.elevation > 0
        layer.effect: ElevationEffect
        {
            elevation: control.elevation
        } // ElevationEffect
    } // Rectangle

    T.Overlay.modal: Rectangle
    {
        color: MaterialStyle.overlayColor
        Behavior on opacity { NumberAnimation { duration: 150 } }
    } // Rectangle

    T.Overlay.modeless: Rectangle
    {
        color: MaterialStyle.overlayColor
        Behavior on opacity { NumberAnimation { duration: 150 } }
    } // Rectangle
}
