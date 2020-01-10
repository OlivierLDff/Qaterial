/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Backend
import Qaterial 1.0 as Qaterial

Rectangle
{
    id: root
    color: "#202020"
    border.width: 1
    border.color: "#101010"
    width: parent.width
    height: _mainColumn.height

    property string title: ""
    property alias content: _loader.sourceComponent
    property bool expanded: false

    Item
    {
        id: _mainColumn
        height: _header.height + _expandableRect.height
        Rectangle
        {
            id: _header

            width: root.width
            height: 30
            color: "#101010"

            Qaterial.AppBarButton
            {
                id: _expandButton
                icon.source: root.expanded ? "qrc:///Qaterial/Images/menu-down.svg" : "qrc:///Qaterial/Images/menu-right.svg"
                backgroundImplicitWidth: Qaterial.Style.dense ? 12 : 16
                backgroundImplicitHeight: Qaterial.Style.dense ? 12 : 16
                leftPadding: 0
                rightPadding: 0
                anchors.verticalCenter: parent.verticalCenter

                onClicked: root.expanded = !root.expanded
            } // AppBarButton

            Qaterial.Label
            {
                text: root.title
                textType: Qaterial.Style.TextType.Body2
                anchors.verticalCenter: parent.verticalCenter
                x: 4 + _expandButton.implicitWidth
                width: parent.width - 4 - _expandButton.width
                elide: Text.ElideRight
            } // Label
        }

        Item
        {
            id: _expandableRect
            clip: true
            y: _header.height
            height: root.expanded && _loader.item ? _loader.item.height : 0
            width: root.width

            //Behavior on height { NumberAnimation { duration: 200 } }

            Loader
            {
                id: _loader
                x: 8
                width: _expandableRect.width - 8
                active: root.expanded
                //anchors.bottom: parent.bottom
            }
        }

    } // Column
} // Frame
