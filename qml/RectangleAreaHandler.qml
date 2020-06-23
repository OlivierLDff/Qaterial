/**
 * Copyright (C) Olivier Le Doeuff 2020
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Dependencies
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  // Start point normalized
  property vector2d start: _start

  // End point normalized
  property vector2d end: _end

  // Implicit values updated when dragged (normalized)
  property vector2d _start: Qt.vector2d(0, 0)
  property vector2d _end: Qt.vector2d(1, 1)

  readonly property real realStartX: start.x*width
  readonly property real realStartY: start.y*height

  readonly property real realEndX: end.x*width
  readonly property real realEndY: end.y*height

  readonly property real realHandleSize: handleSize + margin*2
  readonly property real realHalfHandleSize: realHandleSize/2

  // Size of handle
  property int handleSize: 32
  property string hoveredRole: "hovered"
  property string horizontalRole: "horizontal"
  property Component handle: Rectangle
  {
    property bool hovered
    property real handleWidth: hovered ? root.handleHoveredWidth : root.handleWidth
    Behavior on handleWidth { NumberAnimation { duration: 100 } }

    width: root.handleSize
    height: root.handleSize
    radius: root.handleSize/2

    color: "transparent"
    border.color: root.handleColor
    border.width: handleWidth
  } // Rectangle
  property Component handleLinker: Item
  {
    property bool horizontal
    property bool hovered

    Rectangle
    {
      property real handleWidth: parent.hovered ? root.handleHoveredWidth : root.handleWidth
      Behavior on handleWidth { NumberAnimation { duration: 50 } }

      x: parent.horizontal ? root.handleSize/2 - handleWidth/2 : -width/2
      y: parent.horizontal ? -height/2 : root.handleSize/2 - handleWidth/2

      width: parent.horizontal ? parent.width - x -root.handleSize/2 + handleWidth/2 : handleWidth
      height: parent.horizontal ? handleWidth : parent.height -y -root.handleSize/2 + handleWidth/2

      color: root.handleColor
    } // Rectangle
  } // Item
  property color handleColor: Qaterial.Style.accentColor
  property real handleWidth: 2
  property real handleHoveredWidth: 4

  // Margin around
  property real margin: 16

  readonly property real pointerX: _hoverHandler.point.position.x
  readonly property real pointerY: _hoverHandler.point.position.y

  readonly property real pressedX: _draggedItem.x
  readonly property real pressedY: _draggedItem.y

  // Updated each time pressedX changed. Used to know delta x and drag operation
  property real lastPressedX
  // Updated each time pressedY changed. Used to know delta y and drag operation
  property real lastPressedY

  // Drag was pressed inside. If press outside, then no hovering animation until release
  property bool pressedInside
  property bool pressed: _dragHandler.active

  // press() function is a little bit delayed to make sure lastPressedX & lastPressedY are correct
  // This is necessary to avoid a bad update of containsMouse
  property bool _pressedHandled

  property bool topPressed
  property bool bottomPressed
  property bool leftPressed
  property bool rightPressed

  readonly property bool containsMouse:
  {
    if(!_hoverHandler.hovered)
      return false

    if(_pressedHandled && pressed && !pressedInside)
      return false

    const startX = realStartX - realHalfHandleSize
    const startY = realStartY - realHalfHandleSize

    const endX = realEndX + realHalfHandleSize
    const endY = realEndY + realHalfHandleSize

    return isContained(pointerX, pointerY, startX, startY, endX, endY)
  }

  readonly property bool containsMouseInsideHandle:
  {
    if(!containsMouse)
      return false

    const startX = realStartX + realHalfHandleSize
    const startY = realStartY + realHalfHandleSize

    const endX = realEndX - realHalfHandleSize
    const endY = realEndY - realHalfHandleSize

    return isContained(pointerX, pointerY, startX, startY, endX, endY)
  }

  readonly property bool topHovered: isHoveringHandle(realStartX, realStartY, realEndX, realStartY)
  readonly property bool bottomHovered: isHoveringHandle(realStartX, realEndY, realEndX, realEndY)
  readonly property bool leftHovered: isHoveringHandle(realStartX, realStartY, realStartX, realEndY)
  readonly property bool rightHovered: isHoveringHandle(realEndX, realStartY, realEndX, realEndY)

  function isHoveringHandle(startX, startY, endX, endY)
  {
    return containsMouse && isContained(pointerX,
      pointerY,
      startX - realHalfHandleSize,
      startY - realHalfHandleSize,
      endX + realHalfHandleSize,
      endY + realHalfHandleSize)
  }

  function isContained(pointerX, pointerY, startX, startY, endX, endY)
  {
    const xMatching = pointerX >= startX && pointerX <= endX
    const yMatching = pointerY >= startY && pointerY <= endY

    return xMatching && yMatching
  }

  function press()
  {
    const tempPressedInside = containsMouse
    if(tempPressedInside)
    {
      lastPressedX = pressedX
      lastPressedY = pressedY

      if(containsMouseInsideHandle)
      {
        topPressed = true
        bottomPressed = true
        leftPressed = true
        rightPressed = true
      }
      else
      {
        if(_dragHandler.translation.x > 0)
        {
          rightPressed = rightHovered
          leftPressed = leftHovered && !rightPressed
        }
        else
        {
          leftPressed = leftHovered
          rightPressed = rightHovered && !leftPressed
        }

        if(_dragHandler.translation.x > 0)
        {
          bottomPressed = bottomHovered
          topPressed = topHovered && !bottomPressed
        }
        else
        {
          topPressed = topHovered
          bottomPressed = bottomHovered && !topPressed
        }
      }
    }
    pressedInside = tempPressedInside
    _pressedHandled = true
  }

  function release()
  {
    pressedInside = false
    _pressedHandled = false

    topPressed = false
    bottomPressed = false
    leftPressed = false
    rightPressed = false
  }

  onPressedChanged: function()
  {
    if(pressed)
      Qt.callLater(press)
    else
      Qt.callLater(release)
  }

  function drag()
  {
    if(!pressed || !pressedInside)
      return

    // Normalize
    const normalizedFromX = lastPressedX/root.width
    const normalizedToX = pressedX/root.width
    const deltaX = normalizedToX - normalizedFromX

    const normalizedFromY = lastPressedY/root.height
    const normalizedToY = pressedY/root.height
    const deltaY = normalizedToY - normalizedFromY

    let currentStart = Qt.vector2d(root.start.x, root.start.y)
    let currentEnd = Qt.vector2d(root.end.x, root.end.y)

    // Apply delta to temp value, make sure they are not overlaping
    if(topPressed)
    {
      if(root.start.y + deltaY > root.end.y)
        currentStart.y = root.end.y
      else
        currentStart.y += deltaY
    }
    if(bottomPressed)
    {
      if(root.end.y + deltaY < root.start.y)
        currentEnd.y = root.start.y
      else
        currentEnd.y += deltaY
    }

    if(leftPressed)
    {
      if(root.start.x + deltaX > root.end.x)
        currentStart.x = root.end.x
      else
        currentStart.x += deltaX
    }
    if(rightPressed)
    {
      if(root.end.x + deltaX < root.start.x)
        currentEnd.x = root.start.x
      else
        currentEnd.x += deltaX
    }
    // Clamp all values
    currentStart.x = Math.min(Math.max(currentStart.x, 0), 1)
    currentStart.y = Math.min(Math.max(currentStart.y, 0), 1)
    currentEnd.x = Math.min(Math.max(currentEnd.x, 0), 1)
    currentEnd.y = Math.min(Math.max(currentEnd.y, 0), 1)

    // Keep track of pressed point to measure delta
    lastPressedX = pressedX
    lastPressedY = pressedY

    _start = currentStart
    _end = currentEnd
  }

  onPressedXChanged: () => drag()
  onPressedYChanged: () => drag()

  Binding on start
  {
    when: root.pressed
    value: root._start
  }

  Binding on end
  {
    when: root.pressed
    value: root._end
  }

  // Repeat handles linker
  Repeater
  {
    id: _handleLinkerRepeater
    model: 4
    delegate: Loader
    {
      id: _handleLinkerLoader
      readonly property bool horizontal: index%2 === 0

      Binding
      {
        target: item
        when: item && item.hasOwnProperty(root.horizontalRole)
        property: root.horizontalRole
        value: _handleLinkerLoader.horizontal
      }

      readonly property bool hovered:
      {
        if(!root.containsMouse)
          return false

        if(root.containsMouseInsideHandle)
          return true

        switch(index)
        {
          case 0: return root.topHovered
          case 1: return root.rightHovered
          case 2: return root.bottomHovered
          case 3: return root.leftHovered
        }
      }

      Binding
      {
        target: item
        when: item && item.hasOwnProperty(root.hoveredRole)
        property: root.hoveredRole
        value: _handleLinkerLoader.hovered
      }

      readonly property real realStartX: index === 1 ? root.realEndX : root.realStartX
      readonly property real realStartY: index === 2 ? root.realEndY : root.realStartY

      readonly property real realEndX: index === 3 ? root.realStartX : root.realEndX
      readonly property real realEndY: index === 0 ? root.realStartY : root.realEndY

      x: realStartX
      y: realStartY

      // in vertical the loader is width is the content item width
      width: horizontal ? realEndX - x : undefined
      // in horizontal the loader is height is the content item height
      height: horizontal ? undefined : realEndY - y

      sourceComponent: root.handleLinker
    } // Loader
  } // Repeater

  // Repeat handles
  Repeater
  {
    id: _handleRepeater
    model: 4
    delegate: Loader
    {
      id: _handleLoader

      readonly property real realX: index === 1 || index === 2 ? root.realEndX : root.realStartX
      readonly property real realY: index === 0 || index === 1 ? root.realStartY : root.realEndY

      x: realX - width/2
      y: realY - height/2

      readonly property bool hovered:
      {
        if(root.containsMouseInsideHandle)
          return true

        switch(index)
        {
          case 0: return root.topHovered || root.leftHovered
          case 1: return root.topHovered || root.rightHovered
          case 2: return root.bottomHovered || root.rightHovered
          case 3: return root.bottomHovered || root.leftHovered
        }
      }

      Binding
      {
        target: item
        when: item && item.hasOwnProperty(root.hoveredRole)
        property: root.hoveredRole
        value: _handleLoader.hovered
      }

      sourceComponent: root.handle
    } // Loader
  } // Repeater

  // Hover handler used to detect hover over handle and handleLinker
  HoverHandler { id: _hoverHandler }

  // Dummy item that can be dragged with _dragHandler
  // It's x, y properties are replicated in root to react to drag movement
  Item { id: _draggedItem }

  // Drag _draggedItem
  DragHandler
  {
    id: _dragHandler
    target: _draggedItem
    //dragThreshold: root.handleHoveredWidth/2 // todo : enable when upgrading to qt 5.15
  }

  Component.onCompleted: function()
  {
    // Make sure if user override start/end that we have the correct start/end
    if(_start != start)
      _start = Qt.vector2d(start.x, start.y)
    if(_end != end)
      _end = Qt.vector2d(end.x, end.y)
  }
} // Item