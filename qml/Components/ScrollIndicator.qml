/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T

import QQuickMaterialHelper.Style 1.12

T.ScrollIndicator 
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 2

    contentItem: Rectangle 
    {
        implicitWidth: 4
        implicitHeight: 4
        radius: 2

        color: MaterialStyle.hintTextColor()
        visible: control.size < 1.0
        opacity: 0.0

        states: State 
        {
            name: "active"
            when: control.active
            PropertyChanges { target: control.contentItem; opacity: 0.75 }
        } // Transition

        transitions: 
        [
            Transition 
            {
                from: "active"
                SequentialAnimation 
                {
                    PauseAnimation { duration: 450 }
                    NumberAnimation { target: control.contentItem; duration: 200; property: "opacity"; to: 0.0 }
                } // SequentialAnimation
            } // Transition
        ] // transitions
    } // Rectangle
} // ScrollIndicator
