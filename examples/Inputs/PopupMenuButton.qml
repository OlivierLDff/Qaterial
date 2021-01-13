import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Row
{
  Qaterial.PopupMenuItem
  {
    text: "Info"
    icon.source: Qaterial.Icons.informationOutline
  }
  Qaterial.PopupMenuItem
  {
    text: "Code"
    icon.source: Qaterial.Icons.qrcode
  }
  Qaterial.PopupMenuItem
  {
    id: customIcon
    text: "Delete"

    icon.source: Qaterial.Icons.trashCanOutline
    icon.color: Qaterial.Colors.red500
  }
  Qaterial.PopupMenuItem
  {
    id: imageItem
    text: "Image"
    icon.source: "https://www.flaticon.com/svg/static/icons/svg/3426/3426645.svg"

    iconItem: Image
    {
      source: imageItem.icon.source
    }
  }
}
