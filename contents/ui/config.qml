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
    
    FileDialog {
        id: fileDialog
        title: "Pick a video file"
        nameFilters: [ "Video files (*.mp4 *.mpg *.ogg *.mov *.webm *.flv *.matroska *.avi)", "All files (*)" ]
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
}
