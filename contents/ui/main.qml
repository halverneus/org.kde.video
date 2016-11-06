import QtQuick 2.5
import QtMultimedia 5.5
import org.kde.plasma.core 2.0 as Plasmacore

Item {
    MediaPlayer {
        id: mediaplayer
        autoPlay: true
        muted: wallpaper.configuration.Muted
        loops: MediaPlayer.Infinite
        source: wallpaper.configuration.Video
    }

    VideoOutput {
        fillMode: VideoOutput.PreserveAspectCrop
        anchors.fill: parent
        source: mediaplayer
    }
}

