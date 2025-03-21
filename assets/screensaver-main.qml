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

    width: 1920
    height: 1080

    windowType: "_WEBOS_WINDOW_TYPE_SCREENSAVER"
    color: "black"

    title: "Screensaver"
    appId: "com.webos.app.screensaver"
    visible: true

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

            function setRandomColor() {
                var colors = ['#f00', '#0f0', '#00f', '#ff0', '#f0f', '#0ff', '#fff', '#ffa500', '#800080', '#008000', '#000080', '#ffc0cb', '#a52a2a', '#808080', '#ffffe0', '#add8e6', '#d3d3d3', '#ff6347', '#4682b4', '#ff1493', '#ff4500', '#32cd32', '#1e90ff', '#9370db', '#ff69b4', '#7fff00', '#00ced1', '#ffb6c1', '#d2691e', '#b22222', '#6495ed'];

                var index = (Math.random() * colors.length) | 0;
                boing.color = colors[index];
            }

             Image {
			id: image
			source: "/media/developer/apps/usr/palm/applications/org.webosbrew.custom-screensaver/assets/300.png"
			Timer {
				interval: 100
				running: true
				repeat: true
				onTriggered: {
					if (image.width > 0 && image.height > 0) {
						boing.width = image.width;
						boing.height = image.height;
						this.stop();
					}
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
                    duration: 1920 * 11
                    to: 1920 - boing.width
                }

                ScriptAction { script: boing.setRandomColor(); }
                PropertyAnimation {
                    easing.type: Easing.Linear
                    duration: 1920 * 11
                    to: 0
                }
                ScriptAction { script: boing.setRandomColor(); }
            }

            SequentialAnimation on y {
                loops: Animation.Infinite
                PropertyAnimation {
                    easing.type: Easing.Linear
                    duration: 1080 * 7
                    to: 1080 - boing.height
                }
                ScriptAction { script: boing.setRandomColor(); }
                PropertyAnimation {
                    easing.type: Easing.Linear
                    duration: 1080 * 7
                    to: 0
                }
                ScriptAction { script: boing.setRandomColor(); }
            }
        }
    }
}
