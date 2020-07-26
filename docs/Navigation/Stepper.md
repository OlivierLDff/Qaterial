---
layout: default
title: 🌀 Stepper
---

# 🌀 Stepper

Steppers are Navigation Components used to display progress through a sequence of logical and numbered steps. They may also be used for navigation.

![HorizontalStepper_Simple](https://user-images.githubusercontent.com/51703091/86028815-a950d700-ba32-11ea-9388-e55873787cf6.gif)

## Components

### Customizable Components

- `indicator`:  `Component` used to resume the step (default, step number or checked icon if the step is `done`) (in *pink* on the picture)

- `contentItem`:  `Component`  representing the step displayed below the indicator( default, element `text` property) (in *blue* on the picture)
- `separator`: `Component` displayed between indicators to separate different steps, his width is calculate automatically (default, gray Rectangle)  (in *yellow* on the picture)

- `model`:  `Qaterial.StepperModel` used for the Model of the stepper (default *none*)

![simpl](https://user-images.githubusercontent.com/51703091/86029543-938fe180-ba33-11ea-924d-c211d9c8421a.png)

**Qaterial.StepperModel**

`Qaterial.StepperModel` is a **cpp** implemented list of `Qaterial.SteppeElement`

```javascript
import Qaterial 1.0 as Qaterial

Qaterial.StepperModel
{
  Qaterial.StepperElement
  {
    text: "Point N°1";
    supportingText: "This is Point N°1's supportingText"
    done: true
  }
  Qaterial.StepperElement
  {
    text: "Point N°2";
    supportingText: "This is Point N°2's supportingText : OPTIONAL STEP"
    optional: true
  }
  Qaterial.StepperElement
  {
    text: "Point N°3";
    supportingText: "This is Point N°4's supportingText : ALERT STEP"
    alertMessage: "It's an alert Message !"
  }
}
```

**Qaterial.StepperElement**

`Qaterial.StepperElement` is a **cpp** implemented `QtObject` which can have several properties :

* `text`: `QString`, name of the step

* `done` : `bool` which represents the state of the step, **true** when he is finished
* `optionnal` : `bool` which represents the optional character of the step, when it is set to **true** the step can be skip
* `supportingText`: `QString`, text explaining the step displayed below the stepper
* `alertMessage`: `QString`, when a `alertMessage` is specified, the step will be displayed as an alert step and will have a one more text, the `alertMessage`

### General Properties

**Stepper** have some properties :

- `clickable`: `bool` allowing user to click on a step to go on it (default **false**)
- `vertical`: `bool` allowing the user to choose stepper orientation, when **true** stepper is  displayed vertically whith `contentItem` on the right of `indicator` (default **false**)
- `count`: number of steps, *readonly* (default: `model.count`)

* `currentIndex`: index of the step selected by default (default 0)
* `currentElement`: current step element displayed, *readonly* (default, first model's element)

### Dimensions Properties

As `indicator`, `contentItem` and `separator`Components are loaded inside the **Stepper** it's not easy to access their dimensions to nicely display them so you have to specify them.

Indicator Dimensions

* `indicatorWidth`:  width of the `indicator` Component (default 32)
* `indicatorHeight`:  height of the `indicator` Component (default 32)

Indicator Padding

* `indicatorHorizontalPadding` (default, 8)
* `indicatorLeftPadding`: distance between `indicator`and `contentItem` when `vertical` is **true** (default: `indicatorHorizontalPadding`)
* `indicatorRightPadding` (default: `indicatorHorizontalPadding`)
* `indicatorVerticalPadding` (default 8)
* `indicatorTopPadding`: distance between `indicator`and `contentItem` when `vertical` is **false**  (default: `indicatorVerticalPadding`)
* `indicatorBottomPadding` (default: `indicatorVerticalPadding`)

Content-Item Dimensions

- `contentItemWidth`: width of the `contentItem` (default 100)

* `contentItemHeight`: height of the `contentItem` (default 32)

Content-Item Padding

* `contentItemVerticalPadding`: distance between `contentItem` and mouseArea border (=> `clickable` **true**) when `vertical` is **true**  (default 8)
* `contentItemHorizontalPadding`: distance between `contentItem` and mouseArea border (=> `clickable` **true**) when `vertical` is **false**   (default 8)

Separator Dimensions

- `separatorWidth` (default 10)

- `separatorHeight` (default 10)

### Role Properties

You will use those properties in Advanced use if your Item already have properties named "element", "previous" or "next".

* `elementRole`: `string` containing the name property to access model element in `indicator`, `contentItem`, `separator` (default, "element")
* `previousRole`:  `string` containing the name property to access previous model element in `separator` (default, "previous")
* `nextRole`:  `string` containing the name property to access next model element in `separator` (default, "next")

## Examples

You can find every next presented examples in `./examples` and test them with **QaterialHotReload** or merely check them on **QaterialOnline**.

### Navigation - Stepper - Simple

In this example  `indicator`, `contentItem`, `separator` are just colored Rectangles. And the model contains 3 clickable elements.

![simple_color](https://user-images.githubusercontent.com/51703091/86030472-d30afd80-ba34-11ea-8883-011f1a1ec7b9.gif)

### Navigation - Stepper - OptionalSteps

In this one you can see an implementation of `optional` Steps. You can use the property `optional` of `Qaterial.StepperElement` to make a step skipable.

Here `indicator`, `contentItem`, `separator` are used with their default values.

You can see below an use of the Stepper with a vertically orientation.

Even if the Stepper has an `implicitHeight` by default separator's length is very short, it's user's job to configure it (Cf below gif).

![optionnal_test](https://user-images.githubusercontent.com/51703091/86126866-53863880-badf-11ea-8c16-73627ff1ce9f.gif)

Moreover, a `Row` of Buttons displayed below the stepper allowing the user to switch between different steps, to check or cancel them and to skip them if they are `optional`. For the last step you can also emit some signals checking if user have finished or not the process.

### Navigation - Stepper - AlertSteps

Another property of `Qaterial.StepperElement` is `alertMessage`. User can use it to differ alert Steps from normal steps.

In this example `indicator` and `contentItem` are a bit customized to displayed a different Icon and a different text color when a step is consider as an alert Step (i.e. own a `alertMessage` property).

![alert](https://user-images.githubusercontent.com/51703091/86031228-d9e64000-ba35-11ea-8f43-1b914b16d004.gif)

To access at the model from those components you have to set some properties :

```javascript
import Qaterial 1.0 as Qaterial

contentItem: Qaterial.Label
{
    property Qaterial.StepperElement element
    property int index
    property bool done: element && element.done
	property string alertMessage: element ? element.alertMessage : ""
}
```

Those lines allow you to access `Components`loaded inside the **Stepper**.

### Navigation - Stepper - Advanced.

This last example is the more customized with a new property added to the model :

```javascript
import Qaterial 1.0 as Qaterial

Qaterial.StepperElement
{
	text: "Point N°1";
    supportingText: "This is Point N°1's supportingText"
    property string iconName: "path/to/your/Icon"
}
```

Then you can set the indicator to display it :

![bordel](https://user-images.githubusercontent.com/51703091/86032422-a0163900-ba37-11ea-8efe-874f87746889.gif)

```js
import Qaterial 1.0 as Qaterial

indicator: Qaterial.ColorIcon
{
    property Qaterial.StepperElement element
	source: element.iconName
}
```

And like that every step as a personalized icon.

If your separator element already has a property named `next` you can use Element role properties to change name of the variable  with which you acces the next element for example :

```js
nextRole: "newNextElementRole"
separator: Rectangle { property Qaterial.StepperElement newNextElementRole }
```



