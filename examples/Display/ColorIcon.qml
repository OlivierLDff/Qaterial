import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Column
{
  spacing: 10
  Qaterial.ColorIcon
  {
    source: Qaterial.Icons.rocketLaunchOutline
    outlined: false
    fill: false
    color: Qaterial.Style.accentColor
    roundColor: Qaterial.Style.primaryColor
  }
  Qaterial.ColorIcon
  {
    source: Qaterial.Icons.rocketLaunchOutline
    outlined: true
    fill: false
    color: Qaterial.Style.accentColor
    roundColor: Qaterial.Style.primaryColor
    roundBorderColor: Qaterial.Style.accentColor
  }
  Qaterial.ColorIcon
  {
    source: Qaterial.Icons.rocketLaunchOutline
    outlined: false
    fill: true
    color: Qaterial.Style.accentColor
    roundColor: Qaterial.Style.primaryColor
    roundBorderColor: Qaterial.Style.accentColor
  }
  Qaterial.ColorIcon
  {
    source: Qaterial.Icons.rocketLaunchOutline
    outlined: true
    fill: true
    color: Qaterial.Style.accentColor
    roundColor: Qaterial.Style.primaryColor
    roundBorderColor: Qaterial.Style.accentColor
  }
}
