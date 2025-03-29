/*
 * Nostalgia screensaver.
 *
 * Usage:
 *   mount --bind ./screensaver-main.qml /usr/palm/applications/com.webos.app.screensaver/qml/main.qml
 *
 * Test launch (no way to trigger on "No signal" screen)
 *   luna-send -n 1 'luna://com.webos.service.tvpower/power/turnOnScreenSaver' '{}'
 */
import QtQuick 2.4
import Eos.Window 0.1
import QtQuick.Window 2.2

WebOSWindow {
    id: window

    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    windowType: "_WEBOS_WINDOW_TYPE_SCREENSAVER"
    color: "black"

    title: "Screensaver"
    appId: "com.webos.app.screensaver"
    visible: true
    property string basePath: '/media/developer/apps/usr/palm/applications/org.webosbrew.custom-screensaver/assets/'
    property int previousIndex: -1
    property real anY: 0
    property real anX: 0
    /*Text {
id: txx
anchors.right: parent.right
anchors.rightMargin: 20

        text: "Width: " + Screen.width + ' \nHeight: ' + Screen.height 
        color: "red"
    }*/
    Item {
        id: root

        Rectangle {
            anchors.fill: parent
            color: 'black'
        }

        Rectangle {
            id: boing

            color: 'black'

            width: image.width
            height: image.height
    function randomColor() {
        var r, g, b, luminance;
        do {
            r = Math.floor(Math.random() * 256);
            g = Math.floor(Math.random() * 256);
            b = Math.floor(Math.random() * 256);
            luminance = 0.299 * r + 0.587 * g + 0.114 * b;
        } while (luminance < 60 || luminance > 195);
        return "#" + ("0" + r.toString(16)).slice(-2) +
                     ("0" + g.toString(16)).slice(-2) +
                     ("0" + b.toString(16)).slice(-2);
    }
    function setRandomColor() {
        var newColor;
        do {
            newColor = randomColor();
        } while (newColor === boing.color);
        boing.color = newColor;
    }

             Image {
			id: image
    property var imageSources: [
        "300.png",
        "301.png",
        "302.png",
        "303.png",
        "304.png",
        "305.png",
        "306.png",
        "307.png",
        "308.png"
    ]

source: basePath + (image.imageSources[(Math.random() * image.imageSources.length) | 0])
    onStatusChanged: {
        if (status == Image.Ready) {
            boing.width = image.width;
            boing.height = image.height;
            anX = 1920 * (image.width / 28);
            anY = 1080 * (image.width / 43);
	    /*txx.text = boing.width + '   \n' + boing.height;*/
        }
    }
}

            Component.onCompleted: {
                boing.setRandomColor();
            }

            SequentialAnimation on x {
                loops: Animation.Infinite
                PropertyAnimation {
                    easing.type: Easing.Linear
                    duration: anX
                    to: Screen.width - boing.width
                }

                ScriptAction { script: boing.setRandomColor(); }
                PropertyAnimation {
                    easing.type: Easing.Linear
                    duration: anX
                    to: 0
                }
                ScriptAction { script: boing.setRandomColor(); }
            }

            SequentialAnimation on y {
                loops: Animation.Infinite
                PropertyAnimation {
                    easing.type: Easing.Linear
                    duration: anY
                    to: Screen.height - boing.height
                }
                ScriptAction { script: boing.setRandomColor(); }
                PropertyAnimation {
                    easing.type: Easing.Linear
                    duration: anY
                    to: 0
                }
                ScriptAction { script: boing.setRandomColor(); }
            }
        }
    }
}
