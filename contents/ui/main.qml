import QtQuick 2.5
import QtMultimedia 5.6
import org.kde.plasma.core 2.0 as Plasmacore

Item {
    property var i: 0
    property var j: 0
    MediaPlayer {
        id: mediaplayer
        autoPlay: true
        muted: wallpaper.configuration.Muted
        loops: MediaPlayer.Infinite
        //source: wallpaper.configuration.Video
        playbackRate: wallpaper.configuration.Rate
        playlist: Playlist {
            id: playlist
            playbackMode: Playlist.Loop
            property var loaded: playlist.load(wallpaper.configuration.Video)
            onLoaded: shuffleList()
        }
    }

    VideoOutput {
        fillMode: VideoOutput.PreserveAspectCrop
        anchors.fill: parent
        source: mediaplayer
    }
    
    function shuffleList() {
        try {
            mediaplayer.pause();
            for (var i = Math.floor(Math.random() * playlist.itemCount); i; i--)
                playlist.shuffle();
            mediaplayer.play();
        } catch (e) {
            console.log("Error in shuffle", e);
        }
    }

}

