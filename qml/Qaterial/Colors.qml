/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

pragma Singleton

import QtQuick 2.0

QtObject
{
  id: root

  readonly property string black: "#000000"
  readonly property string white: "#FFFFFF"

  property alias red: root.red500
  property alias pink: root.pink500
  property alias purple: root.purple500
  property alias deepPurple: root.deepPurple500
  property alias indigo: root.indigo500
  property alias blue: root.blue500
  property alias lightBlue: root.lightBlue500
  property alias cyan: root.cyan500
  property alias teal: root.teal500
  property alias green: root.green500
  property alias lightGreen: root.lightGreen500
  property alias lime: root.lime500
  property alias yellow: root.yellow500
  property alias amber: root.amber500
  property alias orange: root.orange500
  property alias deepOrange: root.deepOrange500
  property alias brown: root.brown500
  property alias gray: root.gray500
  property alias blueGray: root.blueGray500

  readonly property string red50: "#FFEBEE"
  readonly property string red100: "#FFCDD2"
  readonly property string red200: "#EF9A9A"
  readonly property string red300: "#E57373"
  readonly property string red400: "#EF5350"
  readonly property string red500: "#F44336"
  readonly property string red600: "#E53935"
  readonly property string red700: "#D32F2F"
  readonly property string red800: "#C62828"
  readonly property string red900: "#B71C1C"

  readonly property string pink50: "#FCE4EC"
  readonly property string pink100: "#F8BBD0"
  readonly property string pink200: "#F48FB1"
  readonly property string pink300: "#F06292"
  readonly property string pink400: "#EC407A"
  readonly property string pink500: "#E91E63"
  readonly property string pink600: "#D81B60"
  readonly property string pink700: "#C2185B"
  readonly property string pink800: "#AD1457"
  readonly property string pink900: "#880E4F"

  readonly property string purple50: "#F3E5F5"
  readonly property string purple100: "#E1BEE7"
  readonly property string purple200: "#CE93D8"
  readonly property string purple300: "#BA68C8"
  readonly property string purple400: "#AB47BC"
  readonly property string purple500: "#9C27B0"
  readonly property string purple600: "#8E24AA"
  readonly property string purple700: "#7B1FA2"
  readonly property string purple800: "#6A1B9A"
  readonly property string purple900: "#4A148C"

  readonly property string deepPurple50: "#EDE7F6"
  readonly property string deepPurple100: "#D1C4E9"
  readonly property string deepPurple200: "#B39DDB"
  readonly property string deepPurple300: "#9575CD"
  readonly property string deepPurple400: "#7E57C2"
  readonly property string deepPurple500: "#673AB7"
  readonly property string deepPurple600: "#5E35B1"
  readonly property string deepPurple700: "#512DA8"
  readonly property string deepPurple800: "#4527A0"
  readonly property string deepPurple900: "#311B92"

  readonly property string indigo50: "#E8EAF6"
  readonly property string indigo100: "#C5CAE9"
  readonly property string indigo200: "#9FA8DA"
  readonly property string indigo300: "#7986CB"
  readonly property string indigo400: "#5C6BC0"
  readonly property string indigo500: "#3F51B5"
  readonly property string indigo600: "#3949AB"
  readonly property string indigo700: "#303F9F"
  readonly property string indigo800: "#283593"
  readonly property string indigo900: "#1A237E"

  readonly property string blue50: "#E3F2FD"
  readonly property string blue100: "#BBDEFB"
  readonly property string blue200: "#90CAF9"
  readonly property string blue300: "#64B5F6"
  readonly property string blue400: "#42A5F5"
  readonly property string blue500: "#2196F3"
  readonly property string blue600: "#1E88E5"
  readonly property string blue700: "#1976D2"
  readonly property string blue800: "#1565C0"
  readonly property string blue900: "#0D47A1"

  readonly property string lightBlue50: "#E1F5FE"
  readonly property string lightBlue100: "#B3E5FC"
  readonly property string lightBlue200: "#81D4FA"
  readonly property string lightBlue300: "#4FC3F7"
  readonly property string lightBlue400: "#29B6F6"
  readonly property string lightBlue500: "#03A9F4"
  readonly property string lightBlue600: "#039BE5"
  readonly property string lightBlue700: "#0288D1"
  readonly property string lightBlue800: "#0277BD"
  readonly property string lightBlue900: "#01579B"

  readonly property string cyan50: "#E0F7FA"
  readonly property string cyan100: "#B2EBF2"
  readonly property string cyan200: "#80DEEA"
  readonly property string cyan300: "#4DD0E1"
  readonly property string cyan400: "#26C6DA"
  readonly property string cyan500: "#00BCD4"
  readonly property string cyan600: "#00ACC1"
  readonly property string cyan700: "#0097A7"
  readonly property string cyan800: "#00838F"
  readonly property string cyan900: "#006064"

  readonly property string teal50: "#E0F2F1"
  readonly property string teal100: "#B2DFDB"
  readonly property string teal200: "#80CBC4"
  readonly property string teal300: "#4DB6AC"
  readonly property string teal400: "#26A69A"
  readonly property string teal500: "#009688"
  readonly property string teal600: "#00897B"
  readonly property string teal700: "#00796B"
  readonly property string teal800: "#00695C"
  readonly property string teal900: "#004D40"

  readonly property string green50: "#E8F5E9"
  readonly property string green100: "#C8E6C9"
  readonly property string green200: "#A5D6A7"
  readonly property string green300: "#81C784"
  readonly property string green400: "#66BB6A"
  readonly property string green500: "#4CAF50"
  readonly property string green600: "#43A047"
  readonly property string green700: "#388E3C"
  readonly property string green800: "#2E7D32"
  readonly property string green900: "#1B5E20"

  readonly property string lightGreen50: "#F1F8E9"
  readonly property string lightGreen100: "#DCEDC8"
  readonly property string lightGreen200: "#C5E1A5"
  readonly property string lightGreen300: "#AED581"
  readonly property string lightGreen400: "#9CCC65"
  readonly property string lightGreen500: "#8BC34A"
  readonly property string lightGreen600: "#7CB342"
  readonly property string lightGreen700: "#689F38"
  readonly property string lightGreen800: "#558B2F"
  readonly property string lightGreen900: "#33691E"

  readonly property string lime50: "#F9FBE7"
  readonly property string lime100: "#F0F4C3"
  readonly property string lime200: "#E6EE9C"
  readonly property string lime300: "#DCE775"
  readonly property string lime400: "#D4E157"
  readonly property string lime500: "#CDDC39"
  readonly property string lime600: "#C0CA33"
  readonly property string lime700: "#AFB42B"
  readonly property string lime800: "#9E9D24"
  readonly property string lime900: "#827717"

  readonly property string yellow50: "#FFFDE7"
  readonly property string yellow100: "#FFF9C4"
  readonly property string yellow200: "#FFF59D"
  readonly property string yellow300: "#FFF176"
  readonly property string yellow400: "#FFEE58"
  readonly property string yellow500: "#FFEB3B"
  readonly property string yellow600: "#FDD835"
  readonly property string yellow700: "#FBC02D"
  readonly property string yellow800: "#F9A825"
  readonly property string yellow900: "#F57F17"

  readonly property string amber50: "#FFF8E1"
  readonly property string amber100: "#FFECB3"
  readonly property string amber200: "#FFE082"
  readonly property string amber300: "#FFD54F"
  readonly property string amber400: "#FFCA28"
  readonly property string amber500: "#FFC107"
  readonly property string amber600: "#FFB300"
  readonly property string amber700: "#FFA000"
  readonly property string amber800: "#FF8F00"
  readonly property string amber900: "#FF6F00"

  readonly property string orange50: "#FFF3E0"
  readonly property string orange100: "#FFE0B2"
  readonly property string orange200: "#FFCC80"
  readonly property string orange300: "#FFB74D"
  readonly property string orange400: "#FFA726"
  readonly property string orange500: "#FF9800"
  readonly property string orange600: "#FB8C00"
  readonly property string orange700: "#F57C00"
  readonly property string orange800: "#EF6C00"
  readonly property string orange900: "#E65100"

  readonly property string deepOrange50: "#FBE9E7"
  readonly property string deepOrange100: "#FFCCBC"
  readonly property string deepOrange200: "#FFAB91"
  readonly property string deepOrange300: "#FF8A65"
  readonly property string deepOrange400: "#FF7043"
  readonly property string deepOrange500: "#FF5722"
  readonly property string deepOrange600: "#F4511E"
  readonly property string deepOrange700: "#E64A19"
  readonly property string deepOrange800: "#D84315"
  readonly property string deepOrange900: "#BF360C"

  readonly property string brown50: "#EFEBE9"
  readonly property string brown100: "#D7CCC8"
  readonly property string brown200: "#BCAAA4"
  readonly property string brown300: "#A1887F"
  readonly property string brown400: "#8D6E63"
  readonly property string brown500: "#795548"
  readonly property string brown600: "#6D4C41"
  readonly property string brown700: "#5D4037"
  readonly property string brown800: "#4E342E"
  readonly property string brown900: "#3E2723"

  readonly property string gray50: "#FAFAFA"
  readonly property string gray100: "#F5F5F5"
  readonly property string gray200: "#EEEEEE"
  readonly property string gray300: "#E0E0E0"
  readonly property string gray400: "#BDBDBD"
  readonly property string gray500: "#9E9E9E"
  readonly property string gray600: "#757575"
  readonly property string gray700: "#616161"
  readonly property string gray800: "#424242"
  readonly property string gray900: "#212121"

  readonly property string blueGray50: "#ECEFF1"
  readonly property string blueGray100: "#CFD8DC"
  readonly property string blueGray200: "#B0BEC5"
  readonly property string blueGray300: "#90A4AE"
  readonly property string blueGray400: "#78909C"
  readonly property string blueGray500: "#607D8B"
  readonly property string blueGray600: "#546E7A"
  readonly property string blueGray700: "#455A64"
  readonly property string blueGray800: "#37474F"
  readonly property string blueGray900: "#263238"

  readonly property string redA100: "#FF8A80"
  readonly property string redA200: "#FF5252"
  readonly property string redA400: "#FF1744"
  readonly property string redA700: "#D50000"

  readonly property string pinkA100: "#FF80AB"
  readonly property string pinkA200: "#FF4081"
  readonly property string pinkA400: "#F50057"
  readonly property string pinkA700: "#C51162"

  readonly property string purpleA100: "#EA80FC"
  readonly property string purpleA200: "#E040FB"
  readonly property string purpleA400: "#D500F9"
  readonly property string purpleA700: "#AA00FF"

  readonly property string deepPurpleA100: "#B388FF"
  readonly property string deepPurpleA200: "#7C4DFF"
  readonly property string deepPurpleA400: "#651FFF"
  readonly property string deepPurpleA700: "#6200EA"

  readonly property string indigoA100: "#8C9EFF"
  readonly property string indigoA200: "#536DFE"
  readonly property string indigoA400: "#3D5AFE"
  readonly property string indigoA700: "#304FFE"

  readonly property string blueA100: "#82B1FF"
  readonly property string blueA200: "#448AFF"
  readonly property string blueA400: "#2979FF"
  readonly property string blueA700: "#2962FF"

  readonly property string lightBlueA100: "#80D8FF"
  readonly property string lightBlueA200: "#40C4FF"
  readonly property string lightBlueA400: "#00B0FF"
  readonly property string lightBlueA700: "#0091EA"

  readonly property string cyanA100: "#84FFFF"
  readonly property string cyanA200: "#18FFFF"
  readonly property string cyanA400: "#00E5FF"
  readonly property string cyanA700: "#00B8D4"

  readonly property string tealA100: "#A7FFEB"
  readonly property string tealA200: "#64FFDA"
  readonly property string tealA400: "#1DE9B6"
  readonly property string tealA700: "#00BFA5"

  readonly property string greenA100: "#B9F6CA"
  readonly property string greenA200: "#69F0AE"
  readonly property string greenA400: "#00E676"
  readonly property string greenA700: "#00C853"

  readonly property string lightGreenA100: "#CCFF90"
  readonly property string lightGreenA200: "#B2FF59"
  readonly property string lightGreenA400: "#76FF03"
  readonly property string lightGreenA700: "#64DD17"

  readonly property string limeA100: "#F4FF81"
  readonly property string limeA200: "#EEFF41"
  readonly property string limeA400: "#C6FF00"
  readonly property string limeA700: "#AEEA00"

  readonly property string yellowA100: "#FFFF8D"
  readonly property string yellowA200: "#FFFF00"
  readonly property string yellowA400: "#FFEA00"
  readonly property string yellowA700: "#FFD600"

  readonly property string amberA100: "#FFE57F"
  readonly property string amberA200: "#FFD740"
  readonly property string amberA400: "#FFC400"
  readonly property string amberA700: "#FFAB00"

  readonly property string orangeA100: "#FFD180"
  readonly property string orangeA200: "#FFAB40"
  readonly property string orangeA400: "#FF9100"
  readonly property string orangeA700: "#FF6D00"

  readonly property string deepOrangeA100: "#FF9E80"
  readonly property string deepOrangeA200: "#FF6E40"
  readonly property string deepOrangeA400: "#FF3D00"
  readonly property string deepOrangeA700: "#DD2C00"
}
