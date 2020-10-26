import QtQml 2.14
import QtQuick 2.14
import QtQuick.Window 2.4
import Qt.labs.settings 1.0 as QLab

Item
{
  id: root

  // Target Window
  property QtObject target: Window.window

  // Is the WindowLayoutSave active
  // If false this object doesn't have any effect
  property bool enabled: true

  // Feedback is enabled from window x, y, width, height
  property bool feedbackEnabled

  // Window name to support multiple Window in the same application
  property string name

  Connections
  {
    target: root.target
    enabled: root.target && root.enabled

    function onXChanged()
    {
      if(root.feedbackEnabled && root.x !== root.target.x)
        root.x = root.target.x
    }

    function onYChanged()
    {
      if(root.feedbackEnabled && root.y !== root.target.y)
        root.y = root.target.y
    }

    function onWidthChanged()
    {
      if(root.feedbackEnabled && root.width !== root.target.width)
        root.width = root.target.width
    }

    function onHeightChanged()
    {
      if(root.feedbackEnabled && root.height !== root.target.height)
        root.height = root.target.height
    }
  }

  function saveScreenLayout()
  {
    settings.desktopAvailableWidth = Screen.desktopAvailableWidth
    settings.desktopAvailableHeight = Screen.desktopAvailableHeight
    settings.screen = target.screen.name
  }

  function isWindow(item) { return item instanceof Window }

  function ensureValidWindowPosition()
  {
    // todo : log warning/error if target isn't Window based object
    // todo : log warning/error if target is null
    //console.log(`target ${root.target}`)
    //console.log(`isWindow ${isWindow(root.target)}`)

    // Make sure to default to window width/height
    if(!width)
      width = target.width
    if(!height)
      height = target.height

    // Disable feedback during load of settings
    feedbackEnabled = false

    // Look for previous used screen
    let screenFound = false
    for(let i = 0; i < Qt.application.screens.length; ++i)
    {
      const screen = Qt.application.screens[i]
      if(screen.name === settings.screen)
      {
        //console.log(`screen found ${screen.name}`)
        target.screen = Qt.application.screens[i]
        screenFound = true
        break
      }
    }

    if(screenFound)
    {
      const savedScreenLayout = (settings.desktopAvailableWidth === Screen.desktopAvailableWidth) &&
        (settings.desktopAvailableHeight === Screen.desktopAvailableHeight)
      target.x = (savedScreenLayout) ? settings.x : Screen.width / 2 - target.width / 2
      target.y = (savedScreenLayout) ? settings.y : Screen.height / 2 - target.height / 2
      target.width = width
      target.height = height
    }
    else
    {
      const previousName = name
      target.screen = Qt.application.screens[0]
      width = target.width
      height = target.height
      target.x = target.screen.width / 2 - target.width / 2
      target.y = target.screen.height / 2 - target.height / 2
      console.warn(
        `Previous screen ${previousName} not found. Try to restore window to screen ${target.screen.name}, resolution: ${width}x${height}, position: {${target.x},${target.y}}`
        )
    }

    // Make sure width/height are ok
    if(target.width < target.minimumWidth)
      target.width = target.minimumWidth
    if(target.height < target.minimumHeight)
      target.height = target.minimumHeight

    Qt.callLater(delayVisible)
  }

  function delayVisible()
  {
    // Turn Window visible only when screen and position have been correctly affected
    if(visible)
      target.visible = true

    feedbackEnabled = true
  }

  onXChanged: function()
  {
    if(enabled && feedbackEnabled)
      target.x = x
  }

  onYChanged: function()
  {
    if(enabled && feedbackEnabled)
      target.y = y
  }

  onWidthChanged: function()
  {
    if(enabled && feedbackEnabled)
      target.width = width
  }

  onHeightChanged: function()
  {
    if(enabled && feedbackEnabled)
      target.height = height
  }

  QLab.Settings
  {
    id: settings

    category: `Qaterial.Window${root.name ? `.${root.name}` : ``}`

    property alias width: root.width
    property alias height: root.height
    property alias x: root.x
    property alias y: root.y

    property
    var screen
    property
    var desktopAvailableWidth
    property
    var desktopAvailableHeight
  }

  Timer
  {
    interval: 1000;running: root.enabled;repeat: true
    onTriggered: saveScreenLayout()
  }

  Component.onCompleted: function()
  {
    if(enabled)
      ensureValidWindowPosition()
  }
  Component.onDestruction:
  {
    if(enabled)
      saveScreenLayout()
  }
}
