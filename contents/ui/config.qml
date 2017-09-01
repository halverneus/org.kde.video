import QtQuick 2.5
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.2
import org.kde.plasma.core 2.0 as PlasmaCore

ColumnLayout {
    id: root
    property string cfg_Video
    property string cfg_Folder
    property bool cfg_Muted
    property double cfg_Rate

    GroupBox {
        title: "File picker"
        Layout.fillWidth: true
        GridLayout {
            columns: 2

            Rectangle {
                width: 256
                height: 144
                color: "transparent"
                PlasmaCore.IconItem {
                    source: "org.kde.plasma.clipboard"
                    anchors.fill: parent
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {fileDialog.folder = cfg_Folder; fileDialog.open() }
                    }
                }
            }
            
        }
    }
    
    
    GroupBox {
        Layout.fillWidth: true
        TextField {
            anchors.fill: parent
            placeholderText: qsTr("Video file or playlist")
            readOnly: true
            text: cfg_Video.toString().replace(/^file:\/\//,'')
            style: TextFieldStyle {
                background: Rectangle {
                    radius: 2
                    implicitWidth: 100
                    implicitHeight: 24
                    color: "#eee"
                }
            }
        }
    }
    
    FileDialog {
        id: fileDialog
        title: "Pick a video file"
        nameFilters: [ "Video files (*.mp4 *.mpg *.ogg *.mov *.webm *.flv *.matroska *.avi *.m3u)", "All files (*)" ]
        onAccepted: {
            cfg_Video = fileDialog.fileUrls[0]
            cfg_Folder = fileDialog.folder
        }
    }
    
    GroupBox {
        title: "Audio"
        Layout.fillWidth: true
        RadioButton {
            text: "Muted"
            checked: wallpaper.configuration.Muted
            onCheckedChanged: {
                    if (checked)
                        { cfg_Muted = true }
                    else
                        { cfg_Muted = false }
            }
        }
    }

    GroupBox {
        title: "Playback Rate"
        Slider {
            value: wallpaper.configuration.Rate
            onValueChanged: {
                cfg_Rate = value
            }
        }
    }
}
