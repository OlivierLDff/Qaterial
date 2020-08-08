import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12

import Qaterial 1.0 as Qaterial

Qaterial.Popup
{
  id: control

  signal resetPathEntries()
  signal addPathEntry()
  signal editPathEntry(int index)
  signal deletePathEntry(int index)

  property var model: []

  implicitWidth: 500
  padding: 0

  contentItem: Column
  {
    width: root.width

    Rectangle
    {
      color: Qaterial.Style.dialogColor
      width: parent.width
      implicitHeight: title.implicitHeight
      z: 1

      Qaterial.Label
      {
        id: title
        text: "Qml Import Paths"
        width: parent.width
        textType: Qaterial.Style.TextType.Title
        elide: Text.ElideRight
        leftPadding: 16
        topPadding: 8
        bottomPadding: 8
      }

      Qaterial.HorizontalLineSeparator
      {
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: control.width
        y: parent.height - 1
      } // HorizontalLineSeparator
    } // Header

    Item
    {
      width: control.width
      implicitHeight: Math.max(listView.implicitHeight, modifierColumn.implicitHeight)

      ListView
      {
        id: listView
        currentIndex: -1
        implicitHeight: Math.min(300, contentHeight)
        width: parent.width - modifierColumn.width
        interactive: height < contentHeight

        ScrollBar.vertical: Qaterial.ScrollBar { policy: ScrollBar.AsNeeded; width: 12; active: true }

        model: control.model

        delegate: Qaterial.ItemDelegate
        {
          id: pathDelegate
          width: listView.width

          topPadding: 4
          bottomPadding: 4
          rightPadding: 20

          highlighted: listView.currentIndex === index

          onDoubleClicked: () => control.editPathEntry(index)

          onClicked: listView.currentIndex = index

          contentItem: Qaterial.Label
          {
            id: pathLabel
            text: modelData
            elide: Text.ElideRight
            Binding on color
            {
              when: pathDelegate.highlighted
              value: Qaterial.Style.accentColor
            }
          }

          Qaterial.ToolTip
          {
            text: modelData
            visible: pathLabel.truncated && (pathDelegate.hovered || pathDelegate.pressed)
            position: Qaterial.Style.Position.Right
          }

          background: Rectangle
          {
            color: Qt.darker(Qaterial.Style.dialogColor, (index%2===0) ? 1 : 1.2 )
            Qaterial.Ripple
            {
              id: _ripple
              width: parent.width
              height: parent.height

              pressed: pathDelegate.pressed
              active: pathDelegate.down || pathDelegate.visualFocus || pathDelegate.hovered
              anchor: pathDelegate

              clip: visible
              color: Qaterial.Style.rippleColor(Qaterial.Style.RippleBackground.Background)
            } // Ripple
          }
        }
      } // ListView

      Qaterial.VerticalLineSeparator
      {
        x: modifierColumn.x
        height: parent.height
      }

      Column
      {
        id: modifierColumn
        anchors.right: parent.right
        spacing: 0

        Qaterial.SquareButton
        {
          icon.source: Qaterial.Icons.plus
          topInset: 1
          bottomInset: 1

          onClicked: () => control.addPathEntry()

          Qaterial.ToolTip
          {
            text: `Add Path Entry`
            visible:  parent.hovered || parent.pressed
            position: Qaterial.Style.Position.BottomStart
          }
        } // SquareButton

        Qaterial.SquareButton
        {
          icon.source: Qaterial.Icons.minus
          topInset: 1
          bottomInset: 1
          enabled: listView.currentIndex !== -1

          onClicked: function()
          {
            const index = listView.currentIndex
            control.deletePathEntry(index)
            listView.currentIndex = -1
          }

          Qaterial.ToolTip
          {
            text: `Delete ${listView.model[listView.currentIndex]}`
            visible: parent.hovered || parent.pressed
            position: Qaterial.Style.Position.BottomStart
          }
        } // SquareButton

        Qaterial.SquareButton
        {
          icon.source: Qaterial.Icons.pencil
          topInset: 1
          bottomInset: 1
          enabled: listView.currentIndex !== -1

          onClicked: () => control.editPathEntry(listView.currentIndex)

          Qaterial.ToolTip
          {
            text: `Edit ${listView.model[listView.currentIndex]}`
            visible:  parent.hovered || parent.pressed
            position: Qaterial.Style.Position.BottomStart
          }
        } // SquareButton
      } // ButtonColumn
    } // Content

    Rectangle
    {
      color: Qaterial.Style.dialogColor
      width: parent.width
      implicitHeight: buttonRow.implicitHeight

      Row
      {
        id: buttonRow
        anchors.right: parent.right

        Qaterial.FlatButton
        {
          text: "Reset"
          icon.source: Qaterial.Icons.restore

          onClicked: () => control.resetPathEntries()
        }
      } // Row

      Qaterial.HorizontalLineSeparator
      {
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: control.width
      } // HorizontalLineSeparator
    } // Footer
  }
}
