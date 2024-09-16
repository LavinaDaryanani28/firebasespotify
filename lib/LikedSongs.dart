import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:spotifyfirebase/artist.dart';
import 'package:spotifyfirebase/uihelper.dart';

import 'AudioPlayerModel.dart';

class LikedSongs extends StatefulWidget {
  const LikedSongs({super.key});

  @override
  State<LikedSongs> createState() => _LikedSongsState();
}

class _LikedSongsState extends State<LikedSongs> {
  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 40.0.h,
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UiHelper.customText('Liked Songs',
                      fontsize: 24,
                      color: Colors.white,
                      fontweight: FontWeight.bold),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: audioPlayerModel.likedSongs.length,
                  itemBuilder: (context, index) {
                    final song = audioPlayerModel.likedSongs[index];
                    return ListTile(
                      leading: Icon(Icons.music_note),
                      title: Text(song.songname),
                      // subtitle: Text(song.artist),
                      onTap: () {
                        // Update the current song and play it when tapped
                        audioPlayerModel.currentIndex =
                            index; // Update current song index
                        audioPlayerModel.playCurrentSong();
                      },
                      trailing: Icon(
                        Icons.play_arrow, // Show play icon
                        color: audioPlayerModel.isPlaying &&
                            audioPlayerModel.currentSongName == song.songname
                            ? Colors
                            .green // Show green if the current song is playing
                            : Colors.grey, // Show grey otherwise
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      // floatingActionButton: floatingActionItem,
    );
  }
}
