/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Control
{
  id: _control

  signal editingFinished()
  signal linkActivated(string link)
  signal linkHovered(string link)

  // TEXT AREA ALIAS
  property string placeholderText
  property string text
  property int wrapMode: Text.Wrap
  property bool cursorVisible: true

  // CONTENT
  property string title
  property string helperText
  property string prefixText
  property string suffixText
  property url leadingIconSource

  // COLORS
  property color color: enabled ? Qaterial.Style.primaryTextColor() : Qaterial.Style.hintTextColor()
  property color selectionColor: Qaterial.Style.accentColor
  property color selectedTextColor: Qaterial.Style.shouldReverseForegroundOnAccent ? Qaterial.Style
    .primaryTextColorReversed() : Qaterial.Style.primaryTextColor()
  property color placeholderTextColor: Qaterial.Style.hintTextColor()

  property color titleTextColor: enabled ? (errorState && titleUp ? Qaterial.Style.errorColor : Qaterial.Style
    .hintTextColor()) : Qaterial.Style.dividersColor()
  property color helperTextColor: enabled ? (errorState ? Qaterial.Style.errorColor : Qaterial.Style.hintTextColor()) :
    Qaterial.Style.dividersColor()
  property color prefixTextColor: enabled ? (Qaterial.Style.hintTextColor()) : Qaterial.Style.dividersColor()
  property color suffixTextColor: enabled ? (Qaterial.Style.hintTextColor()) : Qaterial.Style.dividersColor()
  property color leadingIconColor: enabled ? (textAreaActiveFocus ? Qaterial.Style.accentColor : Qaterial.Style
    .secondaryTextColor()) : Qaterial.Style.disabledTextColor()

  // LOOK
  property int verticalAlignment: TextInput.AlignTop
  property int renderType: Text.QtRendering
  property bool leadingIconInline: false
  property bool leadingIconVisible: leadingIconSource != ""
  property bool leadingIconErrorAnimation: false
  property bool trailingInline: true

  property int textType: Qaterial.Style.TextType.ListText
  property int titleTextType: titleUp ? Qaterial.Style.TextType.Caption : textType
  property int placeholderTextType: textType
  property int prefixTextType: textType
  property int suffixTextType: textType
  property int hintTextType: Qaterial.Style.TextType.Hint

  property bool titleUp: textAreaActiveFocus || _control.length || _control.preeditText
  readonly property bool anyHintVisible: (_control.helperText != "" || _control._errorText != "") || _lineCountLabel
    .visible

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding)

  topPadding: 0 //_control.title != "" ? Qaterial.Style.textField.topPaddingTitle : Qaterial.Style.textField.topPadding
  bottomPadding: 0 //anyHintVisible ? Qaterial.Style.textField.bottomPaddingHint : Qaterial.Style.textField.bottomPadding

  property double virtualLeftPadding: ((leadingIconVisible) ? _leadingIcon.width + leadingSpacing : 0) + ((
    leadingIconVisible && !leadingIconInline) ? Qaterial.Style.textField.horizontalPadding : 0)

  property double virtualRightPadding: ((trailingVisible) ? _trailingContent.width + trailingSpacing : 0) + ((
    trailingVisible && !trailingInline) ? Qaterial.Style.textField.horizontalPadding : 0)

  leftPadding: 0 //virtualLeftPadding + (prefixText != "" ? _prefixLabel.contentWidth + textSpacing : 0)
  rightPadding: virtualRightPadding + (suffixText != "" ? _suffixLabel.contentWidth + textSpacing : 0)
  property double leadingSpacing: Qaterial.Style.textField.leadingSpacing
  property double textSpacing: Qaterial.Style.textField.textSpacing
  property double trailingSpacing: 0

  leftInset: (!leadingIconInline && leadingIconVisible) ? _leadingIcon.width + leadingSpacing : 0
  rightInset: (!trailingInline && trailingVisible) ? _trailingContent.width + trailingSpacing : 0

  // DEBUG
  property bool drawline: Qaterial.Style.debug.drawDebugButton
  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "blue"
    visible: _control.drawline
  } // DebugRectangle

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
    y: Qaterial.Style.textField.topPadding
    x: _control.width - width
    opacity: _control.trailingVisible ? color.a : 0.0
    onSourceComponentChanged:
    {
      if(item && ((typeof item.textArea) == "object"))
      {
        item.textArea = _control
      } // if
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

    textType: _control.titleTextType
    color: _control.titleTextColor
    x: textAreaLeftPadding
    y: titleUp ? Qaterial.Style.textField.topPaddingTitleOffset : textAreaTopPadding
    width: _control.width - textAreaLeftPadding - _control.rightPadding
    verticalAlignment: _control.verticalAlignment
    renderType: _control.renderType
    elide: Text.ElideRight
    Behavior on y
    {
      NumberAnimation { easing.type: Easing.OutCubic;
        duration: 200 } // NumberAnimation
    } // Behavior y
    font.pixelSize: Qaterial.Style.textTypeToPixelSize(textType)
    Behavior on font.pixelSize
    {
      NumberAnimation { easing.type: Easing.OutCubic;
        duration: 200 } // NumberAnimation
    } // Behavior pixelsize
    Behavior on color
    {
      ColorAnimation { easing.type: Easing.OutCubic;
        duration: 200 } // ColorAnimation
    } // Behavior color
  } // Label

  // HELPER TEXT
  property bool errorState: _errorText != ""
  property bool acceptableInput: true
  property int length: textArea.length
  property bool textAreaActiveFocus: textArea.activeFocus
  property string preeditText: textArea.preeditText
  property string _errorText: ""
  property string errorText: helperText
  property bool autoSubmit: true
  property bool editedAtLeastOnce: false
  property bool error: (!acceptableInput || (length > maximumLengthCount))
  onErrorChanged: if((editedAtLeastOnce || length) && autoSubmit) Qt.callLater(submitInput)
  onEditingFinished:
  {
    editedAtLeastOnce = true
    if(autoSubmit)
      Qt.callLater(submitInput)
  }
  ErrorSequentialAnimation { id: _errorAnimation;target: _titleLabel;x: textAreaLeftPadding }
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
      _errorText = s
    }
  } // function setError(s)

  Qaterial.Label // Hint
  {
    opacity: (_control.helperText != "" || _control._errorText != "") ? 1.0 : 0.0
    Behavior on opacity { NumberAnimation { easing.type: Easing.OutCubic;
        duration: 100 } }
    text: _control.errorState ? _control._errorText : _control.helperText

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "violet"
      visible: _control.drawline
    } // DebugRectangle

    textType: _control.hintTextType
    color: _control.helperTextColor
    width: _control.width - textAreaLeftPadding - _control.rightPadding - _lineCountLabel.width
    x: textAreaLeftPadding
    y: _control.height - height - Qaterial.Style.textField.bottomPaddingHintOffset
    verticalAlignment: _control.verticalAlignment
    renderType: _control.renderType
    elide: Text.ElideRight
  } // Label

  property int maximumLengthCount: 32767

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

    textType: _control.hintTextType
    color: _control.helperTextColor
    x: _control.width - width - (_control.trailingInline ? 0 : _control.rightPadding)
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
    x: textAreaLeftPadding
    y: _control.topPadding
    text: _control.prefixText
    color: _control.prefixTextColor
    textType: _control.prefixTextType
    verticalAlignment: _control.verticalAlignment
    renderType: _control.renderType
    opacity: (_control.prefixText != "" && textAreaActiveFocus || _control.length) ? 1.0 : 0.0

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
    x: _control.width - width - _control.rightPadding
    y: _control.topPadding
    textType: _control.suffixTextType
    text: _control.suffixText
    color: _control.suffixTextColor
    verticalAlignment: _control.verticalAlignment
    renderType: _control.renderType
    opacity: (_control.suffixText != "" && textAreaActiveFocus || _control.length) ? 1.0 : 0.0

    Behavior on opacity
    {
      NumberAnimation
      {
        easing.type: Easing.OutCubic
        duration: 200
      } // NumberAnimation
    } // Behavior
  } // Label

  Behavior on bottomPadding { NumberAnimation { easing.type: Easing.OutCubic;
      duration: 200 } }

  property
  var textArea: _textArea

  property double textAreaRightPadding: 0
  property double textAreaLeftPadding: _control.virtualLeftPadding + (_control.prefixText != "" ? _prefixLabel
    .contentWidth + _control.textSpacing : 0)
  property double textAreaTopPadding: _control.title != "" ? Qaterial.Style.textField.topPaddingTitle : Qaterial.Style
    .textField.topPadding
  property double textAreaBottomPadding: _control.anyHintVisible ? Qaterial.Style.textField.bottomPaddingHint : Qaterial
    .Style.textField.bottomPadding

  contentItem: Qaterial.TextAreaContent
  {
    id: _textArea
    onPrimary: _control.onPrimary
    colorReversed: _control.colorReversed
    topPadding: _control.title != "" ? Qaterial.Style.textField.topPaddingTitle : Qaterial.Style.textField.topPadding
    bottomPadding: _control.anyHintVisible ? Qaterial.Style.textField.bottomPaddingHint : Qaterial.Style.textField
      .bottomPadding

    leftPadding: _control.virtualLeftPadding + (_control.prefixText != "" ? _prefixLabel.contentWidth + _control
      .textSpacing : 0)

    onEditingFinished: _control.editingFinished()
    onLinkActivated: _control.linkActivated(link)
    onLinkHovered: _control.linkHovered(link)

    forcePlaceholderOff: !_control.titleUp
    textType: _control.textType
    placeholderText: _control.placeholderText
    text: _control.text
    wrapMode: _control.wrapMode
    cursorVisible: _control.cursorVisible
    color: _control.color
    selectionColor: _control.selectionColor
    selectedTextColor: _control.selectedTextColor
    placeholderTextColor: _control.placeholderTextColor
    verticalAlignment: _control.verticalAlignment
    renderType: _control.renderType
  } // TextAreaContent

  // BACKGROUND
  property double backgroundBorderHeight: Qaterial.Style.textField.backgroundBorderHeight
  property color backgroundColor: errorState ? Qaterial.Style.errorColor : Qaterial.Style.hintTextColor()
  property color backgroundHighlightColor: errorState ? Qaterial.Style.errorColor : Qaterial.Style.accentColor
  background: Rectangle
  {
    y: _control.height - height - textAreaBottomPadding + 8
    implicitWidth: Qaterial.Style.textField.implicitWidth
    width: parent.width
    height: textAreaActiveFocus || _control.hovered ? _control.backgroundBorderHeight : 1
    color: _control.backgroundColor

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
      width: textAreaActiveFocus ? parent.width : 0
      x: textAreaActiveFocus ? 0 : parent.width / 2

      Behavior on width
      {
        enabled: !textAreaActiveFocus
        NumberAnimation { easing.type: Easing.OutCubic;
          duration: 300 } // NumberAnimation
      } // Behavior

      Behavior on x
      {
        enabled: !textAreaActiveFocus
        NumberAnimation { easing.type: Easing.OutCubic;
          duration: 300 } // NumberAnimation
      } // Behavior

      Qaterial.DebugRectangle
      {
        anchors.fill: parent
        border.color: "red"
        visible: _control.drawline
      } // DebugRectangle
    } // Rectangle
  } // Rectangle
} // Control
