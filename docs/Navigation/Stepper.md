---
layout: default
title: Stepper
---

# Stepper

Steppers display progress through a sequence of logical and numbered steps. They may also be used for navigation.

## Horizontal Stepper

Horizontal Stepper displayed differents model steps in the horizontal orientation. Steps labels are placed below the step icon and their supporting text is displayed below the stepper.

**Properties**

* `currentIndex`: index of the step selected by default (default 0)
* `iconSize`: size of the step icon (default 32)
* `separatorPadding`: distance between icons and separator (default 8)
* `validateIcon`: Component displayed as the step icon when a step is done (default `check`)
* `alertIcon`: Component displayed as the step icon when a step owns an alertMessage (default `alert_outline`)
* `separator`: Component displayed as the separator between differents steps (default, gray line)
* `model`:  Model of the steppers (default: `Qaterial.StepperModel`)

**Qaterial.StepperModel**

`Qaterial.StepperModel` is a c++ implemented list of `Qaterial.SteppeElement`

**Qaterial.StepperElement**

`Qaterial.StepperElement` is a c++ implemented `QtObject` which can have several properties :

* `text`: QString, name of the step

* `done` : boolean which represents the state of the step, `true` when he is finished
* `optionnal` : boolean which represents the optional character of the step, when it is set to `true` the step can be skip
* `supportingText`: QString, text explaining the step displayed below the stepper
* `alertMessage`: QString, when a `alertMessage` is specified, the step will be displayed as an alert step and will have a one more text, the `alertMessage` 

​	

