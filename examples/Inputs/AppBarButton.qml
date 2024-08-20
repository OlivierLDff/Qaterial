import QtQuick
import Qaterial as Qaterial

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
