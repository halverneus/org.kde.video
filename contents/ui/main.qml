import QtQuick 2.5
import QtMultimedia 5.6
import org.kde.plasma.core 2.0 as Plasmacore

Item {
    MediaPlayer {
        id: mediaplayer
        autoPlay: true
        muted: wallpaper.configuration.Muted
        playbackRate: wallpaper.configuration.Rate

        playlist: Playlist {
            id: playlist
            playbackMode: Playlist.Random
            property var loaded: loadPlayList()
        }
    }

    VideoOutput {
        fillMode: VideoOutput.PreserveAspectCrop
        anchors.fill: parent
        source: mediaplayer
    }

    function loadPlayList() {
        playlist.clear();

        var url = wallpaper.configuration.Video;
        var extension = url.split(".").pop();

        if (extension == "m3u" || extension == "m3u8") {
            playlist.load(url);
        } else {
            playlist.addItem(url);
        }

        if (MediaPlayer.playbackState != MediaPlayer.PlayingState) {
            mediaplayer.play();
        }

        return true;
    }
}
