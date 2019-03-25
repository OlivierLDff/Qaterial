/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

Pane 
{
    id: control

    // TEXT
    property string text

    // THUMBNAIL
    property alias thumbnailSource: _roundImage.source

    // ACTION
    property alias action: _action1.text
    property alias action1: _action1.text
    property alias action2: _action2.text
    signal actionClicked()
    signal action1Clicked()
    signal action2Clicked()

    // ICON
    property alias iconSource: _roundIcon.source
    property alias fillIcon: _roundIcon.fill
    property alias outlinedIcon: _roundIcon.outlined
    property alias highlightedIcon: _roundIcon.highlighted
    property alias reverseHighlightIcon: _roundIcon.reverseHighlight
    property alias iconColor: _roundIcon.color
    property alias backgroundColor: _roundIcon.roundColor

    // SEPARATOR
    property bool drawSeparator: false

    padding: 0
    //topPadding: mobileOrientation && displaySmallText ? 2 : 0
    bottomPadding: (control.drawSeparator ? 1 : 0)

    property bool mobileOrientation: (width < MaterialStyle.banner.mobileMaxWidth)
    property bool drawline: MaterialStyle.debug.drawDebugDelegate

    contentItem: Item
    {
        id: _content
        implicitWidth:  MaterialStyle.banner.minimumWidth
        implicitHeight: MaterialStyle.banner.implicitHeight1Line

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "pink"
            visible: control.drawline
        }

        readonly property bool displaySmallText: (((_action2.text == "" && _action1.text != "") || (_action2.text != "" && _action1.text == "")) && _smallLabel.contentWidth < _smallLabel.width)

        readonly property bool useSmallText: control.mobileOrientation ? _content.displaySmallText : true

        readonly property int lineCount: useSmallText ? _smallLabel.lineCount : _medLabel.lineCount

        readonly property bool thumbnailVisible: _roundIcon.source != "" || _roundImage.source != ""

        onThumbnailVisibleChanged: Qt.callLater(reanchors)
        onUseSmallTextChanged: Qt.callLater(reanchors)
        onLineCountChanged: Qt.callLater(reanchors)
        Component.onCompleted: Qt.callLater(reanchors)

        function reanchors()
        {
            var mobileImplicitHeight = (_medLabel.lineCount === 2 || _medLabel.visible) ? (thumbnailVisible ? MaterialStyle.banner.implicitHeightThumb : MaterialStyle.banner.implicitHeight2Line) : MaterialStyle.banner.implicitHeight1Line

            var desktopImplicitHeight = _smallLabel.lineCount === 3 ? MaterialStyle.banner.implicitHeight3LineDesk :  _smallLabel.lineCount === 2 ? MaterialStyle.banner.implicitHeight2LineDesk : MaterialStyle.banner.implicitHeight1LineDesk

            implicitHeight = (control.mobileOrientation ? mobileImplicitHeight : desktopImplicitHeight)
            _thumbnail.reanchors()
            _actionRow.reanchors()
        }

        Item
        {            
            id: _thumbnail
            width: MaterialStyle.roundIcon.size
            height: MaterialStyle.roundIcon.size
            visible: parent.thumbnailVisible
            RoundColorIcon
            {
                id: _roundIcon
                fill: true
                outlined: false
                highlighted: true
                reverseHighlight: true
                visible: source != ""
                width: parent.width
                height: parent.height
                enabled: control.enabled
            }
            RoundImage
            {
                id: _roundImage
                width: parent.width
                height: parent.height
                visible: source != "" && !_roundIcon.visible
            }
            anchors.left: _content.left
            anchors.leftMargin: MaterialStyle.card.horizontalPadding

            function reanchors()
            {
                anchors.top = undefined
                anchors.verticalCenter = undefined
                if((_smallLabel.lineCount === 1 && !_medLabel.visible))
                    anchors.verticalCenter = _content.verticalCenter
                else
                    anchors.top = _smallLabel.visible ? _smallLabel.top : _medLabel.top
            }
        }

        Label // Label when there is only one action or in desktop mode
        {
            id: _smallLabel
            visible: parent.useSmallText
            text: control.text
            anchors.verticalCenter: _content.verticalCenter
            anchors.left: _thumbnail.visible ? _thumbnail.right : _content.left
            anchors.leftMargin: MaterialStyle.card.horizontalPadding
            anchors.right: _actionRow.left
            anchors.rightMargin: control.mobileOrientation ? (MaterialStyle.banner.smallTextPadding) : MaterialStyle.banner.smallTextPaddingDesktop
            maximumLineCount: control.mobileOrientation ? 1 : 3
            wrapMode: control.mobileOrientation ? Text.NoWrap : Text.WordWrap
            elide: control.mobileOrientation ? Text.ElideNone : Text.ElideRight

            DebugRectangle
            {
                anchors.fill: parent
                border.color: "red"
                visible: control.drawline
            }
        } // Label

        Label // Label when there is2 action
        {
            id: _medLabel
            visible: !_smallLabel.visible
            text: control.text
            anchors.left: _thumbnail.visible ? _thumbnail.right : _content.left
            anchors.leftMargin: MaterialStyle.card.horizontalPadding
            anchors.right: _content.right
            anchors.rightMargin: MaterialStyle.card.horizontalPadding
            anchors.top: _content.top
            anchors.topMargin: MaterialStyle.card.horizontalPadding + (_thumbnail.visible ? MaterialStyle.card.verticalPadding : 0)
            maximumLineCount: 2
            wrapMode: Text.WordWrap
            elide: Text.ElideRight
        } // Label

        Row // Action button row
        {
            id: _actionRow
            FlatButton
            {
                id: _action1
                visible: text != ""
                anchors.verticalCenter: parent.verticalCenter
                onClicked:
                {
                    control.actionClicked()
                    control.action1Clicked()
                }
            } // FlatButton

            FlatButton
            {
                id: _action2
                visible: text != ""
                anchors.verticalCenter: parent.verticalCenter
                onClicked:
                {
                    control.action2Clicked()
                }
            } // FlatButton

            anchors.right: _content.right
            anchors.bottomMargin: 2
            anchors.rightMargin: 4

            function reanchors()
            {
                anchors.bottom = undefined
                anchors.verticalCenter = undefined
                if(_smallLabel.lineCount === 1 && !_medLabel.visible)
                    anchors.verticalCenter = _content.verticalCenter
                else
                    anchors.bottom = _content.bottom
            }

        } // Row

        Rectangle // Bottom divider (optionnal)
        {
            height: 1
            width: control.width
            visible: control.drawSeparator
            anchors.top: _content.bottom
            //anchors.bottomMargin: -1
            z: 10
            color: control.colorReversed ? MaterialStyle.dividersColorReversed() : MaterialStyle.dividersColor()
        }
    }
} // Pane
