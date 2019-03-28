/** Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

T.Dialog 
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding,
                            implicitHeaderWidth,
                            implicitFooterWidth)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding
                             + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                             + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

    padding: MaterialStyle.dialog.horizontalPadding
    topPadding: MaterialStyle.dialog.topPadding + (drawSeparator ? 1 : 0)
    bottomPadding: (drawSeparator ? 1 : (MaterialStyle.dialog.horizontalPadding + 1))

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

    property double elevation: MaterialStyle.dialog.elevation
    property color backgroundColor: MaterialStyle.dialogColor
    property bool drawSeparator: false

    background: Rectangle 
    {
        radius: MaterialStyle.dialog.radius
        color: MaterialStyle.dialogColor

        layer.enabled: control.elevation > 0
        layer.effect: ElevationEffect 
        {
            elevation: control.elevation
        } // ElevationEffect

        HorizontalLineSeparator
        {
            visible: control.drawSeparator && header.visible
            //anchors.top: header.bottom
            //anchors.topMargin: control.topPadding
            anchors.horizontalCenter: parent.horizontalCenter
            implicitWidth: control.width
            y: control.header.height + control.topPadding - height
        }

        HorizontalLineSeparator
        {
            visible: control.drawSeparator && footer.visible
            y: control.height - footer.height - control.bottomPadding
            //anchors.bottom: footer.top
            //anchors.bottomMargin: control.bottomPadding
            anchors.horizontalCenter: parent.horizontalCenter
            implicitWidth: control.width
        }

    } // Rectangle

    header: Label 
    {
        text: control.title
        visible: control.title
        elide: Label.ElideRight
        padding: MaterialStyle.dialog.horizontalPadding
        bottomPadding: 0
        textType: MaterialStyle.TextType.Title
        background: Rectangle 
        {
            radius: MaterialStyle.dialog.radius
            color: control.backgroundColor
            //clip: true
        }
    }

    footer: DialogButtonBox 
    {
        visible: count > 0
        backgroundColor: control.backgroundColor
    } // DialogButtonBox

    T.Overlay.modal: Rectangle 
    {
        color: MaterialStyle.overlayColor
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }

    T.Overlay.modeless: Rectangle 
    {
        color: MaterialStyle.overlayColor
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }
} // Dialog
