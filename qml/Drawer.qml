/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0

T.Drawer
{
    id: control

    parent: T.Overlay.overlay

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    topPadding: !dim && edge === Qt.BottomEdge && elevation === 0
    leftPadding: !dim && edge === Qt.RightEdge && elevation === 0
    rightPadding: !dim && edge === Qt.LeftEdge && elevation === 0
    bottomPadding: !dim && edge === Qt.TopEdge && elevation === 0

    enter: Transition { SmoothedAnimation { velocity: 5 } }
    exit: Transition { SmoothedAnimation { velocity: 5 } }

    property double elevation: !interactive && !dim ? 0 : 16
    property color backgroundColor: MaterialStyle.dialogColor
    property color dividerColor: MaterialStyle.dividersColor()
    property color overlayColor: MaterialStyle.overlayColor

    background: Rectangle
    {
        color: control.backgroundColor

        Rectangle
        {
            readonly property bool horizontal: control.edge === Qt.LeftEdge || control.edge === Qt.RightEdge
            width: horizontal ? 1 : parent.width
            height: horizontal ? parent.height : 1
            color: control.dividerColor
            x: control.edge === Qt.LeftEdge ? parent.width - 1 : 0
            y: control.edge === Qt.TopEdge ? parent.height - 1 : 0
            visible: !control.dim && control.elevation === 0
        }

        layer.enabled: control.position > 0
        layer.effect: ElevationEffect
        {
            elevation: control.elevation
            fullHeight: true
        }
    } // Rectangle

    T.Overlay.modal: Rectangle
    {
        color: control.overlayColor
        Behavior on opacity { NumberAnimation { duration: 150 } }
    } // moal

    T.Overlay.modeless: Rectangle
    {
        color: control.overlayColor
        Behavior on opacity { NumberAnimation { duration: 150 } }
    } // modeless
} // Drawer
