/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

/**
 * CONTENT
 * - text
 * - title
 * - helperText
 * - placeholderText
 * - prefixText
 * - suffixText
 *
 * - leadingIconSource
 * - leadingSpacing
 * - leadingVisible
 *
 * - trailingContent
 * - tralingVisible
 * - tralingSpacing
 *
 * COLOR
 *
 * - color / textColor
 * - titleTextColor
 * - helperTextColor
 * - prefixTextColor
 * - suffixTextColor
 * - leadingIconColor
 * - trailingIconColor
 *
 * BEHAVIOR
 *
 * LOOK
 * - echoMode (TextInput.Normal | Password  | NoEcho | PasswordEchoOnEdit )
 * - leadingIconInline
 * - trailingIconInline
 *
 * DOC
 * https://doc.qt.io/qt-5/qml-qtquick-textinput.html
 * https://doc.qt.io/qt-5/qml-qtquick-controls2-textfield.html
 */

T.TextField
{
  id: _control

  // CONTENT
  property string title
  property string helperText
  property string prefixText
  property string suffixText
  property url leadingIconSource

  // LOOK
  property bool leadingIconInline: false
  property bool leadingIconVisible: leadingIconSource != ""
  property bool leadingIconErrorAnimation: false
  property bool trailingInline: true

  property font textFont: Qaterial.Style.textTheme.subtitle1
  property font titleFont: titleUp ? Qaterial.Style.textTheme.caption : textFont
  property font placeholderfont: textFont
  property font prefixfont: textFont
  property font suffixfont: textFont
  property font hintfont: Qaterial.Style.textTheme.hint1

  property bool titleUp: _control.activeFocus || _control.length || _control.preeditText
  readonly property bool anyHintVisible: (_control.helperText != "" || _control._errorText != "") || _lineCountLabel
    .visible

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  font: Qaterial.Style.textTheme.subtitle1

  // DEBUG
  property bool drawline: Qaterial.Style.debug.drawDebugButton

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "pink"
    visible: _control.drawline
  } // DebugRectangle

  Qaterial.DebugRectangle
  {
    x: _control.leftPadding
    y: _control.topPadding
    width: _control.width - _control.leftPadding - _control.rightPadding
    height: _control.contentHeight
    border.color: "orange"
    visible: _control.drawline
  } // DebugRectangle

  Qaterial.DebugRectangle
  {
    x: _control.leftPadding
    y: _control.topPadding
    width: Math.min(_control.contentWidth, _control.width - _control.leftPadding - _control.rightPadding)
    height: _control.contentHeight
    border.color: "red"
    visible: _control.drawline
  } // DebugRectangle

  // SIZE
  implicitWidth: implicitBackgroundWidth + leftInset + rightInset ||
    Math.max(contentWidth, placeholder.implicitWidth) + _control.virtualLeftPadding + _control.virtualRightPadding
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding,
    placeholder.implicitHeight + topPadding + bottomPadding)

  topPadding: _control.title != "" ? Qaterial.Style.textField.topPaddingTitle - 5 : Qaterial.Style.textField.topPadding
  bottomPadding: anyHintVisible ? Qaterial.Style.textField.bottomPaddingHint + 5 : Qaterial.Style.textField.bottomPadding + 10

  property double virtualLeftPadding: ((leadingIconVisible) ? leadingIconInline ? (_leadingIcon.width + leadingSpacing) - 20 : (_leadingIcon.width + leadingSpacing) - 0 : 0) + ((leadingIconVisible && !leadingIconInline) ? Qaterial.Style.textField.horizontalPadding : 0)

  property double virtualRightPadding: ((trailingVisible) ? _trailingContent.width + trailingSpacing : 0) + ((
    trailingVisible && !trailingInline) ? Qaterial.Style.textField.horizontalPadding : 0)

  leftPadding: (virtualLeftPadding + (prefixText != "" ? _prefixLabel.contentWidth + textSpacing : 0)) + 10
  rightPadding: (virtualRightPadding + (suffixText != "" ? _suffixLabel.contentWidth + textSpacing : 0)) + 20
  property double leadingSpacing: Qaterial.Style.textField.leadingSpacing
  property double textSpacing: Qaterial.Style.textField.textSpacing
  property double trailingSpacing: 0

  leftInset: (!leadingIconInline && leadingIconVisible) ? (_leadingIcon.width + leadingSpacing) - 10 : 0
  rightInset: (!trailingInline && trailingVisible) ? _trailingContent.width + trailingSpacing : 0

  Behavior on bottomPadding
  {
    NumberAnimation
    {
      easing.type: Easing.OutCubic
      duration: 200
    } // NumberAnimation
  } // Behavior

  // COLORS
  property alias textColor: _control.color
  color: enabled ? Qaterial.Style.primaryTextColor() : Qaterial.Style.hintTextColor()
  selectionColor: Qaterial.Style.accentColor
  selectedTextColor: Qaterial.Style.shouldReverseForegroundOnAccent ? Qaterial.Style.primaryTextColorReversed() : Qaterial.Style.primaryTextColor()
  placeholderTextColor: Qaterial.Style.hintTextColor()
  verticalAlignment: TextInput.AlignVCenter

  property color titleTextColor: enabled ? (errorState && titleUp ? Qaterial.Style.errorColor : Qaterial.Style
    .hintTextColor()) : Qaterial.Style.dividersColor()
  property color helperTextColor: enabled ? (errorState ? Qaterial.Style.errorColor : Qaterial.Style
    .hintTextColor()) : Qaterial.Style.dividersColor()
  property color prefixTextColor: enabled ? (Qaterial.Style.hintTextColor()) : Qaterial.Style.dividersColor()
  property color suffixTextColor: enabled ? (Qaterial.Style.hintTextColor()) : Qaterial.Style.dividersColor()
  property color leadingIconColor: enabled ? Qaterial.Style.secondaryTextColor() : Qaterial.Style.disabledTextColor()

  // BEHAVIOR
  selectByMouse: true

  // CURSOR
  cursorDelegate: Qaterial.CursorDelegate {}

  // LEADING ICON
  Qaterial.ColorIcon
  {
    id: _leadingIcon
    color: _control.leadingIconColor
    source: _control.leadingIconSource
    iconSize: Qaterial.Style.textField.iconSize
    width: Qaterial.Style.textField.iconWidth
    height: Qaterial.Style.textField.iconWidth
    y: Qaterial.Style.textField.topPadding
    x: leadingIconVisible ? 8 : 0
    opacity: _control.leadingIconVisible ? color.a : 0.0
    Behavior on opacity
    {
      NumberAnimation
      {
        easing.type: Easing.OutCubic
        duration: 200
      } // NumberAnimation
    } // Behavior
  } // ColorIcon

  // trailing ICON
  property alias trailingContent: _trailingContent.sourceComponent
  property bool trailingVisible: _trailingContent.sourceComponent != undefined

  Loader
  {
    id: _trailingContent
    y: _control.title != "" ? Qaterial.Style.textField.topPadding : 0
    x: _control.width - width
    opacity: _control.trailingVisible ? color.a : 0.0
    onSourceComponentChanged:
    {
      if(item && ((typeof item.textField) == "object"))
      {
        item.textField = _control
      }
    }

    Behavior on opacity
    {
      NumberAnimation
      {
        easing.type: Easing.OutCubic
        duration: 200
      } // NumberAnimation
    } // Behavior
  } // Loader

  // TITLE
  onTitleUpChanged:
  {
    if(titleUp)
    {
      _titleLabel.font = Qaterial.Style.textTheme.caption
    }
    else
    {
      _titleLabel.font = _control.textFont
    }
  }

  Qaterial.Label
  {
    id: _titleLabel
    visible: _control.title != ""
    text: _control.title

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "violet"
      visible: _control.drawline
    } // DebugRectangle

    font: _control.titleUp ? Qaterial.Style.textTheme.caption : _control.textFont
    color: _control.activeFocus ? Qaterial.Style.accentColor : _control.titleTextColor
    //leftPadding: parent.leftPadding
    x: _control.virtualLeftPadding + 10
    y: titleUp ? Qaterial.Style.textField.topPaddingTitleOffset : _control.topPadding
    width: _control.width - _control.virtualLeftPadding - _control.virtualRightPadding
    verticalAlignment: _control.verticalAlignment
    horizontalAlignment: _control.horizontalAlignment
    renderType: _control.renderType
    elide: Text.ElideRight

    Behavior on y
    {
      NumberAnimation
      {
        easing.type: Easing.OutCubic;
        duration: 200
      } // NumberAnimation
    } // Behavior y
    Behavior on font.pixelSize
    {
      NumberAnimation
      {
        easing.type: Easing.OutCubic;
        duration: 200
      } // NumberAnimation
    } // Behavior pixelsize
    Behavior on color
    {
      ColorAnimation
      {
        easing.type: Easing.OutCubic;
        duration: 200
      } // ColorAnimation
    } // Behavior color
  } // Label

  // HELPER TEXT
  property bool errorState: _errorText != ""
  property string _errorText: ""
  property string errorText: helperText
  property bool autoSubmit: true
  property bool editedAtLeastOnce: false
  property bool error: (!acceptableInput || (length > maximumLengthCount))
  onErrorChanged: if(editedAtLeastOnce && autoSubmit) Qt.callLater(submitInput)
  onTextEdited:
  {
    editedAtLeastOnce = true
    if(autoSubmit)
      Qt.callLater(submitInput)
  }
  ErrorSequentialAnimation { id: _errorAnimation;target: _titleLabel;x: _control.virtualLeftPadding + 10 }
  ErrorSequentialAnimation { id: _errorLeadingAnimation;target: _leadingIcon;x: _control.width - _leadingIcon.width }

  function submitInput()
  {
    if(!error)
      clearError()
    else
      setError(errorText)
  } // function submitInput()

  function clearError()
  {
    if(errorState)
      _errorText = ""
  } // function clearError()

  function setError(s)
  {
    if(!errorState)
    {
      if(titleUp)
        _errorAnimation.start()
      if(leadingIconErrorAnimation)
        _errorLeadingAnimation.start()
      _errorText = s ? s : " "
      if(!s)
        console.log("Error: No Error text provided, please provide errorText property to guide your user")
    }
  } // function setError(s)

  property int maximumLengthCount: maximumLength

  Qaterial.Label // LineCounter
  {
    id: _lineCountLabel
    visible: _control.maximumLengthCount > 0 && _control.maximumLengthCount < 32767
    text: _control.length + "/" + _control.maximumLengthCount

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "violet"
      visible: _control.drawline
    } // DebugRectangle

    font: _control.hintfont
    color: _control.helperTextColor
    x: _control.width - width - (_control.trailingInline ? 0 : _control.virtualRightPadding)
    y: _control.height - height - Qaterial.Style.textField.bottomPaddingHintOffset
    verticalAlignment: _control.verticalAlignment
    renderType: _control.renderType
  } // Label

  Qaterial.Label // Prefix Label
  {
    id: _prefixLabel

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "violet"
      visible: _control.drawline
    } // DebugRectangle

    height: _control.contentHeight
    x: (_control.virtualLeftPadding) + 10
    y: _control.topPadding
    text: _control.prefixText
    color: _control.prefixTextColor
    font: _control.prefixfont
    verticalAlignment: _control.verticalAlignment
    renderType: _control.renderType
    opacity: (_control.prefixText != "" && _control.activeFocus || _control.length) ? 1.0 : 0.0

    Behavior on opacity
    {
      NumberAnimation
      {
        easing.type: Easing.OutCubic
        duration: 200
      } // NumberAnimation
    } // Behavior
  } // Label

  Qaterial.Label // Suffix Label
  {
    id: _suffixLabel

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "violet"
      visible: _control.drawline
    } // DebugRectangle

    height: _control.contentHeight
    x: (_control.width - width - _control.virtualRightPadding) - 20
    y: _control.topPadding
    font: _control.suffixfont
    text: _control.suffixText
    color: _control.suffixTextColor
    verticalAlignment: _control.verticalAlignment
    renderType: _control.renderType
    opacity: (_control.suffixText != "" && _control.activeFocus || _control.length) ? 1.0 : 0.0

    Behavior on opacity
    {
      NumberAnimation
      {
        easing.type: Easing.OutCubic
        duration: 200
      } // NumberAnimation
    } // Behavior
  } // Label

  // PLACEHOLDER
  Qaterial.PlaceholderText
  {
    id: placeholder
    x: _control.leftPadding
    y: _control.topPadding
    width: _control.width - (_control.leftPadding + _control.rightPadding)
    height: _control.height - (_control.topPadding + _control.bottomPadding)
    text: _control.placeholderText
    color: _control.placeholderTextColor
    font: _control.placeholderfont
    verticalAlignment: _control.verticalAlignment
    horizontalAlignment: _control.horizontalAlignment
    elide: Text.ElideRight
    renderType: _control.renderType
    readonly property bool shouldBeVisible: (_control.title == "" || _control.activeFocus) && !_control.length && !
      _control.preeditText && (!_control.activeFocus || _control.horizontalAlignment !== Qt.AlignHCenter)
    opacity: shouldBeVisible ? 1.0 : 0.0

    Behavior on opacity
    {
      NumberAnimation
      {
        easing.type: Easing.InQuad
        duration: placeholder.shouldBeVisible ? 50 : 200
      } // NumberAnimation
    } // Behavior
  } // PlaceholderText

  // BACKGROUND
  property double backgroundBorderHeight: Qaterial.Style.textField.backgroundBorderHeight
  property color backgroundColor: Qaterial.Style.theme === Qaterial.Style.Theme.Light ? Qaterial.Colors.gray300 : Qt.lighter(Qaterial.Style.backgroundColor)
  property color backgroundHighlightColor: errorState ? Qaterial.Style.errorColor : Qaterial.Style.accentColor

  background: Rectangle
  {
    color: _control.backgroundColor
    height: (_control.helperText != "" || _control._errorText != "") ? parent.height - 15 : parent.height
    radius: 2
    Rectangle
    {
      y: _control.height - height - _control.bottomPadding + 17
      implicitWidth: Qaterial.Style.textField.implicitWidth
      width: parent.width
      height: _control.activeFocus || _control.hovered ? _control.backgroundBorderHeight : 1
      color: errorState ? Qaterial.Style.errorColor : Qaterial.Style.hintTextColor()

      Qaterial.DebugRectangle
      {
        anchors.fill: parent
        border.color: "blue"
        visible: _control.drawline
      } // DebugRectangle

      Rectangle
      {
        height: _control.backgroundBorderHeight
        color: _control.backgroundHighlightColor
        width: _control.activeFocus ? parent.width : 0
        x: _control.activeFocus ? 0 : parent.width / 2

        Behavior on width
        {
          enabled: !_control.activeFocus
          NumberAnimation
          {
            easing.type: Easing.OutCubic;
            duration: 300
          } // NumberAnimation
        } // Behavior

        Behavior on x
        {
          enabled: !_control.activeFocus
          NumberAnimation
          {
            easing.type: Easing.OutCubic;
            duration: 300
          } // NumberAnimation
        } // Behavior

        Qaterial.DebugRectangle
        {
          anchors.fill: parent
          border.color: "red"
          visible: _control.drawline
        } // DebugRectangle
      } // Rectangle
    } // Rectangle
  }
  Qaterial.Label // Hint
  {
    opacity: (_control.helperText != "" || _control._errorText != "") ? 1.0 : 0.0
    Behavior on opacity
    {
      NumberAnimation
      {
        easing.type: Easing.OutCubic;
        duration: 100
      }
    }
    text: _control.errorState ? _control._errorText : _control.helperText

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "violet"
      visible: _control.drawline
    } // DebugRectangle

    font: _control.hintfont
    color: _control.helperTextColor
    width: _control.width - _control.virtualLeftPadding - _control.virtualRightPadding - _lineCountLabel.width
    x: leadingIconVisible ? leadingIconInline ? (_control.virtualLeftPadding) - 15 : (_control.virtualLeftPadding) + 10 : (_control.virtualLeftPadding) + 10
    y: (_control.height - height - Qaterial.Style.textField.bottomPaddingHintOffset) + 4
    verticalAlignment: _control.verticalAlignment
    renderType: _control.renderType
    elide: Text.ElideRight
  } // Label
} // TextField
