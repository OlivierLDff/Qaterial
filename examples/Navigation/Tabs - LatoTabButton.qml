import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  implicitWidth: listView.width
  implicitHeight: listView.height

  ListView
  {
    id: listView

    width: contentWidth
    height: contentHeight

    contentWidth: contentItem.childrenRect.width;contentHeight: contentItem.childrenRect.height

    model: ["Overview", "Guides", "Reference", "Docs"]

    orientation: ListView.Horizontal
    boundsBehavior: Flickable.StopAtBounds
    flickableDirection: Flickable.AutoFlickIfNeeded
    snapMode: ListView.SnapToItem

    delegate: Qaterial.LatoTabButton
    {
      text: modelData

      onClicked: () => ListView.view.currentIndex = index
    }
  }

  Qaterial.DebugRectangle { anchors.fill: root }
}
