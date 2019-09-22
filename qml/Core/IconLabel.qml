/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// MaterialHelper
import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Components 1.12

Item
{
    id: control
    property var icon: QtObject
    {
        property double width: 24
        property double height: width
        property string source: ""
        property color color: control.color
    }
    property alias text: _label.text
    property color color
    property alias font: _label.font
    property alias textType: _label.textType
    property bool mirrored: false
    property double spacing: 0
    property int elide: Text.ElideNone
    property alias alignment: _label.horizontalAlignment
    property bool alwaysRenderIcon: false

    readonly property double iconWidth: (_icon.visible ? icon.width : 0)
    readonly property double iconHeight: (_icon.visible ? icon.height : 0)

    readonly property double labelWidth: (_label.visible ? _label.contentWidth : 0)
    readonly property double labelHeight: (_label.visible ? _label.contentHeight : 0)

    implicitWidth: iconOnTop ? Math.max(iconWidth, labelWidth) :
                    iconWidth + labelWidth + spacing
    implicitHeight: iconOnTop ? iconHeight + labelHeight :
                    Math.max(iconHeight, labelHeight)

    property bool drawline: MaterialStyle.debug.drawDebugIconLabel

    // AbstractButton.IconOnly | AbstractButton.TextOnly | AbstractButton.TextBesideIcon | AbstractButton.TextUnderIcon
    property int display: AbstractButton.TextBesideIcon

    readonly property bool iconOnTop: display === AbstractButton.TextUnderIcon && _icon.visible

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "green"
        visible: control.drawline
    } // DebugRectangle

    Item
    {
        id: _iconItem
        width: control.icon.width
        height: control.icon.height
        visible: (control.display != AbstractButton.TextOnly) && ((_icon.source != "") || alwaysRenderIcon)
        ColorIcon
        {
            id: _icon
            source: control.icon.source
            width: control.icon.width
            height: control.icon.height
            iconSize: Math.max(width, height)
            color: control.icon.color

            anchors.centerIn: parent
        } // ColorIcon

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "orange"
            visible: control.drawline
        } // DebugRectangle

        //readonly property bool textOnLeft: !control.iconOnTop && control.mirrored && _label.visible
        //readonly property bool textOnRight: !control.iconOnTop && !control.mirrored && _label.visible

        function reanchors()
        {
            anchors.left = undefined
            anchors.right = undefined

            var textOnLeft = !control.iconOnTop && control.mirrored && ((control.display != AbstractButton.IconOnly) && _label.text != "")
            var textOnRight = !control.iconOnTop && !control.mirrored && ((control.display != AbstractButton.IconOnly) && _label.text != "")

            if((!textOnLeft && !control.iconOnTop) || control.iconOnTop)
                anchors.left = control.left

            if((!textOnRight && !control.iconOnTop) || control.iconOnTop)
                anchors.right = control.right

            anchors.verticalCenter = undefined
            anchors.top = undefined
            if(control.iconOnTop)
                anchors.top = control.top
            else
                anchors.verticalCenter = control.verticalCenter
        } // reanchors()

        //Component.onCompleted: reanchors()
    } // Item

    Label
    {
        id: _label
        color: control.color
        visible: (control.display != AbstractButton.IconOnly) && (text != "")
        elide: control.elide
        horizontalAlignment: Text.AlignHCenter

        readonly property bool iconOnLeft: !control.iconOnTop && !control.mirrored && _icon.visible
        readonly property bool iconOnRight: !control.iconOnTop && control.mirrored && _icon.visible

        anchors.left: iconOnLeft ? _iconItem.right : control.left
        anchors.right: iconOnRight ? _iconItem.left : control.right

        anchors.leftMargin: iconOnLeft ? control.spacing : control.anchors.leftMargin
        anchors.rightMargin: iconOnRight ? control.spacing : control.anchors.rightMargin
        anchors.baselineOffset: control.iconOnTop ? control.spacing : 0
        function reanchors()
        {
            anchors.verticalCenter = undefined
            anchors.baseline = undefined
            if(control.iconOnTop)
            {
                anchors.baseline = control.verticalCenter
            }
            else
                anchors.verticalCenter = control.verticalCenter
        } // reanchors()

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "red"
            visible: control.drawline
        } // DebugRectangle
    } // Label

    function reanchors()
    {
        _label.reanchors()
        _iconItem.reanchors()
    }

    Component.onCompleted: reanchors()
    onIconOnTopChanged: reanchors()
    onTextChanged: reanchors()

} // Control