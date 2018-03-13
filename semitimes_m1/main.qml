//reloj/main.qml
//home/nextsigner/Escritorio/reloj/main.qml
//-folder /home/nextsigner/Escritorio/reloj
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import uk 1.0
ApplicationWindow{
	id: app
	visible:true
	width:300
	height:300
	color: "transparent"
	title: "Reloj"
	flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
	property int h: 0
	property int m: 0
	property int s: 0
	
	Rectangle{
		id: reloj
		width: 300
		height: 300
		radius: width*0.5
		color: "black"
		border.width:2
		border.color: "white"
		anchors.centerIn: parent
		clip:true
		MouseArea{
            		id: max
            		property variant clickPos: "1,1"
            		property bool presionado: false
            		anchors.fill: parent
	    		onDoubleClicked: {
                		Qt.quit()
            		}
	    		onReleased: {
                		presionado = false
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
	    		//hovered: true          
	     		onWheel: {
                		if (wheel.modifiers & Qt.ControlModifier && app.width>150) {
                    			app.width += wheel.angleDelta.y / 120
					app.height = app.width
					reloj.width = app.width
					reloj.height = app.width 
		                }
            		}
        	}
		Image{
			width: reloj.width*0.6			
			height: reloj.width*0.6
			//fillMode: Image.PreserveAspectFit
			source: "file://"+sourcePath+"/cris.png"
			//opacity: 0.65
			anchors.centerIn: parent
		}
		Item{
			width:reloj.width*0.9
			height:reloj.height*0.85
			anchors.centerIn: reloj
			Repeater{
				model:60
				Item{
					width: parent.width*0.08
					height: parent.height
					anchors.centerIn: parent
					rotation: (360/60)*index
					Rectangle{
						width:2
						height:reloj.width*0.02
						color: "red"
						anchors.horizontalCenter: parent.horizontalCenter
						//radius: width*0.5
					}
						
				}
			}
		}
		Item{
			width:reloj.width*0.9
			height:reloj.height*0.9
			anchors.centerIn: reloj
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
						color: "red"
						radius: width*0.5
						Text{
							text:modelData
							font.pixelSize: parent.width*0.6
							anchors.centerIn: parent
color: "white"
rotation: 0-((360/12)*index)
						}
					}
				}
			}
		}
		Rectangle{
			id: agujaHoras
			color: "transparent"
			height: parent.height*0.5
			width: parent.width*0.02
			anchors.centerIn: parent
			Rectangle{
				width: parent.width
				height: parent.height*0.5
				color: "red"
			}
			
		}
		Rectangle{
			id: agujaMinutos
			color: "transparent"
			height: parent.height*0.75
			width: parent.width*0.02
			anchors.centerIn: parent
			onRotationChanged:{
				if(rotation>=360){
					rotation=0
			agujaHoras.rotation=agujaHoras.rotation+(parseInt(360/12))		
				}
			}
			Rectangle{
				width: parent.width*0.65
				height: parent.height*0.5
				color: "green"
			}
		}
		Rectangle{
			id: agujaSegundos
			color: "transparent"
			height: parent.height*0.85
			width: parent.width*0.02
			anchors.centerIn: parent
			onRotationChanged:{
				if(rotation>=360){
					rotation=0
			agujaMinutos.rotation=agujaMinutos.rotation+(360/60)		
				}
			}
			Rectangle{
				width: parent.width*0.3
				height: parent.height*0.5
				color: "red"
				anchors.horizontalCenter: parent.horizontalCenter
			}
		}
		Rectangle{
			id: centro
			color: "red"
			height: width
			width: parent.width*0.03
			radius: width*0.5
			anchors.centerIn: parent
			
		}
	}

	Timer{
		id: t
		running: false
		repeat: true
		interval: 1000
		onTriggered:{
			agujaSegundos.rotation = agujaSegundos.rotation+(360/60)	
		}
	}
	Component.onCompleted:{
		var d = new Date(Date.now())
		app.h=d.getHours()
		app.m=d.getMinutes()
		app.s=d.getSeconds()
		agujaSegundos.rotation = (360/60)*app.s
		agujaMinutos.rotation = (360/60)*app.m
		agujaHoras.rotation = (360/12)*app.h
		t.start()
	}
}