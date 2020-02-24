/** Copyright (C) Olivier Le Doeuff 2020
 * Contact: olivier.ldff@gmail.com */

// Qt
import QtQuick 2.12

Item
{
    id: root

    width: 100
    height: 100
    clip: true

    // Width of the loaded item with a zoom of 1
    property real contentWidth: 100
    // Height of the loaded item with a zoom of 1
    property real contentHeight: 100

    // Item that will be resized inside the container.
    // Set contentWidth and contentHeight the width & height with zoom x1
    property alias contentItem: _loader.sourceComponent

    // Minimal zoom value (also default)
    property real minZoom: 1
    // Maximum zoom value to avoid zooming infinitely
    property real maxZoom: 10
    // Current zoom
    property real zoom: 1

    Flickable
    {
        id: _flickable

        readonly property real contentRatio: root.contentWidth/root.contentHeight

        width: Math.min(parent.width, contentWidth)
        height: Math.min(parent.height, contentHeight)

        // Always centered in parent
        anchors.centerIn: parent

        contentWidth: root.contentWidth*zoom
        contentHeight: root.contentHeight*zoom

        // Default zoom always fit entirely the loaded item inside the flickable
        readonly property real defaultZoom: contentRatio < 1 ? root.width/root.contentWidth : root.height/root.contentHeight
        property real zoom: defaultZoom*root.zoom

        // Remap minzoom with default zoom, because the loaded item can be bigger than the flickable by default
        readonly property real minZoom: defaultZoom*root.minZoom
        // Remap maxzoom with default zoom, because the loaded item can be bigger than the flickable by default
        readonly property real maxZoom: defaultZoom*root.maxZoom

        readonly property real unZoomLatency: 220
        readonly property real wheelZoomLatency: 150

        property real zoomLatency: 150
        property bool pinching

        Behavior on zoom
        {
            NumberAnimation { duration: _flickable.zoomLatency; easing.type: Easing.OutQuint }
            enabled: !_flickable.pinching
        }
        Behavior on contentX
        {
            NumberAnimation { duration: _flickable.zoomLatency; easing.type: Easing.OutQuint }
            enabled: !_flickable.pinching
        }
        Behavior on contentY
        {
            NumberAnimation { duration: _flickable.zoomLatency; easing.type: Easing.OutQuint }
            enabled: !_flickable.pinching
        }

        // The loader scale it's content size
        Loader
        {
            id:     _loader
            width:  _flickable.contentWidth
            height: _flickable.contentHeight
        } // Loader

        // Apply deltaZoom to zoom property with center zoomX & zoomY
        function zoomToPoint(deltaZoom, zoomX, zoomY)
        {
            const previousScale = _flickable.zoom
            let newScale = _flickable.zoom + deltaZoom

            // Bound scale
            if(newScale < _flickable.minZoom)
                newScale = _flickable.minZoom
            else if(newScale > _flickable.maxZoom)
                newScale = _flickable.maxZoom

            const scaleRatio = previousScale/newScale

            // Make sure center stay at center after scale
            _flickable.contentX += (zoomX/scaleRatio - zoomX)
            _flickable.contentY += (zoomY/scaleRatio - zoomY)

            // Update content scale
            _flickable.zoom = newScale
        } // zoomToPoint

        PinchArea
        {
            id: _pinchArea

            anchors.fill: parent

            property real zoomFactor

            onPinchStarted:
            {
                // Keep track of current zoom, because pinch.scale always start at 1.
                zoomFactor = _flickable.zoom
                // Disable property animation
                _flickable.pinching = true
            }
            onPinchUpdated:
            {
                // Get delta scale and apply zoom factor to it
                const deltaZoom = (pinch.scale-pinch.previousScale)*zoomFactor

                // Apply the zoom
                _flickable.zoomToPoint(deltaZoom, pinch.center.x, pinch.center.y)

                // Move the flickable if pinch center moved
                _flickable.contentX += pinch.previousCenter.x - pinch.center.x
                _flickable.contentY += pinch.previousCenter.y - pinch.center.y

            }
            onPinchFinished:
            {
                // Enable property animation
                _flickable.pinching = false
                // Then force the flickable to rebound. Order matter to have smooth reanchoring
                _flickable.returnToBounds()
            }

            // Handle
            // - double click to unzoom and zoom*2
            // - wheel to zoom
            MouseArea
            {
                anchors.fill: parent
                scrollGestureEnabled: false  // 2-finger-flick gesture should pass through to the Flickable
                onWheel:
                {
                    // Reset animation to fast because user know what he is doing
                    _flickable.zoomLatency = _flickable.wheelZoomLatency
                    // Zoom speed can be adjusted here. Maybe expose some property here ?
                    _flickable.zoomToPoint(_flickable.zoom * wheel.angleDelta.y / 120 / 10, wheel.x, wheel.y)
                    // Make sure _flickable is anchored properly after zoom
                    _flickable.returnToBounds()
                } // onWheel
                onDoubleClicked:
                {
                    // Reset animation speed to slow for user to understand better what's happening
                    _flickable.zoomLatency = _flickable.unZoomLatency
                    if(_flickable.zoom !== _flickable.defaultZoom)
                    {
                        _flickable.zoom = _flickable.defaultZoom
                        _flickable.contentX = 0
                        _flickable.contentY = 0
                    }
                    else
                    {
                        _flickable.zoomToPoint(_flickable.defaultZoom < 0.7 ? 1 : _flickable.defaultZoom*2, mouse.x, mouse.y)
                    }
                } // onDoubleClicked
            } // MouseArea
        } // PinchArea

        ScrollIndicator.vertical: root.ScrollIndicator.vertical
        ScrollIndicator.horizontal: root.ScrollIndicator.horizontal
    } // Flickable
} // Item