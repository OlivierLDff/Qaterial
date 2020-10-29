// Copyright Olivier Le Doeuff 2020 (C)

import QtQml 2.14
import QtQuick 2.14
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

import Qaterial 1.0 as Qaterial

T.ItemDelegate
{
  id: control

  // Injected by the TreeView
  property QtObject model

  // Injected by the TreeView
  property int depth

  // Injected by the TreeView
  property int index

  property Qaterial.FolderTreeModel folderTreeModel: model ? model.qtObject : null

  // Called when a user click on the file
  signal accepted(string path)

  readonly property string extensionIcon:
  {
    if(!model)
      return ""

    const ext = model.fileCompleteSuffix

    if(model.isDir)
      return model.expanded ? Qaterial.Icons.folderOutline : Qaterial.Icons.folder

    if(model.fileBaseName === "")
      return Qaterial.Icons.asterisk

    if(ext == 'cpp' || ext == 'hpp' || ext == 'cxx' || ext == 'hxx' || ext == 'cc')
      return Qaterial.Icons.languageCpp

    if(ext == 'c' || ext == 'h')
      return Qaterial.Icons.languageC

    if(ext == 'cs')
      return Qaterial.Icons.languageCsharp

    if(ext == 'css')
      return Qaterial.Icons.languageCss3

    if(ext == 'go')
      return Qaterial.Icons.languageGo

    if(ext == 'html')
      return Qaterial.Icons.languageHtml

    if(ext == 'java')
      return Qaterial.Icons.languageJava

    if(ext == 'js')
      return Qaterial.Icons.languageJavascript

    if(ext == 'kt')
      return Qaterial.Icons.languageKotlin

    if(ext == 'lua')
      return Qaterial.Icons.languageLua

    if(ext == 'md')
      return Qaterial.Icons.languageMarkdown

    if(ext == 'php')
      return Qaterial.Icons.languagePhp

    if(ext == 'py')
      return Qaterial.Icons.languagePython

    if(ext == 'ruby')
      return Qaterial.Icons.languageRuby

    if(ext == 'ts')
      return Qaterial.Icons.languageTypescript

    if(ext == 'swift')
      return Qaterial.Icons.languageSwift

    if(ext == 'xaml')
      return Qaterial.Icons.languageXaml

    if(ext == 'txt')
      return Qaterial.Icons.text

    if(ext == 'json')
      return Qaterial.Icons.text

    if(ext.includes('vcxproj') || ext == 'sln')
      return Qaterial.Icons.microsoftVisualStudioCode

    if(ext == 'png' || ext == 'jpg' || ext == 'jpeg' || ext == 'svg')
      return Qaterial.Icons.codeJson

    return Qaterial.Icons.codeTags
  }

  implicitWidth: Math.max(background ? implicitBackgroundWidth : 0,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(background ? implicitBackgroundHeight : 0,
    Math.max(implicitContentHeight,
      indicator ? indicator.implicitHeight : 0) + topPadding + bottomPadding) + bottomInset

  spacing: 8
  leftPadding: depth * Qaterial.Style.card.horizontalPadding + 12

  text: model ? model.fileName : ""
  property color color:
  {
    if(model && model.isDir && model.expanded)
      return Qaterial.Style.accentColor

    if(highlighted)
      return Qaterial.Style.accentColor

    if(hovered)
      return Qaterial.Style.primaryTextColor()

    return Qaterial.Style.hintTextColor()
  }

  icon.source: extensionIcon
  icon.color:
  {
    if(highlighted || hovered)
      return Qaterial.Style.accentColor

    if(model && model.isDir && model.expanded)
      return Qaterial.Style.accentColor

    Qaterial.Style.hintTextColor()
  }

  onClicked: function()
  {
    if(!model)
      return

    if(model.isDir)
    {
      // fetch content of folder if expand is about to happen
      if(!model.expanded && folderTreeModel)
        folderTreeModel.fetch()

      // Then expand or retract
      model.expanded = !model.expanded
    }
    else
    {
      control.accepted(`file:///${model.filePath}`)
    }
  }

  // Qaterial.DebugRectangle { anchors.fill: parent; border.color: "red" }

  contentItem: Item
  {
    implicitHeight: Math.max(fileIcon.implicitHeight, fileLabel.implicitHeight)

    // Qaterial.DebugRectangle { anchors.fill: parent }

    Qaterial.Icon
    {
      id: fileIcon

      anchors.verticalCenter: parent.verticalCenter

      visible: parent.width >= width
      size: parent.height - 4

      icon: control.icon.source
      color: control.icon.color
    }

    Qaterial.Label
    {
      id: fileLabel

      anchors.verticalCenter: parent.verticalCenter

      x: fileIcon.width + control.spacing
      width: parent.width - fileIcon.width - control.spacing

      text: control.text
      textType: Qaterial.Style.TextType.Caption
      elide: Text.ElideRight
      verticalAlignment: Text.AlignVCenter

      color: control.color
    }
  }

  // Selected indicator
  Rectangle
  {
    visible: control.highlighted
    color: Qaterial.Style.accentColor
    height: control.height - 4
    width: 2
    x: 2
    y: 2
  }

  background: Qaterial.ListDelegateBackground
  {
    implicitHeight: 24
    color: control.highlighted ? Qaterial.Style.backgroundColor : "transparent"
    pressed: control.pressed
    rippleActive: control.down || control.visualFocus || control.hovered
    rippleAnchor: control
  } // ListDelegateBackground
}
