/**
 * Copyright (C) Olivier Le Doeuff 2020
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.15
import QtQml 2.15

// Dependencies
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  // Start point normalized
  property vector2d start: _start

  // End point normalized
  property vector2d end: _end

  property vector2d minSize

  property bool reverseAllowed: true
  property bool horizontalReverseAllowed: reverseAllowed
  property bool verticalReverseAllowed: reverseAllowed

  // Margin inside and outside handle
  property real inMargin: Qaterial.Style.card.verticalPadding
  property real outMargin: Qaterial.Style.card.horizontalPadding

  // Implicit values updated when dragged (normalized)
  property vector2d _start: Qt.vector2d(0, 0)
  property vector2d _end: Qt.vector2d(1, 1)

  readonly property real realStartX: start.x * width
  readonly property real realStartY: start.y * height

  readonly property real realEndX: end.x * width
  readonly property real realEndY: end.y * height

  readonly property real outHalfHandleSize: handleSize / 2 + outMargin
  readonly property real inHalfHandleSize: handleSize / 2 + inMargin
  readonly property real halfHandleSize: handleSize / 2

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
    radius: root.handleSize / 2

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

      x: parent.horizontal ? root.handleSize / 2 - handleWidth / 2 : -width / 2
      y: parent.horizontal ? -height / 2 : root.handleSize / 2 - handleWidth / 2

      width: parent.horizontal ? parent.width - x - root.handleSize / 2 + handleWidth / 2 : handleWidth
      height: parent.horizontal ? handleWidth : parent.height - y - root.handleSize / 2 + handleWidth / 2

      color: root.handleColor
    } // Rectangle
  } // Item
  property color handleColor: Qaterial.Style.accentColor
  property real handleWidth: 2
  property real handleHoveredWidth: 4

  // Emitted each time the user is moving the area
  signal moved(vector2d start, vector2d end)

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

    const startX = realStartX - outHalfHandleSize
    const startY = realStartY - outHalfHandleSize

    const endX = realEndX + outHalfHandleSize
    const endY = realEndY + outHalfHandleSize

    return isContained(pointerX, pointerY, startX, startY, endX, endY)
  }

  readonly property bool containsMouseInsideHandle:
  {
    if(!containsMouse)
      return false

    const startX = realStartX + inHalfHandleSize
    const startY = realStartY + inHalfHandleSize
    const endX = realEndX - inHalfHandleSize
    const endY = realEndY - inHalfHandleSize

    // in margin still a thing
    if(startX <= endX && startY <= endY)
      return isContained(pointerX, pointerY, startX, startY, endX, endY)

    const inMarginStartX = realStartX + halfHandleSize
    const inMarginStartY = realStartY + halfHandleSize
    const inMarginEndX = realEndX - halfHandleSize
    const inMarginEndY = realEndY - halfHandleSize

    // handle size still a thing
    if(inMarginStartX <= inMarginEndX && inMarginStartY <= inMarginEndY)
      return isContained(pointerX, pointerY, inMarginStartX, inMarginStartY, inMarginEndX, inMarginEndY)

    // Inside start/end
    return isContained(pointerX, pointerY, realStartX, realStartY, realEndX, realEndY)
  }

  readonly property bool topHovered: isHoveringHandle(
    realStartX - outHalfHandleSize,
    realStartY - outHalfHandleSize,
    realEndX + outHalfHandleSize,
    realStartY + inHalfHandleSize)

  readonly property bool bottomHovered: isHoveringHandle(
    realStartX - outHalfHandleSize,
    realEndY - inHalfHandleSize,
    realEndX + outHalfHandleSize,
    realEndY + outHalfHandleSize)

  readonly property bool leftHovered: isHoveringHandle(
    realStartX - outHalfHandleSize,
    realStartY - outHalfHandleSize,
    realStartX + inHalfHandleSize,
    realEndY + outHalfHandleSize)

  readonly property bool rightHovered: isHoveringHandle(
    realEndX - inHalfHandleSize,
    realStartY - outHalfHandleSize,
    realEndX + outHalfHandleSize,
    realEndY + outHalfHandleSize)

  readonly property bool topHoveredOut: isHoveringHandle(
    realStartX - outHalfHandleSize,
    realStartY - outHalfHandleSize,
    realEndX + outHalfHandleSize,
    realStartY)

  readonly property bool bottomHoveredOut: isHoveringHandle(
    realStartX - outHalfHandleSize,
    realEndY,
    realEndX + outHalfHandleSize,
    realEndY + outHalfHandleSize)

  readonly property bool leftHoveredOut: isHoveringHandle(
    realStartX - outHalfHandleSize,
    realStartY - outHalfHandleSize,
    realStartX,
    realEndY + outHalfHandleSize)

  readonly property bool rightHoveredOut: isHoveringHandle(
    realEndX,
    realStartY - outHalfHandleSize,
    realEndX + outHalfHandleSize,
    realEndY + outHalfHandleSize)

  function isHoveringHandle(startX, startY, endX, endY)
  {
    return containsMouse && isContained(pointerX,
      pointerY,
      startX,
      startY,
      endX,
      endY)
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
        if(leftHovered && rightHovered)
        {
          rightPressed = !leftHoveredOut
          leftPressed = !rightHoveredOut
        }
        else
        {
          rightPressed = rightHovered
          leftPressed = leftHovered
        }

        if(topHovered && bottomHovered)
        {
          bottomPressed = !topHoveredOut
          topPressed = !bottomHoveredOut
        }
        else
        {
          bottomPressed = bottomHovered
          topPressed = topHovered
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
    const normalizedFromX = lastPressedX / width
    const normalizedToX = pressedX / width
    const deltaX = normalizedToX - normalizedFromX

    const normalizedFromY = lastPressedY / height
    const normalizedToY = pressedY / height
    const deltaY = normalizedToY - normalizedFromY

    let currentStart = Qt.vector2d(start.x, start.y)
    let currentEnd = Qt.vector2d(end.x, end.y)

    let horizontalReverseNeeded = false
    let verticalReverseNeeded = false

    // Apply delta to temp value, make sure they are not overlaping
    if(leftPressed)
    {
      const newX = start.x + deltaX
      const limitX = end.x - minSize.x
      if(newX > limitX)
      {
        currentStart.x = limitX
        if(!minSize.x && !rightPressed && horizontalReverseAllowed)
        {
          horizontalReverseNeeded = true
          currentEnd.x += newX - currentStart.x
        }
      }
      else
      {
        currentStart.x += deltaX
      }
    }

    if(rightPressed)
    {
      const newX = end.x + deltaX
      const limitX = start.x + minSize.x
      if(newX < limitX)
      {
        currentEnd.x = limitX
        if(!minSize.x && !leftPressed && horizontalReverseAllowed)
        {
          horizontalReverseNeeded = true
          currentStart.x += newX - currentEnd.x
        }
      }
      else
      {
        currentEnd.x += deltaX
      }
    }

    if(topPressed)
    {
      const newY = start.y + deltaY
      const limitY = end.y - minSize.y
      if(newY > limitY)
      {
        currentStart.y = limitY
        if(!minSize.y && !bottomPressed && verticalReverseAllowed)
        {
          verticalReverseNeeded = true
          currentEnd.y += newY - currentStart.y
        }
      }
      else
      {
        currentStart.y += deltaY
      }
    }

    if(bottomPressed)
    {
      const newY = end.y + deltaY
      const limitY = start.y + minSize.y
      if(newY < limitY)
      {
        currentEnd.y = limitY
        if(!minSize.y && !topPressed && verticalReverseAllowed)
        {
          verticalReverseNeeded = true
          currentStart.y += newY - currentEnd.y
        }
      }
      else
      {
        currentEnd.y += deltaY
      }
    }

    // Clamp all values
    currentStart.x = Math.min(Math.max(currentStart.x, 0), 1)
    currentStart.y = Math.min(Math.max(currentStart.y, 0), 1)
    currentEnd.x = Math.min(Math.max(currentEnd.x, 0), 1)
    currentEnd.y = Math.min(Math.max(currentEnd.y, 0), 1)

    // Keep track of pressed point to measure delta
    lastPressedX = pressedX
    lastPressedY = pressedY

    const hasBeenUpdated = _start.x !== currentStart.x ||
      _start.y !== currentStart.y ||
      end.x !== currentEnd.x ||
      _end.y !== currentEnd.y

    _start = currentStart
    _end = currentEnd

    if(horizontalReverseNeeded)
    {
      leftPressed = !leftPressed
      rightPressed = !rightPressed
    }
    if(verticalReverseNeeded)
    {
      topPressed = !topPressed
      bottomPressed = !bottomPressed
    }

    if(hasBeenUpdated)
      moved(_start, _end)
  }

  onPressedXChanged: () => Qt.callLater(drag)
  onPressedYChanged: () => Qt.callLater(drag)

  Binding on start
  {
    when: root.pressed
    value: root._start
    restoreMode: Binding.RestoreBinding
  }

  Binding on end
  {
    when: root.pressed
    value: root._end
    restoreMode: Binding.RestoreBinding
  }

  // Repeat handles linker
  Repeater
  {
    id: _handleLinkerRepeater
    model: 4
    delegate: Loader
    {
      id: _handleLinkerLoader
      readonly property bool horizontal: index % 2 === 0

      Binding
      {
        target: item
        when: item && item.hasOwnProperty(root.horizontalRole)
        property: root.horizontalRole
        value: _handleLinkerLoader.horizontal
        restoreMode: Binding.RestoreBinding
      }

      readonly property bool hovered:
      {
        if(!root.containsMouse)
          return false

        if(root.containsMouseInsideHandle)
          return true

        switch (index)
        {
          case 0:
            return root.topHovered
          case 1:
            return root.rightHovered
          case 2:
            return root.bottomHovered
          case 3:
            return root.leftHovered
        }
      }

      Binding
      {
        target: item
        when: item && item.hasOwnProperty(root.hoveredRole)
        property: root.hoveredRole
        value: _handleLinkerLoader.hovered
        restoreMode: Binding.RestoreBinding
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

      x: realX - width / 2
      y: realY - height / 2

      readonly property bool hovered:
      {
        if(root.containsMouseInsideHandle)
          return true

        switch (index)
        {
          case 0:
            return root.topHovered || root.leftHovered
          case 1:
            return root.topHovered || root.rightHovered
          case 2:
            return root.bottomHovered || root.rightHovered
          case 3:
            return root.bottomHovered || root.leftHovered
        }
      }

      Binding
      {
        target: item
        when: item && item.hasOwnProperty(root.hoveredRole)
        property: root.hoveredRole
        value: _handleLoader.hovered
        restoreMode: Binding.RestoreBinding
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
    dragThreshold: 0
  }

  // Outside Item sized
  Item
  {
    x: root.realStartX - root.outHalfHandleSize
    y: root.realStartY - root.outHalfHandleSize

    width: root.realEndX - x + root.outHalfHandleSize
    height: root.realEndY - y + root.outHalfHandleSize

    HoverHandler { cursorShape: Qt.OpenHandCursor }
    PointHandler { cursorShape: Qt.ClosedHandCursor }
  }

  // Inside Item sized
  Item
  {
    x: root.realStartX + root.inHalfHandleSize
    y: root.realStartY + root.inHalfHandleSize

    width: root.realEndX - x - root.inHalfHandleSize
    height: root.realEndY - y - root.inHalfHandleSize

    HoverHandler { cursorShape: Qt.SizeAllCursor }
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
