---
layout: default
title: 📅 Date / Time ⌚
---

# Date / Time

## 📅 Date Picker

### DatePickerDialog

Open a dialog used to pick a date, composed by `CalendarMonthPickerView`,`CalendarYearPickerView` and `CalendarView` and display the date picked in a `CalendarDisplayDate`.

![DatePickerDialogDemo](https://user-images.githubusercontent.com/63917864/85862746-786a6b00-b7c2-11ea-9cda-8ed71f8dadb1.gif)

#### Properties

* `date date`:  Date picked by the user
* `date from`: Date of the beggining of the DatePickerView (default: 1st January of 1900)
* `date to`: Date of the end of the DatePickerView (default: 1st January of 2100)
* `int month`: current month displayed in the view (default: today's month)
* `int year`: year of the current month displayed in the view (default: today's year)
* `bool monthGridActive`: `true` to load the `CalendarMonthPickerView` component (default : `false`)
* `bool yearGridActive`: `true` to load the `CalendarYearPickerView` component (default : `false`)
* `bool calendarViewActive`: `true` to load the `CalendarView` component (default :`true`)

#### Signals

* `accepted (date date)` : Signal emitted when the user pick a valid date

### TextFieldDate

This TextField allows the user to select a date by editing the text field with format 'dd/mm/yyyy'.

![TextFieldDatePickerDemo](https://user-images.githubusercontent.com/63917864/85865555-5d015f00-b7c6-11ea-8666-1fca586734e3.gif)

#### Properties

* `date date` : Date entered by the user
* `date from` : Start date of the calendar (default : 1st January of 1900)
* `date to` : End date of the calendar(default : 1st January of 2100)

#### Signals

* `accepted(date date)` : Signal emitted when the date entered by the user is valid

### TextFieldDatePicker

![TextFieldDatePicker_2Demo](https://user-images.githubusercontent.com/63917864/85869140-95f00280-b7cb-11ea-808d-8410144cfe1e.gif)

This TextField allows the user to select a date by editing the text field with format 'dd/mm/yyyy' or picking a date with a `DatePickerDialog` deployed by clicking on a ButtonIcon 'Calendar'.

#### Properties

* `date date` : Date entered in the text field or picked by the user
* `date from` : Start date of the calendar (default : 1st January of 1900)
* `date to` : End date of the calendar(default : 1st January of 2100)

#### Signals

* `accepted(date date)` : Signal emitted when the date entered by the user is valid

## ⌚ Time Picker

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

This TextField allows the user to select an hour by editing the text in the field or by picking an hour in a TimePickerDialog.

**Properties**

* `hour`: hour displayed when the dialog is opened (default 0)
* `minute`: minute displayed when the dialog is opened (default 0)
* `styleAm`: style of the Clock, American Am/Pm style when `true` (default `false`)
* `am`: when Am/Pm style is used, represent the time slot of the hour picked, equal `false` when Pm (default `true`)

**Signal** : `hourAccepted(hour, minute, am)`, emitted when a correct hour is picked by the user

## ✏️ Advanced Use

### Date Components

### CalendarDateButton

Component used by `CalendarDayPickerView`, `CalendarYearPickerView` and `CalendarMonthPickerView`

![CalendarDateButtonDemo](https://user-images.githubusercontent.com/63917864/85554771-88007d00-b625-11ea-9475-6ab33c496058.gif)

### CalendarWeekDayRow

Display a row of the first character of the week days. Component used by `CalendarDayPicker`

![image](https://user-images.githubusercontent.com/63917864/85697363-03bc0180-b6da-11ea-874f-bfa0d8a98f79.png)

### CalendarDayGrid

Display a day grid with a month and year given

![CalendarDayGridDemo_2](https://user-images.githubusercontent.com/63917864/85685414-547a2d00-b6cf-11ea-93f6-03cd7268a2d2.gif)

#### Properties

* `date date` : date picked by the user.
* `int month` : month displayed in the grid *(default is today's month)*
* `int year` : year displayed in the grid *(default is today's year)*

#### Signal

* `accepted(date date)` : Signal emitted when the user pick a date

### CalendarDayPickerView
Display a ListView of  `CalendarDayPicker` whose size and model is defined by properties `from` and `to` . Component used by `CalendarView`.

![CalendarDayPickerViewDemo](https://user-images.githubusercontent.com/63917864/85687766-75dc1880-b6d1-11ea-8c7d-7d7c9860a017.gif)

#### Properties

* `date date`:  Date picked by the user
* `date from`: Date of the beggining of the DatePickerView (default: 1st January of 1900)
* `date to`: Date of the end of the DatePickerView (default: 1st January of 2100)
* `int month`: current month displayed in the view (default: today's month)
* `int year`: year of the current month displayed in the view (default: today's year)

#### Signals

* `accepted(date date)`: Signal emitted when the user pick a date
* `moved(int month, int year)`: Signal emitted when the user change the current view

### CalendarNavigationBar

Bar composed of `Qaterial.AppBarButton` and  `Qaterial.FlatButton`. Component used by `CalendarView`

![CalendarBarNavigation](https://user-images.githubusercontent.com/63917864/85691336-b4bf9d80-b6d4-11ea-94ea-19e63867597a.gif)

#### Properties

* `int month` :  Month displayed in the bar
* `int year` :  Year displayed in the bar

#### Signals

* `monthClicked()` : Signal emitted when the user click on the MonthButton
* `yearClicked()`: Signal emitted when the user click on the YearButton
* `nextMonth()` : Signal emitted when the user click on the nextButton
* `previousMonth()` : Signal emitted when the user click on the previousButton

### CalendarView
Display a ListView of  `CalendarDayPicker` whose size and model is defined by properties `from` and `to`. The navigation is controled by a `CalendarNavigationBar`

![CalendarViewDemo€](https://user-images.githubusercontent.com/63917864/85697107-ca839180-b6d9-11ea-8215-27916d5b9e1c.gif)


#### Properties

* `date date`:  Date picked by the user
* `date from`: Date of the beggining of the DatePickerView (default: 1st January of 1900)
* `date to`: Date of the end of the DatePickerView (default: 1st January of 2100)
* `int month`: current month displayed in the view (default: today's month)
* `int year`: year of the current month displayed in the view (default: today's year)

#### Signals

* `yearClicked()` : Signal emitted when the YearButton is clicked
* `monthClicked()` : Signal emitted when the MonthButton is clicked
* `moved(int month, int year)` : Signal emitted when the current view changed
* `accepted (date date)` : Signal emitted when the user pick a valid date

### CalendarMonthPickerView
Display a GridView to choose a month. Component used by `DatePickerDialog`

![CalendarMonthPickerViewDemo](https://user-images.githubusercontent.com/63917864/85698935-63ff7300-b6db-11ea-988e-8da57110d7cc.gif)

#### Properties

* `int month` :  Month choosed in the view

#### Signals

* `accepted(int month)` : Signal emitted when the user choose a month.

### CalendarYearPickerView
Display a GridView to choose a year. Component used by `DatePickerDialog`

![CalendarYearPickerViewDemo](https://user-images.githubusercontent.com/63917864/85699951-3961ea00-b6dc-11ea-9a3a-3a34a46d45e1.gif)

#### Properties

* `int year` :  Year choosed in the view

#### Signals

* `accepted(int year)` : Signal emitted when the user pick a year

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
