import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Style 1.12

Item
{
    id: control
    property var icon: QtObject
    {
        property double width: 24
        property double height: width
        property string source: ""
    }
    property alias text: _label.text
    property color color
    property alias font: _label.font
    property bool mirrored: false
    property double spacing: 0
    property int elide: Text.ElideNone

    readonly property bool iconVisible: display != AbstractButton.TextOnly
    readonly property bool labelVisible: display != AbstractButton.IconOnly

    readonly property double iconWidth: (iconVisible ? icon.width : 0)
    readonly property double iconHeight: (iconVisible ? icon.height : 0)

    readonly property double labelWidth: (labelVisible ? _label.contentWidth : 0)
    readonly property double labelHeight: (labelVisible ? _label.contentHeight : 0)

    implicitWidth: iconWidth + labelWidth + (labelVisible ? spacing : 0)
    implicitHeight: Math.max(iconHeight, labelHeight) 

    property bool drawline: MaterialStyle.debug.drawDebugIconLabel

    // AbstractButton.IconOnly | AbstractButton.TextOnly | AbstractButton.TextBesideIcon | AbstractButton.TextUnderIcon
    property int display: AbstractButton.TextBesideIcon

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "green"
        visible: control.drawline
    }

    Item
    {
        id: _iconItem
        width: control.icon.width
        height: control.icon.height
        ColorIcon
        {
            id: _icon
            source: control.icon.source
            width: control.icon.width
            height: control.icon.height
            color: control.color

            anchors.centerIn: parent        
        }

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "red"
            visible: control.drawline
        }

        anchors.verticalCenter: control.verticalCenter
        anchors.right: control.mirrored ? control.right : undefined
        anchors.left: !control.mirrored ? control.left : undefined
    }

    Label
    {
        id: _label
        color: control.color
        elide: control.elide
        visible: width > 0
        clip: true

        anchors.left: !mirrored ? _iconItem.right : control.left
        anchors.right: mirrored ? _iconItem.left : control.right 

        anchors.leftMargin: !mirrored ? control.spacing : 0
        anchors.rightMargin: mirrored ? control.spacing : 0
        anchors.verticalCenter: control.verticalCenter

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "red"
            visible: control.drawline
        }
    }
} // Control