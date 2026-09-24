/* Slideshow shown while Alnix installs. */
import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation
{
    id: presentation

    Timer {
        interval: 12000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }

    Rectangle {
        anchors.fill: parent
        color: "#1b1b1b"
        z: -1
    }

    component InfoSlide: Slide {
        property string title
        property string body
        Column {
            anchors.centerIn: parent
            width: parent.width * 0.8
            spacing: 18
            Image {
                source: "logo.png"
                width: 96; height: 96
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text {
                text: title
                color: "#ffffff"
                font.pixelSize: 26
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
            Text {
                text: body
                color: "#d0d0d0"
                font.pixelSize: 16
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
        }
    }

    InfoSlide {
        title: qsTr("Welcome to Alnix")
        body: qsTr("Alnix is being installed on your computer. This usually takes a few minutes.")
    }
    InfoSlide {
        title: qsTr("Get apps from Discover")
        body: qsTr("Open Discover from the app menu to install apps like Steam, Spotify, LibreOffice and thousands more with one click.")
    }
    InfoSlide {
        title: qsTr("Updates are one click away")
        body: qsTr("When updates are ready, a notification appears. Click it, then click Update All in Discover.")
    }
    InfoSlide {
        title: qsTr("You can always go back")
        body: qsTr("Alnix saves a snapshot of your system before every update. If something goes wrong, pick an earlier snapshot from the boot menu, then open Btrfs Assistant to restore it.")
    }
    InfoSlide {
        title: qsTr("Protected by default")
        body: qsTr("The firewall is on, and your account needs your password to make system changes.")
    }

    function onActivate() {
        presentation.currentSlide = 0;
    }
    function onLeave() {
    }
}
