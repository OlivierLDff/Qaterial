import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Row
{
  Qaterial.AppBarButton
  {
    icon.source: Qaterial.Icons.menu
  }
  Qaterial.AppBarButton
  {
    icon.source: Qaterial.Icons.clockOutline
    enabled: false
  }
}
