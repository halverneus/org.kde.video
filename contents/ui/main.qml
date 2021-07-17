import QtQuick 2.5
import QtMultimedia 5.14
import org.kde.plasma.core 2.0 as Plasmacore

Item {
    property var lastVideoUrl: "" // variable for fixing useless playback reloadings ( Ex: when you open Desktop Folder Settings )

    Video {
        id: player
        anchors.fill: parent

        autoPlay: true

        fillMode: VideoOutput.PreserveAspectCrop
        flushMode: VideoOutput.LastFrame // remove blinking

        // Configurable part
        muted: wallpaper.configuration.Muted
        playbackRate: wallpaper.configuration.Rate

        // Source setup
        playlist: Playlist {
            id: playlist
            playbackMode: wallpaper.configuration.Shuffle ? Playlist.Random : Playlist.Loop

            // Simple hack for video changing detection
            property var watchDog: wallpaper.configuration.Video
            onWatchDogChanged: loadPlaylist()

            // Ensure that we will load playlist on startup
            Component.onCompleted: loadPlaylist()
        }
    }

    // Load playlist ( or video as playlist )
    function loadPlaylist() {
        var url = wallpaper.configuration.Video;

        // Reload playlist only if file was changed
        if (url != lastVideoUrl){
            if (playlist.currentIndex != -1) playlist.clear() // cleanup playlist

            var extension = url.split(".").pop();

            if (extension == "m3u") {
                playlist.load(url, "m3u");
            } else if (extension == "m3u8") {
                playlist.load(url, "m3u8");
            // File not a playlist
            } else {
                playlist.addItem(url);
            }

            //console.log("Added " + url + "; Last video " + lastVideoUrl) // Debug message
            lastVideoUrl = url // update last video

            player.play() // resume player
        }
    }
}

/* Advices: */
// Q: How to debug this beautiful thing?
// A: Restart plasma from your terminal emulator, so you will see all the debug info. 
//    You can do it with the following command:
//    sudo killall plasmashell && kstart5 plasmashell 