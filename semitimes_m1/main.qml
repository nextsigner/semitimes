import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
ApplicationWindow{
    id: app
    visible:true
    width:300
    height:300
    color: "transparent"
    title: "semitimes m1"
    flags: Qt.platform.os !=='android'?Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint:undefined
    property int h: 0
    property int m: 0
    property int s: 0

    property color c1: "#1fbc05"
    property color c2: "#4fec35"
    property color c3: "white"
    property color c4: "black"
    property color c5: "#333333"

    FontLoader {name: "FontAwesome";source: "qrc:/fontawesome-webfont.ttf";}

    Settings{
        id: appSettings
        category:'conf-semitimes-m1'
        property real radnh:0.8
        property real radlm:0.8
        property int w: 300
        property int h: 300
        property int x: 300
        property int y: 300
    }

    Rectangle{
        id: reloj
        width: app.width
        height: app.width
        radius: width*0.5
        color: app.c5
        border.width:1
        border.color: app.c1
        anchors.centerIn: parent
        clip:true
        antialiasing: true

        MouseArea{
            id: max
            property variant clickPos: "1,1"
            property bool presionado: false
            anchors.fill: parent
            enabled: Qt.platform.os!=='android'
            onClicked: {
                xControls.width=xControls.parent.width*0.65
                xControls.visible=true
            }
            onDoubleClicked: {
                Qt.quit()
            }
            onReleased: {
                presionado = false
                appSettings.x = app.x
                appSettings.y = app.y
            }
            onPressed: {
                presionado = true
                clickPos  = Qt.point(mouse.x,mouse.y)
            }
            onPositionChanged: {
                if(presionado){
                    var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                    app.x += delta.x;
                    app.y += delta.y;
                }
            }
            onWheel: {
                if (wheel.modifiers & Qt.ControlModifier) {
                    if(app.width<150){
                        return
                    }
                    app.width += wheel.angleDelta.y / 120
                    app.height = app.width
                    reloj.width = app.width
                    reloj.height = app.width
                }
                if(app.width<=149){
                    app.width=151
                    app.height = app.width
                }
                appSettings.x = app.x
                appSettings.y = app.y
                appSettings.w = app.width
                appSettings.h = app.height
            }
        }

        MouseArea{
            id: maxAndroid
            property variant clickPos: "1,1"
            property bool presionado: false
            anchors.fill: parent
            enabled: Qt.platform.os!=='android'
            onDoubleClicked: {
                Qt.quit()
            }
           onClicked: {
               xControls.width=xControls.parent.width*0.65
               xControls.visible=true
           }
        }

        Rectangle{
            smooth: true
            width: 1
            height: parent.height*0.6
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: app.c5;
                }
                GradientStop {
                    position: 0.5;
                    color: "#ffffff";
                }
                GradientStop {
                    position: 1.00;
                    color: app.c5;
                }
            }
            anchors.centerIn: parent
            opacity: 0.5
        }
        Rectangle{
            rotation: 90
            smooth: true
            width: 1
            height: parent.height*0.6
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: app.c5;
                }
                GradientStop {
                    position: 0.5;
                    color: "#ffffff";
                }
                GradientStop {
                    position: 1.00;
                    color: app.c5;
                }
            }
            anchors.centerIn: parent
            opacity: 0.5
        }

        Rectangle{
            id:xMH
            //width:!app.width*appSettings.radnm % 2 ? app.width*appSettings.radnm : app.width*appSettings.radnm+1
            width: reloj.width*appSettings.radlm
            height:width
            anchors.centerIn: reloj
            color: "transparent"
            Repeater{
                model:60
                Item{
                    width: !reloj.width*0.005 % 2 ? (reloj.width*0.005)+1 : reloj.width*0.005
                    height: parent.height
                    anchors.centerIn: parent
                    rotation: (360/60)*index
                    Rectangle{
                        width: parent.width
                        height: parent.height*0.02
                        color: app.c2
                        anchors.horizontalCenter: parent.horizontalCenter
                        antialiasing: true
                    }
                }
            }
        }

        Rectangle{
            width:!reloj.width*appSettings.radnh % 2 ? reloj.width*appSettings.radnh : reloj.width*appSettings.radnh+1
            height:width
            anchors.centerIn: reloj
            color: "transparent"
            Repeater{
                model:["12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
                Item{
                    width: parent.width*0.08
                    height: parent.height
                    anchors.centerIn: parent
                    rotation: (360/12)*index
                    Rectangle{
                        width:parent.width
                        height:width
                        color: app.c1
                        border.color: app.c2
                        border.width: 1
                        radius: width*0.5
                        Text{
                            text:modelData
                            font.pixelSize: parent.width*0.6
                            anchors.centerIn: parent
                            color: app.c5
                            rotation: 0-((360/12)*index)
                        }
                    }
                }
            }
        }


        Rectangle{
            id: agujaMinutos
            color: "transparent"
            height: parent.height*0.75
            width: !parent.width*0.02 % 2 ? parent.width*0.02 : parent.width*0.02+1
            anchors.centerIn: parent
            antialiasing: true
            Rectangle{
                width: parent.width/2
                height: parent.height*0.5
                color: app.c2
                anchors.horizontalCenter: parent.horizontalCenter
                antialiasing: true
            }
        }
        Rectangle{
            id: agujaHoras
            color: "transparent"
            height: parent.height*0.5
            width: !parent.width*0.02 % 2 ? parent.width*0.02 : parent.width*0.02+1
            anchors.centerIn: parent
            Rectangle{
                width: parent.width
                height: parent.height*0.5
                color: "red"
                antialiasing: true
            }
        }
        Rectangle{
            id: agujaSegundos
            color: "transparent"
            height: parent.height*0.8
            width: !parent.width*0.01 % 2 && parent.width*0.01>0 ? parent.width*0.01 : parent.width*0.01+1
            anchors.centerIn: parent
            Rectangle{
                width: parent.width/2
                height: parent.height*0.5
                color: "red"
                anchors.horizontalCenter: parent.horizontalCenter
                antialiasing: true
            }
        }
        Rectangle{
            id: centro
            color: "red"
            height: width
            width: parent.width*0.05
            radius: width*0.5
            anchors.centerIn: parent
        }
        Rectangle{
            id: xControls
            color: app.c5
            border.width: 1
            border.color: app.c2
            height: width
            width: !visible?0:parent.width*0.65
            visible: false
            radius: width*0.5
            anchors.centerIn: parent
            onWidthChanged:{
                if(width===0){xControls.visible=false}
            }
            Behavior on width {
                NumberAnimation {
                    target: xControls
                    property: "width"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: xControls
                    property: "height"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
            property var a: ['\uf0a8','\uf2d2','\uf011']
            Repeater{
                model:3
                Item{
                    width: parent.width*0.2
                    height: parent.height*0.8
                    anchors.centerIn: parent
                    rotation: (360/3)*index
                    Boton{
                        t: xControls.a[index]
                        w: parent.width
                        h: w
                        r: w*0.5
                        b: app.c1
                        c: app.c5
                        s: w*0.7
                        rotation: 0-(360/3)*index
                        onClicking:{
                            xControls.run(index)
                        }
                    }
                }
            }
            function run(index){
                if(index===0){
                    xControls.width=0
                }
                if(index===1){
                    if(Qt.platform.os==='android'){
                        var j=unik.getPath(3)+'/unik/config.json'
                        var f=unik.getPath(3)+'/unik/semitimes_m1'
                        var c='{"mode":"-folder", "arg1":"'+f+'"}'
                        unik.setFile(j, c)
                        unik.restartApp()
                    }else{
                        app.close()
                    }
                }
                if(index===2){
                    Qt.quit()
                }
            }
        }
    }

    Timer{
        id: t
        running: true
        repeat: true
        interval: 1000
        onTriggered:{
            tic()
        }
    }

    function tic(){
        var d = new Date(Date.now())
        app.h=d.getHours()
        app.m=d.getMinutes()
        app.s=d.getSeconds()
        if(agujaSegundos.rotation>353&&agujaSegundos.rotation<360){
            agujaSegundos.rotation = 0
        }else{
            agujaSegundos.rotation = (360/60)*app.s
        }
        var prm = agujaSegundos.rotation/360*100
        var prm2 = (60/100*prm)/60
        agujaMinutos.rotation =(360/60)*app.m + (360/60)*(prm2)

        var prh = agujaMinutos.rotation/360*100
        var prh2 = (12/100*prh)/12
        agujaHoras.rotation = (360/12)*app.h + (360/12)*(prh2)
    }

    Component.onCompleted:{
        appSettings.radnh = 0.98
        appSettings.radlm = 0.8
        app.width = appSettings.w
        app.height = appSettings.h
        app.x = appSettings.x
        app.y = appSettings.y
        tic()
    }
}
