/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0

Item
{
    id: control
    implicitHeight: Math.max(_cardTitle.implicitHeight, _roundImage.implicitHeight) + topPadding + bottomPadding
    implicitWidth: _roundImage.implicitWidth + _cardTitle.implicitWidth + rightPadding + topPadding + spacing

    property alias headerText: _cardTitle.headerText
    property alias subHeaderText: _cardTitle.subHeaderText
    property alias thumbnail: _roundImage.source
    property double imageSize: MaterialStyle.card.roundImageSize
    property double spacing: MaterialStyle.card.roundImageSpacing
    property alias textSpacing: _cardTitle.spacing
    property bool mirrored: false

    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    readonly property bool imagePresent: _roundImage.source != ""

    property bool drawline: MaterialStyle.debug.drawDebugIconLabel

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "red"
        visible: control.drawline
        z: 10
    } // DebugRectangle

    CardTitle
    {
        id: _cardTitle
        anchors.right: control.mirrored && control.imagePresent ? _roundImage.left : control.right
        anchors.left: !control.imagePresent || control.mirrored ? control.left : _roundImage.right
        anchors.rightMargin: control.mirrored && control.imagePresent ? control.spacing : control.rightPadding
        anchors.leftMargin: !control.mirrored && control.imagePresent ? control.spacing : control.leftPadding
        onPrimary: control.onPrimary
        colorReversed: control.colorReversed
    } // CardTitle

    RoundImage
    {
        id: _roundImage
        width: imageSize
        height: imageSize
        anchors.rightMargin: control.mirrored ? control.rightPadding : 0
        anchors.leftMargin: control.mirrored ? 0 : control.leftPadding
        anchors.verticalCenter: parent.verticalCenter

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "blue"
            z: 5
            visible: control.drawline
        } // DebugRectangle

        function reanchors()
        {
            anchors.right = undefined
            anchors.left = undefined
            if(control.mirrored)
                anchors.right = control.right
            else
                anchors.left = control.left
        }
    } // RoundImage

    function reanchors()
    {
        _roundImage.reanchors()
    }

    onMirroredChanged: Qt.callLater(reanchors)
    Component.onCompleted: reanchors()
}
