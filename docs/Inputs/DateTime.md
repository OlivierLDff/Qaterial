---
layout: default
title: Date / Time
---

# Date / Time



## Date Picker



## Time Picker

### TimePickerDialog

Dialog providing a simple way to pick an Hour. The clock style can be changed from European to Am/Pm and the hour displayed at the opening is set by the user.

[Test it live!](https://olivierldff.github.io/QaterialOnline/?code=JYWwDg9gTgLgBARRggrsAxgazgJgHQAMAUKJLIgIYwCmUwFANnAIyFwUDOlNdjRRCKrXoM8AFVDUAChky0AIiIgBzIgG8icOAHptcedQBmFFA3gxJcDgAsIAd2oATOHevUAdnEdLlcYFwgwDydNOFsUKAAuFgBWUJBgdxQaaIBmYlDdfX8wBgoATzgYNzh0BggsP08AQRBtKRArGHyGagAaOGg4AFEUJpbqUI5m1tro4wYOQcy9ABl-Gk8YCDgUKahS6wp3ZWoOUIh3AAkICIBhLZ2naIAKAEo4AF4APlLDjghWvHLlG4ADE4ROAXba7ZzRAAkanCUAAvn87gd3ABZRLJaggq6OW4PF5vdwfL4-f6opI0YGXMFwSFqBJk6jwxFI6rodDUMA0bFwe5PV7od6fajfFT-ACq6zgYFkTjgUJhsMiULp6MZSIAStQAFbUdCcnG8-GEoXEv4a7W6pwI-haM4QcCHDwwPCHW3gVp6zpBdz3IiwoA)

**Properties**

* `hour`: hour displayed when the dialog is opened (default 0)
* `minute`: minute displayed when the dialog is opened (default 0)
* `showMinutes`: boolean showing minute picker (default `false`)
* `styleAm`: style of the clock, Am/Pm when `true` European otherwise (default `false`)
* `am`: if `styleAm` is used `true` if the user picked an "am" hour `false` otherwise (default `false`)

### TextFieldTimePicker

This TextField allows the user to select an EU hour by editing the text in the field or by picking an hour in a TimePickerDialog.

**Properties**

* `hour`: hour displayed when the dialog is opened (default 0)
* `minute`: minute displayed when the dialog is opened (default 0)
* `styleAm`: style of the Clock, American Am/Pm style when `true` (default `false`)
* `am`: when Am/Pm style is used, represent the time slot of the hour picked, equal `false` when Pm (default `true`)

**Signal** : `hourAccepted(hour, minute, am)`, emitted when a correct hour is picked by the user

## Advanced Use

### Date Components



### Time Components

#### EuCircularHourPicker

Allow to pick hour from 0 to 23 (Eu way)

````js
EuCircularHourPicker
{
    radius: 150
    hour: 5
    onAccepted: (hour) => console.log(`hour: ${hour}`)
}
````

**Properties**

* `radius`: (default 100)
* `hour` : Hour of the component, can be set from outside (default 0)
* `labelSize` : Size of text area, distance between am and pm hour circular path (default 32)

**Signal**

* `accepted` : Signal emitted at every move of the HandClock

#### AmCircularHourPicker

Allow to pick hour from 1 to 12 (American way)

````js
AmCircularHourPicker
{
    radius: 150
    hour: 5
    onAccepted: (hour) => console.log(`hour: ${hour}`)
}
````

**Properties**

* `radius`: (default 100)
* `hour` :  Hour of the component, can be set from outside (default 12)

**Signal**

* `accepted` : Signal emitted at every move of the **HandClock**

#### CircularMinutePicker

Allow to pick minute from 0 to 59

````js
CircularMinutePicker
{
    radius: 150
    minute: 42
    onAccepted: (minute) => console.log(`minute: ${minute}`)
}
````

**Properties**

* `radius`: (default 100)
* `minute` : Minute of the component, can be set from outside (default 0)

**Signal**

* `accepted` : Signal emitted at every move of the HandClock

#### CircularPathLabel

Display data in a circular path, is able to highlight an element

````js
CircularPathLabel
{
    radius: 150
    numberOfElement: 5
    model: ["0", "1", "2", "3", "4"]
    currentIndex: 3
}
````

**Properties**

* `radius`: (default 100)
* `model` : Table of values displayed in the path (default, hours of the day)
* `numberOfElement` : Number of values display in circle (default 12)
* `textType` : Text characteristics of elements displayed (default, *Qaterial.Style.TextType.Body1*, can be choose among **Qaterial.Style.TextType** Enum)
* `currentIndex` : Index of the element "highlighted" (default -1)
* `labelSize` : Size of text area (default 32)

#### HandClock

Display a hand clock that is used to display which hour or minute is selected by user.
It is controlled by rotation. For example, if the `HandClock` should match 6 hour, rotation should be 180.
The radius should match the radius of your `CircularPathLabel` and be centered in it.

````js
import Qaterial 1.0 as Qaterial

HandClock
{
    radius: 140
    renderDot: false
    color: Qaterial.Style.accentColor
}
````

**Properties**

* `color` : (default Style.accentColor)
* `radius` : (default 100)
* `labelSize` : Radius of the external "picker" circle (default : 32 x 2^0.5)
* `renderDot` : Boolean which displayed or not a central circle in the external "picker" circle (default `true`)

#### Notes

Note that there is no security on the hour/minute when you set it by yourselves. So you can set an hour like `25:-12`.