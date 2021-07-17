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
    property bool cfg_Shuffle;

    /* Main layout with the whole content. Used to prevent vertical scaling */
    ColumnLayout {
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
        // Node for programmer: 
        //   - If you want to add some more checkboxes or categories, please unify them with custom base component ( qml "component" keyword). 
        //     For now it's useless ( because of small amount of code ), but it will help you to avoid rewriting the same props every time
        RowLayout {
            // Properties ( used for easier content management )
            property int itemWidth: 220 // All items in the layout will have equal width. Must be bigger than minimal width of any of items
            property int itemHeight: height // Force all items to have the same height 

            // Layout settings
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            GroupBox {
                title: "Audio Settings"
                Layout.preferredWidth: parent.itemWidth 
                Layout.preferredHeight: parent.itemHeight

                CheckBox {
                    text: "Muted"
                    anchors.horizontalCenter: parent.horizontalCenter // center checkbox

                    checked: wallpaper.configuration.Muted
                    onCheckedChanged: { cfg_Muted = checked }
                }
            } // audio settings GroupBox

            GroupBox {
                title: "Playlist Settings"
                Layout.preferredWidth: parent.itemWidth
                Layout.preferredHeight: parent.itemHeight

                CheckBox {
                    text: "Shuffle"
                    anchors.horizontalCenter: parent.horizontalCenter // center checkbox
                    
                    checked: wallpaper.configuration.Shuffle
                    onCheckedChanged: { cfg_Shuffle = checked }
                }
            } // playlist settings GroupBox

            GroupBox {
                title: "Playback Rate"
                Layout.preferredWidth: parent.itemWidth 
                Layout.preferredHeight: parent.itemHeight

                // Setup playback-rate slider
                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter // center in the group box

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
            } // video settings ( playback rate )

        } // settings RowLayout  
    } // main ColumnLayout ( with all content )
} // root ColumnLayout 