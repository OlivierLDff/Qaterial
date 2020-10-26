import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Column
{
  id: _column
  width: 400

  Qaterial.TextField // Demonstrate required
  {
    id: _nameInput
    width: _column.width
    title: "Name *"
    placeholderText: "What do people call you?"
    validator: RegExpValidator { regExp: /[A-Za-z]+/ }
    errorText: "Name is required"
    inputMethodHints: Qt.ImhSensitiveData
    leadingIconSource: Qaterial.Icons.account
    trailingVisible: true
    trailingContent: Qaterial.TextFieldButtonContainer
    {
      Qaterial.TextFieldAlertIcon { visible: _nameInput.errorState }
      Qaterial.TextFieldClearButton { visible: _nameInput.length }
    } // TextFieldButtonContainer
  } // TextField

  Qaterial.TextField // Demonstrate number keyboard
  {
    id: _phoneField
    width: _column.width
    title: "Phone Number"
    placeholderText: "Where can we reach you"
    inputMethodHints: Qt.ImhDialableCharactersOnly
    leadingIconSource: Qaterial.Icons.phone
  } // TextField

  Qaterial.TextField // Demonstrate auto completion
  {
    width: _column.width
    title: "Email"
    placeholderText: "Your Email address"
    leadingIconSource: Qaterial.Icons.email
    leadingIconInline: true
    inputMethodHints: Qt.ImhUrlCharactersOnly
    trailingInline: false
    trailingContent: Qaterial.TextFieldButtonContainer
    {
      Qaterial.TextFieldCopyButton {}
      Qaterial.TextFieldClearButton {}
    } // TextFieldButtonContainer
  } // TextField

  Qaterial.TextField // Demonstrata text prefix
  {
    width: _column.width
    title: "Salary"
    prefixText: "$"
    suffixText: "USD"
    suffixTextType: Qaterial.Style.TextType.Overline
    suffixTextColor: "#8BC34A"
    placeholderText: "Enter your Salary"
    validator: RegExpValidator { regExp: /[0-9]*[.,]?[0-9]{0,2}/ }
    inputMethodHints: Qt.ImhFormattedNumbersOnly
  } // TextField

  Qaterial.TextField // Demonstrate max length where you can write more
  {
    width: _column.width
    title: "Country"
    placeholderText: "Which country do you live in"
    helperText: "No more than 16 characters"
    maximumLengthCount: 16
    inputMethodHints: Qt.ImhSensitiveData
    trailingVisible: errorState
    trailingContent: Qaterial.TextFieldAlertIcon {} // TextFieldAlertIcon
  } // TextField

  Qaterial.TextField // Demonstrate show hidden
  {
    width: _column.width
    title: "Password *"
    placeholderText: "Enter your password"
    helperText: "Please input more than 8 characters"
    validator: RegExpValidator { regExp: /.{8,}/ }
    echoMode: TextInput.Password
    inputMethodHints: Qt.ImhSensitiveData
    trailingContent: Qaterial.TextFieldPasswordButton {} // TextFieldPasswordButton
  } // TextField
}
