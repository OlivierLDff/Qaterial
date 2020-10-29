import QtQuick 2.12
import QtQuick.Controls 2.12
import Qaterial 1.0 as Qaterial

Qaterial.Button
{
  text: "Show Text Field Dialog"
  icon.source: Qaterial.Icons.formTextbox

  onClicked: function()
  {
    Qaterial.DialogManager.showTextFieldDialog(
    {
      title: "title",
      textTitle: "textTitle",
      text: "text",
      placeholderText: "placeholderText",
      helperText: "helperText",
      validator: null,
      inputMethodHints: Qt.ImhSensitiveData,
      maximumLengthCount: 32,
      selectAllText: true,
      errorText: "Text is too long",
      echoMode: TextInput.Normal,
      standardButtons: Dialog.Ok | Dialog.Cancel,
      width: 400,
      onAccepted: function(text, acceptable)
      {
        if(acceptable)
          console.log(`Accept text ${text}`)
        else
          console.log(`Can't accept text ${text} because of error`)
      },
      onRejected: () => console.log("Text Field Dialog rejected"),
    })
  }
}
