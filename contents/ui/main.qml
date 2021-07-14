import QtQuick 2.5
import QtMultimedia 5.14
import org.kde.plasma.core 2.0 as Plasmacore

Item {
    Video {
        id: player
        anchors.fill: parent

        autoPlay: true
        loops: MediaPlayer.Infinite // endless looping
        
        fillMode: VideoOutput.PreserveAspectCrop
        flushMode: VideoOutput.FirstFrame // remove blinking

        // Configurable part
        source: wallpaper.configuration.Video

        muted: wallpaper.configuration.Muted
        playbackRate: wallpaper.configuration.Rate
    }
}
