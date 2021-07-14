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

    /* Main layout with the whole content. Used to prevent vertical scaling */
    ColumnLayout{
        Layout.fillWidth: true
        Layout.fillHeight: false
        Layout.alignment: Qt.AlignTop

        FileDialog {
            id: fileDialog
            title: "Pick a video file"
            nameFilters: [ "Video files (*.mp4 *.mpg *.ogg *.mov *.webm *.flv *.mkv *.matroska *.avi *.m3u *.m3u8)", "All files (*)" ]
            onAccepted: {
                cfg_Video = fileDialog.fileUrls[0]
                cfg_Folder = fileDialog.folder
            }
        }

        // Video file selector 
        RowLayout {    
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

            GridLayout {
                columns: 2

                Rectangle {
                    // w:h = 1:1
                    width: 48
                    height: 48 
                    color: "transparent"
                    PlasmaCore.IconItem {
                        source: "folder-open"
                        anchors.fill: parent
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {fileDialog.folder = cfg_Folder; fileDialog.open() }
                        }
                    }
                }
            }
        } // file selector RowLayout

        // Settings layout ( audio + video params )
        RowLayout {
            property int layoutHeight: 500

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            GroupBox {
                title: "Audio settings"
                Layout.preferredWidth: parent.width / 2 // All items in the layout will have equal width 
                Layout.preferredHeight: parent.height

                CheckBox {
                    text: "Muted"
                    anchors.horizontalCenter: parent.horizontalCenter

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
                Layout.preferredHeight: parent.height // Force all items to have the same height

                // Setup playback-rate slider 
                Slider {
                    minimumValue: 0
                    maximumValue: 1.0
                    stepSize: 0.01
                    
                    value: wallpaper.configuration.Rate
                    onValueChanged: {
                        cfg_Rate = value
                    }
                }
            }
        } // settings RowLayout  
    } // main ColumnLayout ( with all content )
} // root ColumnLayout 