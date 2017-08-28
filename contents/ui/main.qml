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
        onStatusChanged: {
            shuffleList()
        }
        playlist: Playlist {
            id: playlist
            playbackMode: Playlist.Loop
            property var videoList: load(wallpaper.configuration.Video)
        }
    }

    VideoOutput {
        fillMode: VideoOutput.PreserveAspectCrop
        anchors.fill: parent
        source: mediaplayer
    }

    function shuffleList() {
        if ( !(i % 2 == 0)) {
            j++
        }
        i++
        if ( j > playlist.itemCount ) { 
            j = 0
            i = 0
        }
        if ( j == 1 ) {
            // more random shuffling
            for (var k = 0; k < Math.ceil(Math.random() * 10) ; k++) {
                playlist.shuffle()
            }
        }
    }

}

