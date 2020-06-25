import Qaterial 1.0 as Qaterial

Qaterial.HorizontalStepper
{
  model: Qaterial.StepperModel
  {
    Qaterial.StepperElement
    {
      text: "Point N°1"
      supportingText: "This is the Point N°1's supporting text"
    }
    Qaterial.StepperElement
    {
      text: "Alert Point N°1"
      alertMessage: "This is an alert message"
      done: true
      supportingText: "This is the Alert Point N°1's supporting text"
    }
    Qaterial.StepperElement
    {
      text: "Alert Point N°2"
      alertMessage: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla mattis, nulla vel rhoncus dictum, purus orci viverra nulla, vitae dapibus purus justo vel leo. Maecenas lacinia facilisis semper. Donec pellentesque est scelerisque dolor volutpat eleifend. Sed sed malesuada nunc. Suspendisse sodales elit at mi porta posuere. Etiam rhoncus quam vitae laoreet bibendum. Nulla tortor quam, gravida non elit eu, finibus pretium felis. Maecenas aliquam ut odio a sollicitudin. Donec auctor, ligula at efficitur lacinia, augue turpis gravida metus, tincidunt dictum nibh ante et mi. Nulla fringilla ligula a ex dignissim elementum. Integer in justo ornare, interdum urna vel, elementum nisl."
    }
  }
}