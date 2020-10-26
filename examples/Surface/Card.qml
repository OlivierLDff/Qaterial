import QtQuick 2.12
import QtQuick.Layouts 1.12
import Qaterial 1.0 as Qaterial

Qaterial.Card
{
  id: root
  media: "https://d1fmx1rbmqrxrr.cloudfront.net/cnet/optim/i/edit/2019/04/eso1644bsmall__w770.jpg"

  headerText: "This is a cool Image"
  subHeaderText: "Space is cool"
  supportingText: "Visit a blackHole will make you have a great day."
  button1.text: "Button 1"
  button2.text: "Button 2"

  property alias button1: _button1
  property alias button2: _button2

  contentItem: ColumnLayout
  {
    width: parent.width
    spacing: Qaterial.Style.card.horizontalPadding

    Qaterial.CardMedia { source: root.media;clipTop: true;Layout.preferredWidth: 300;Layout.preferredHeight: 200 }

    Qaterial.CardTitle
    {
      headerText: root.headerText
      subHeaderText: root.subHeaderText
      Layout.leftMargin: Qaterial.Style.card.horizontalPadding
    }

    Qaterial.CardSupportingText
    {
      supportingText: root.supportingText
      Layout.leftMargin: Qaterial.Style.card.horizontalPadding
      Layout.fillWidth: true
    }

    Row
    {
      Qaterial.FlatButton { id: _button1 }
      Qaterial.FlatButton { id: _button2 }
    }
  }
}
