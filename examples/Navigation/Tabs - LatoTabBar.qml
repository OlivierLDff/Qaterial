import QtQuick 2.15
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  implicitWidth: column.width
  implicitHeight: column.height

  Column
  {
    id: column

    spacing: 8

    Qaterial.LatoTabBar
    {
      id: tabBar

      currentIndex: tabBarScroll.currentIndex

      Qaterial.LatoTabButton { text: "Overview" }
      Qaterial.LatoTabButton { text: "Guides" }
      Qaterial.LatoTabButton { text: "Reference" }
      Qaterial.LatoTabButton { text: "Docs" }
      Qaterial.LatoTabButton { text: "About" }
    }

    Qaterial.LatoTabBar
    {
      id: tabBarScroll

      currentIndex: tabBar.currentIndex

      width: 200
      clip: true

      Qaterial.LatoTabButton { text: "Overview";width: implicitWidth }
      Qaterial.LatoTabButton { text: "Guides";width: implicitWidth }
      Qaterial.LatoTabButton { text: "Reference";width: implicitWidth }
      Qaterial.LatoTabButton { text: "Docs";width: implicitWidth }
      Qaterial.LatoTabButton { text: "About";width: implicitWidth }
    }
  }

  Qaterial.DebugRectangle { width: tabBar.width;height: tabBar.height;x: tabBar.x;y: tabBar.y }
  Qaterial.DebugRectangle
  {
    width: tabBarScroll.width;height: tabBarScroll.height;x: tabBarScroll.x;y: tabBarScroll
      .y;border.color: Qaterial.Style.orange
  }
}
