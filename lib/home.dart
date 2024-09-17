import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:spotifyfirebase/albums.dart';
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
  bool _isSearching = false;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 140.0.h, //set your height
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UiHelper.customText("Good " + greetings(),
                      color: Colors.white,
                      fontsize: 30,
                      fontweight: FontWeight.bold),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children:[ TextField(
                        decoration: InputDecoration(
                          labelText: 'Search',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged:  (query) {
                          setState(() {
                            _searchQuery = query;
                            _isSearching = query.isNotEmpty;
                          });
                          // Call the search function whenever the query changes
                          audioPlayerModel.searchSongs(query);
                        },
                      ),
                      if (_isSearching && audioPlayerModel.searchResults.isNotEmpty)
                        // Expanded(
                        //     child: ListView.builder(
                        //       itemCount: audioPlayerModel.searchResults.length,
                        //       itemBuilder: (context, index) {
                        //         final song = audioPlayerModel.searchResults[index];
                        //         return ListTile(
                        //           title: Text(song['songname']),
                        //           onTap: () {
                        //             // Play the selected song
                        //             audioPlayerModel.playCurrentSong(); // Play the song URL
                        //             setState(() {
                        //               _searchQuery = song['songname'];
                        //               _isSearching = false;
                        //             });
                        //           },
                        //         );
                        //       },
                        //     ),
                        // ),
                        DropdownButton<String>(
                          items: audioPlayerModel.searchResults.map((song) {
                            final songName = song['songname'];
                            // Debugging: Check if the song name is correctly fetched
                            log('Song found: $songName');
                            return DropdownMenuItem<String>(
                              value: song['songname'],
                              child: Text(song['songname']??"Unknown song",style: TextStyle(color: Colors.white),),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value!;
                              _isSearching = false;
                            });
                            audioPlayerModel.playCurrentSong();
                          },
                          isExpanded: true,
                          hint: Text("Select a song",style: TextStyle(color: Colors.black),),
                        ),

                      // Hide this message if searching
                      if (_isSearching && audioPlayerModel.searchResults.isEmpty)
                        Center(child: Text('No songs found')),
                  // if (!_isSearching)
                  //   Expanded(
                  //     child: ListView.builder(
                  //       itemCount: audioPlayerModel.songs.length,
                  //       itemBuilder: (context, index) {
                  //         final song = audioPlayerModel.songs[index];
                  //         return ListTile(
                  //           title: Text(song.songname),
                  //           onTap: () {
                  //             // Play the song when tapped
                  //             audioPlayerModel.playCurrentSong();
                  //           },
                  //         );
                  //       },
                  //     ),
                  //   ),
                  ],),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        // decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topLeft,
        //       end: Alignment.center,
        //       colors:
        //     [Color(0xff7f4053),Colors.black38],
        //     )
        // ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SliverStickyHeaderBuilder(builder: (context,i)=>Text("Good morning")),
                // CustomScrollView(
                //   slivers: [
                //     SliverAppBar(
                //       backgroundColor: Colors.black,
                //       title: Text("Good morning"),
                //       floating: true,
                //       pinned: true,
                //     )
                //   ],
                // ),
                // TopBar(),
                // UiHelper.customText("Good Morning",color: Colors.white,fontsize: 30),
                // SizedBox(height: 10,),
                // TextField(
                //   decoration: InputDecoration(
                //     labelText: 'Search',
                //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                //     prefixIcon: Icon(Icons.search),
                //   ),
                // ),
                SizedBox(height: 30,),

                // Artist List
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UiHelper.customText('Artists',
                      fontsize: 24,
                      color: Colors.white,
                      fontweight: FontWeight.bold),
                ),
                Container(
                  height: 130.h,
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
                              MaterialPageRoute(builder: (context) => Album(albumModel:album)));
                        },
                        child: Container(
                          // color: Colors.grey,
                          height: double.infinity,
                          width: 115,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8.0, bottom: 8.0),
                            // color: Colors.white,
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
                      leading: Icon(Icons.music_note),
                      title: Text(song.songname),
                      subtitle: Text(song.artist),
                      onTap: () {
                        // Update the current song and play it when tapped
                        audioPlayerModel.currentIndex =
                            index; // Update current song index
                        audioPlayerModel.playCurrentSong();
                      },
                      trailing: Icon(
                        Icons.play_arrow, // Show play icon
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
      // floaingActionButton: floatingActionItem,
    );
  }
}
