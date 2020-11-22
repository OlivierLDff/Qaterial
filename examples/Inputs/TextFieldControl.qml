import QtQuick 2.12
import QtQuick.Controls 2.15 as CC
import Qaterial 1.0 as Qaterial
import QtQuick.Layouts 1.3

Item {
	anchors.fill: parent

	Qaterial.Card {
		anchors.centerIn: parent
		width: 600
		height: 500
		ColumnLayout {
			anchors.fill: parent
			Qaterial.TabBar {
				Layout.fillWidth: true
				Qaterial.TabButton {
					text: "Default"
					width: 120
				}
			}
			Item {
				Layout.fillWidth: true 
				Layout.fillHeight: true 
				RowLayout {
					anchors.fill: parent
					Qaterial.SwipeView {
						Layout.fillWidth: true 
						Layout.fillHeight: true 
						Item {
							Column {
								x: 20
								y: 10
								spacing: 20
								width: parent.width
								Qaterial.TextField {
									id: field1
									error: errorS.checked
									title: titleS.checked? "Username" : ""
									helperText: helpS.checked? "Username : user_revilio" : ""
									placeholderText: placeHolderS.checked? "Revilio" : ""
									leadingIconInline: leadingInlineS.checked
									prefixText: prefixS.checked? "user_" : ""
									suffixText: suffixS.checked? text.length : ""
									leadingSpacing: 0
									trailingInline: trailingInlineS.checked
									trailingVisible: trailingS.checked
									leadingIconSource: leadingS.checked? Qaterial.Icons.account : ""
									width: parent.width-40
								}
								Qaterial.TextField {
									id: field2
									error: errorS.checked
									title: titleS.checked? "Password" : ""
									echoMode: Qaterial.TextField.Password
									helperText: helpS.checked? "Password : Z3D223_21QSDs: ": ""
									placeholderText: placeHolderS.checked? "Z3Ds3_1QSDs" : ""
									leadingSpacing: 0
									leadingIconInline: leadingInlineS.checked
									leadingIconSource: leadingS.checked? Qaterial.Icons.account : ""
									trailingSpacing: 0
									trailingInline: trailingInlineS.checked
									trailingVisible: trailingS.checked
									trailingContent: Qaterial.AppBarButton {
										icon.source: Qaterial.Icons.eye
										rightInset: 0
										onClicked: {
											if(parent.parent.echoMode==Qaterial.TextField.Normal) {
												parent.parent.echoMode = Qaterial.TextField.Password
											}else {
												parent.parent.echoMode = Qaterial.TextField.Normal
											}
										}
									}
									width: parent.width-40
								}
								Qaterial.Button {
									text: "Submit"
									onClicked:{
										field1.submitInput()
										field2.submitInput()
									}
								}
							}
						}
					}
					Item {
						Layout.fillHeight: true 
						width: 180
						Rectangle {
							height: parent.height-10
							width: 1
							color: Qaterial.Colors.gray200
						}
						Column {
							anchors.fill: parent
							padding: 7
							spacing: -5
							Qaterial.CheckButton {
								id: titleS
								checked: true
								text: "Title"
							}
							Qaterial.CheckButton {
								id: helpS
								checked: false
								text: "HelperText"
							}
							Qaterial.CheckButton {
								id: placeHolderS
								checked: false
								text: "placeholderText"
							}
							Qaterial.CheckButton {
								id: prefixS
								checked: false
								text: "PrefixText"
							}
							Qaterial.CheckButton {
								id: suffixS
								checked: false
								text: "SuffixText"
							}
							Qaterial.CheckButton {
								id: leadingS
								checked: false
								text: "Leading Icon"
							}
							Qaterial.CheckButton {
								id: leadingInlineS
								checked: false
								text: "Leading Icon Inline"
							}
							Qaterial.CheckButton {
								id: trailingS
								checked: false
								text: "Trailing Icon"
							}
							Qaterial.CheckButton {
								id: trailingInlineS
								checked: false
								text: "Trailing Inline"
							}
							Qaterial.CheckButton {
								id: errorS
								checked: false
								text: "Error "
							}
						}
					}
				}
			}
		}
	}
}