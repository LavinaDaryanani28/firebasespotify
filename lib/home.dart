import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:spotifyfirebase/albumsongs.dart';
import 'package:spotifyfirebase/artist.dart';
import 'package:spotifyfirebase/uihelper.dart';
import 'AudioPlayerModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _searchQuery = '';
  String greetings() {
    DateTime now = DateTime.now();
    int hours = now.hour;

    if (hours < 12)
      return "Morning";
    else if (hours < 13)
      return "Noon";
    else if (hours < 16) return "Afternoon";
    return "Evening";
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    // Filter the list based on the search query
    final filteredSongs = audioPlayerModel.songs
        .where((song) => song.songname.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80.0.h, //set your height
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UiHelper.customText("Good " + greetings() + "!",
                      color: Colors.white,
                      fontsize: 30,
                      fontweight: FontWeight.bold),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Artist List
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UiHelper.customText('Artists',
                      fontsize: 24,
                      color: Colors.white,
                      fontweight: FontWeight.bold),
                ),
                Container(
                  height: 120.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: audioPlayerModel.artist.length,
                    itemBuilder: (context, index) {
                      final artist = audioPlayerModel.artist[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Artist(
                                        artistModel: artist,
                                      )));
                        },
                        child: Container(
                            // color: Colors.grey,
                            height: double.infinity,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 8.0, bottom: 8.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(artist.photo),
                                    radius: 40,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    artist.artistname,
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow
                                        .ellipsis, // Adds '...' at the end of the truncated text
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            )),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UiHelper.customText('Albums',
                      fontsize: 24,
                      color: Colors.white,
                      fontweight: FontWeight.bold),
                ),
                Container(
                  height: 150.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: audioPlayerModel.album.length,
                    itemBuilder: (context, index) {
                      final album = audioPlayerModel.album[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AlbumSongs(albumModel:album)));
                        },
                        child: Container(
                          height: double.infinity,
                          width: 115,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8.0, bottom: 8.0),
                            child: Column(
                              children: [
                                Image.network(
                                  album.photo,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  album.albumname,
                                  style: TextStyle(color: Colors.white),
                                  overflow: TextOverflow
                                      .ellipsis, // Adds '...' at the end of the truncated text
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UiHelper.customText('Songs',
                      fontsize: 24, color: Colors.white),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: audioPlayerModel.songs.length,
                  itemBuilder: (context, index) {
                    final song = audioPlayerModel.songs[index];
                    return ListTile(
                      leading: Icon(Icons.music_note,color: Colors.white,),
                      title: Text(song.songname,style:TextStyle(color: Colors.white)),
                      subtitle: Row(
                        children: [
                          Text(song.artist,style:TextStyle(color: Colors.grey)),
                          audioPlayerModel.isPlaying && audioPlayerModel.currentSongName ==
                              song.songname?Icon(Icons.graphic_eq,color: Colors.green,):SizedBox.shrink()
                        ],
                      ),
                      onTap: () {
                        // Update the current song and play it when tapped
                        audioPlayerModel.currentIndex =
                            index; // Update current song index
                        audioPlayerModel.playCurrentSong();
                      },
                      trailing: Icon(
                        audioPlayerModel.isPlaying &&
                            audioPlayerModel.currentSongName ==
                                song.songname
                            ? Icons.pause  // Show green if the current song is playing
                            : Icons.play_arrow, // Show play icon
                        color: audioPlayerModel.isPlaying &&
                                audioPlayerModel.currentSongName ==
                                    song.songname
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
    );
  }
}
