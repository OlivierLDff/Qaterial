import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QQuickMaterialHelper.Components 1.12
import QQuickMaterialHelper.Containers 1.12
import QQuickMaterialHelper.Style 1.12
/**
  * @brief Manager that creates snack bar dinamically
  */
Item {
    /**
      * Public
      */


    
    readonly property real fadeTime: 300
    readonly property real defaultTime: 3000
    property real time: defaultTime



    /**
      * @brief Shows a snackbar
      *
      * @param {string} text Text to show
      * @param {real} duration Duration to show in milliseconds, defaults to 3000
      */
    /**
      * Private
      */
    id: root

    z: Infinity


    Component 
    {
      id:_snackbarComp
    
    Snackbar {
      id : _snackbar

      
      onActionPressed :
       {
          if(root.settings && root.settings.onAccept){
              root.settings.onAccept()
                _snackbarLoader.sourceComponent = null // close snack bar because the user have made his choice
           }
          

        }
     text : root.settings && root.settings.text ? root.settings.text : ""
     action: root.settings && root.settings.action ? root.settings.action: ""


        Component.onCompleted: 
        {
      
        if (typeof root.settings.timeout !== "undefined") { // checks if parameter was passed
            time = Math.max(root.settings.timeout , 5 * fadeTime);
        }
        else {
            time = defaultTime;
        }

        animation.start();
   
        }

        SequentialAnimation on opacity {
        id: animation
        running: false 


        NumberAnimation {
            to: 1
            duration: fadeTime
        } 

        PauseAnimation {
            duration: time - 2 * fadeTime
        } 

        NumberAnimation {
            to: 0
            duration: fadeTime
        }

        onRunningChanged: {
            if (!running ) {
                _snackbarLoader.sourceComponent = null

            if(root.settings && root.settings.onClose){
             root.settings.onClose()
           }
            
                root.nextSnackbar() // to know if other snack bar is required 
    }
    } // onRunningChanged

}  //sequential animation
}  //snackbar
}  // component

 Loader{
  anchors.horizontalCenter: parent.horizontalCenter
  anchors.bottom : parent.bottom
  id: _snackbarLoader
 }

 property var settings: null
 property var settingsCurrent : null
 property var settingsArray : []

//function to show a snack bar prepared in paramters
   function show(snackbarManagerSettings) {

        if(_snackbarLoader.sourceComponent){
          settingsArray.push(snackbarManagerSettings)
        }
        else{
          settings = snackbarManagerSettings
          _snackbarLoader.sourceComponent = _snackbarComp
        }
     }



 // function to load the next snack bar recorded before  
    function nextSnackbar (){
        if (settingsCurrent = settingsArray.shift())
            show (settingsCurrent)

    }
        
       
    }
