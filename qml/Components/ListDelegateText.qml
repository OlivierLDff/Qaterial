/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

Rectangle 
{
    id: control

    property alias text: _text.text
    property alias overlineText: _overline.text
    property alias secondaryText: _info.text

    property bool alignTextRight: false
    property bool drawline: false
    property bool enabled: true
    property bool mirrored: false

    property double padding
    property double leftPadding: padding
    property double rightPadding: padding
    property double topPadding: padding
    property double bottomPadding: padding

    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    readonly property int lines: (secondaryText != "" ? _info.lineCount : 0) + 1
    property int elide: mirrored ? Text.ElideLeft : Text.ElideRight
    property int textAligment: mirrored ? alignTextRight ? Text.AlignLeft : Text.AlignRight : alignTextRight ? Text.AlignRight : Text.AlignLeft
    
    DebugRectangle
    {
        anchors.fill: parent
        border.color: "red"
        visible: control.drawline
    } // DebugRectangle

    // MaterialStyle.DelegateType.Default | MaterialStyle.DelegateType.Overline | MaterialStyle.DelegateType.Icon
    // MaterialStyle.DelegateType.Round | MaterialStyle.DelegateType.Square | MaterialStyle.DelegateType.Large
    property int type: MaterialStyle.DelegateType.Default

    color: "transparent"
    implicitHeight: _info.visible ? (_info.y + _info.implicitHeight) : (_text.implicitHeight)
    //implicitWidth: 180
    implicitWidth: Math.max(_overline.implicitWidth, _text.implicitWidth, _info.implicitWidth)

    function reanchors()
    {
        _text.reanchors()
    }

    onMirroredChanged: reanchors()
    onTypeChanged: reanchors()
    Component.onCompleted: reanchors()

    Label
    {
        id: _overline
        visible : text != ""
        enabled: control.enabled
        textType: MaterialStyle.TextType.Overline
        elide: control.elide
        onPrimary: control.onPrimary
        colorReversed: control.colorReversed

        horizontalAlignment: control.textAligment

        anchors.baseline: control.top
        anchors.baselineOffset: MaterialStyle.delegate.baselineOffsetOverline(control.lines)
        anchors.left: control.left
        anchors.right: control.right
        anchors.leftMargin: control.leftPadding
        anchors.rightMargin: control.rightPadding

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "orange"
            visible: control.drawline
        } // DebugRectangle
    } // Label

    Label
    {
        id: _text
        visible : text != ""
        enabled: control.enabled
        textType: MaterialStyle.TextType.ListText
        elide: control.elide
        onPrimary: control.onPrimary
        colorReversed: control.colorReversed

        horizontalAlignment: control.textAligment

        readonly property bool centerBaseline: control.secondaryText != "" || control.overlineText != ""

        anchors.verticalCenter: control.verticalCenter
        anchors.baselineOffset: centerBaseline ? MaterialStyle.delegate.baselineOffsetText(control.type, control.lines) : 0
        anchors.left: control.left
        anchors.right: control.right
        anchors.leftMargin: control.leftPadding
        anchors.rightMargin: control.rightPadding

        function reanchors()
        {
            anchors.baseline = undefined
            anchors.verticalCenter = undefined

            if(centerBaseline)
                anchors.baseline = control.top
            else
                anchors.verticalCenter = control.verticalCenter
        }

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "orange"
            visible: control.drawline
        } // DebugRectangle
    } // Label

    Label
    {
        id: _info
        visible : text != ""
        enabled: control.enabled
        textType: MaterialStyle.TextType.ListSecText
        elide: control.elide
        maximumLineCount: 2
        onPrimary: control.onPrimary
        colorReversed: control.colorReversed

        wrapMode: Text.WordWrap
        horizontalAlignment: control.textAligment

        anchors.baseline: control.top
        anchors.baselineOffset: MaterialStyle.delegate.baselineOffsetSecText(control.type, lineCount + 1)

        anchors.left: control.left
        anchors.right: control.right
        anchors.leftMargin: control.leftPadding
        anchors.rightMargin: control.rightPadding

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "orange"
            visible: control.drawline
        } // DebugRectangle
    } // Label

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "red"
        visible: control.drawline
    } // DebugRectangle
} // Rectangle