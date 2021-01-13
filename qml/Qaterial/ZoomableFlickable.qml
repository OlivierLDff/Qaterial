/** Copyright (C) Olivier Le Doeuff 2020
 * Contact: olivier.ldff@gmail.com */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
//import Qaterial 1.0 as Qaterial

Item
{
  id: _root

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
  // Normalized Current zoom. 1 mean the whole image can be seen
  property real zoom: 1
  // Normalized zoom center x (beetween 0 and 1)
  property alias contentX: _flickable.contentX
  // Normalized zoom center y (beetween 0 and 1)
  property alias contentY: _flickable.contentY

  // Enable behavior on _flickable zoom/contentX/contentY
  property bool zoomAnimation: true
  property bool interactive: true
  property bool pinched: false

  property
  var verticalScrollIndicator: null
  property
  var horizontalScrollIndicator: null

  function cancelFlick()
  {
    _flickable.cancelFlick()
  } // function cancelFlick()

  function flick(xVelocity, yVelocity)
  {
    _flickable.flick(xVelocity, yVelocity)
  } // function flick(xVelocity, yVelocity)

  function returnToBounds()
  {
    _flickable.returnToBounds()
  } // function returnToBounds()

  function isXOutsideLeft(value)
  {
    return value < _flickable.contentX &&
      _flickable.contentX > 0
  } // function isXOutsideLeft(value)

  function isXOutsideRight(value)
  {
    return value > (_flickable.contentX + _flickable.width) &&
      (_flickable.contentX + _flickable.width) < _flickable.contentWidth
  } // function isXOutsideRight(value)

  function isYOutsideTop(value)
  {
    return value < _flickable.contentY &&
      _flickable.contentY > 0
  } // function isYOutsideTop(value)

  function isYOutsideBottom(value)
  {
    return value > (_flickable.contentY + _flickable.height) &&
      (_flickable.contentY + _flickable.height) < _flickable.contentHeight
  } // function isYOutsideBottom(value)

  signal flickEnded()
  signal flickStarted()
  signal movementEnded()
  signal movementStarted()

  Flickable
  {
    id: _flickable

    readonly property real contentRatio: _root.contentWidth / _root.contentHeight

    width: Math.min(parent.width, contentWidth)
    height: Math.min(parent.height, contentHeight)

    // Always centered in parent
    anchors.centerIn: parent

    contentWidth: _root.contentWidth * zoom
    contentHeight: _root.contentHeight * zoom

    // Default zoom always fit entirely the loaded item inside the flickable
    readonly property real defaultZoom: contentRatio < 1 ? _root.width / _root.contentWidth : _root.height / _root
      .contentHeight
    property real zoom: defaultZoom * _root.zoom

    // Remap minzoom with default zoom, because the loaded item can be bigger than the flickable by default
    readonly property real minZoom: defaultZoom * _root.minZoom
    // Remap maxzoom with default zoom, because the loaded item can be bigger than the flickable by default
    readonly property real maxZoom: defaultZoom * _root.maxZoom

    readonly property real unZoomLatency: 220
    readonly property real wheelZoomLatency: 150

    property real zoomLatency: 150
    property bool pinched

    readonly property bool zoomAnimation: _root.zoomAnimation && !_root.pinched

    //contentX:
    //contentY:

    interactive: _root.interactive // && _root.zoom > 1

    Behavior on zoom
    {
      NumberAnimation { duration: _flickable.zoomLatency;easing.type: Easing.OutQuint } // NumberAnimation
      enabled: _flickable.zoomAnimation
    } // Behavior

    Behavior on contentX
    {
      NumberAnimation { duration: _flickable.zoomLatency;easing.type: Easing.OutQuint } // NumberAnimation
      enabled: _flickable.zoomAnimation
    } // Behavior

    Behavior on contentY
    {
      NumberAnimation { duration: _flickable.zoomLatency;easing.type: Easing.OutQuint } // NumberAnimation
      enabled: _flickable.zoomAnimation
    } // Behavior

    onFlickEnded: _root.flickEnded()
    onFlickStarted: _root.flickStarted()
    onMovementEnded: _root.movementEnded()
    onMovementStarted: _root.movementStarted()

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

      const scaleRatio = newScale / previousScale

      // Make sure center stay at center after scale
      _flickable.contentX += (zoomX * scaleRatio - zoomX)
      _flickable.contentY += (zoomY * scaleRatio - zoomY)

      // Update content scale
      //_flickable.zoom = newScale
      _root.zoom = newScale / defaultZoom
    } // function zoomToPoint(deltaZoom, zoomX, zoomY)

    PinchArea
    {
      id: _pinchArea

      property real zoomFactor

      anchors.fill: parent
      enabled: _root.interactive

      onPinchStarted:
      {
        // Keep track of current zoom, because pinch.scale always start at 1.
        zoomFactor = _flickable.zoom
        // Disable property animation
        _root.pinched = true
      }

      onPinchUpdated:
      {
        // Get delta scale and apply zoom factor to it
        const deltaZoom = (pinch.scale - pinch.previousScale) * zoomFactor

        // Apply the zoom
        _flickable.zoomToPoint(deltaZoom, pinch.center.x, pinch.center.y)

        // Move the flickable if pinch center moved
        _flickable.contentX += pinch.previousCenter.x - pinch.center.x
        _flickable.contentY += pinch.previousCenter.y - pinch.center.y
      }

      onPinchFinished:
      {
        // Enable property animation
        _root.pinched = false
        // Then force the flickable to rebound. Order matter to have smooth reanchoring
        _flickable.returnToBounds()
      }

      // todo : replace by wheel handler when qt 5.15 will become LTS https://doc.qt.io/qt-5/qml-qtquick-wheelhandler.html
      // Handle:
      // - double click to unzoom and zoom*2
      // - wheel to zoom
      // Mouse Area is inside a loader because when a dragHandler is on top of mouse area
      // it stay pressed for no reason.
      // The mouse area get rebuilt each time it because interactive.
      // It the only i found to mimic a "reset" function or "unpress"
      Loader
      {
        anchors.fill: parent
        active: _root.interactive
        sourceComponent: MouseArea
        {
          scrollGestureEnabled: false // 2-finger-flick gesture should passs through to the Flickable
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
              _root.zoom = 1 //1/_flickable.defaultZoom
              _flickable.contentX = 0
              _flickable.contentY = 0
            }
            else
            {
              _flickable.zoomToPoint(_flickable.defaultZoom < 0.7 ? 1 : _flickable.defaultZoom * 2, mouse.x, mouse.y)
            }
          } // onDoubleClicked

          //onPressed: console.log("pressed")
          //onReleased: console.log("released")
        } // MouseArea
      } // Loader
    } // PinchArea

    ScrollIndicator.vertical: _root.verticalScrollIndicator
    ScrollIndicator.horizontal: _root.horizontalScrollIndicator

    // The loader scale it's content size
    Loader
    {
      id: _loader
      width: _flickable.contentWidth
      height: _flickable.contentHeight
    } // Loader
  } // Flickable

  /*Rectangle
  {
    color: "transparent"
    border.width: 1
    border.color: "red"
    anchors.fill: parent
  } // Rectangle

  Rectangle
  {
    color: "transparent"
    border.width: 1
    border.color: "green"
    anchors.fill: _flickable
  } // Rectangle

  Column
  {
    Qaterial.Label
    {
      text: "contentRatio " + _flickable.contentRatio
    } // Label
    Qaterial.Label
    {
      text: "contentWidth " + _flickable.contentWidth
    } // Label
    Qaterial.Label
    {
      text: "contentHeight " + _flickable.contentHeight
    } // Label
    Qaterial.Label
    {
      text: "width " + _flickable.width
    } // Label
    Qaterial.Label
    {
      text: "height " + _flickable.height
    } // Label
    Qaterial.Label
    {
      text: "zoom " + _flickable.zoom
    } // Label
    Qaterial.Label
    {
      text: "zoom " + _root.zoom
    } // Label
  } // Column */
} // Item
