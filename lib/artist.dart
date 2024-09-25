import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotifyfirebase/ArtistModel.dart';
import 'package:spotifyfirebase/uihelper.dart';
import 'AudioPlayerModel.dart';
import 'Song.dart';
import 'artistalbums.dart';

double _appTopBarHeight = 40;

class Artist extends StatelessWidget {
  late ArtistModel artistModel;
  Artist({required this.artistModel});

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    List<Song> artistSongs = audioPlayerModel.songs
        .where((el) =>
            el.artist.toLowerCase() == artistModel.artistname.toLowerCase())
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MyDelegate(artistModel: artistModel),
              floating: true,
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          UiHelper.customButton("About",
                              fontsize: 15,
                              fontweight: FontWeight.bold,
                              borderradius: 25,
                              bgcolor: Colors.transparent,
                              forecolor: Colors.white,
                              side: 1.0,
                              sidecolor: Colors.white, callback: () {
                            showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 350,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            artistModel.photo),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                    ),
                                  );
                                });
                          }),
                          SizedBox(
                            width: 10,
                          ),
                          UiHelper.customButton("Albums",
                              fontsize: 15,
                              fontweight: FontWeight.bold,
                              borderradius: 25,
                              bgcolor: Colors.transparent,
                              forecolor: Colors.white,
                              side: 1.0,
                              sidecolor: Colors.white, callback: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ArtistAlbums(
                                        artistModel: artistModel)));
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      UiHelper.customText("Popular",
                          color: Colors.white, fontsize: 25),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          bool isSongPlaying = audioPlayerModel.currentSongUrl == artistSongs[index].url && audioPlayerModel.isPlaying;
                          return ListTile(
                            title: Container(
                              height: 50,
                              width: 50,
                              child: Row(
                                children: [
                                  Image.network(
                                    artistSongs[index].photo,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: UiHelper.customText(
                                        artistSongs[index].songname,
                                        color: Colors.white,
                                        fontsize: 20),
                                  ),
                                ],
                              ),
                            ),
                            trailing:  IconButton(
                              icon: Icon(
                                isSongPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                if (isSongPlaying && audioPlayerModel.currentSongName == artistSongs[index].songname) {
                                  // If the song is already playing, pause it
                                  audioPlayerModel.pause();
                                } else {
                                  // Play the selected song
                                  audioPlayerModel.setCurrentSongFromAlbum(artistSongs, index);
                                  audioPlayerModel.play();
                                }
                              },
                            ),
                          );
                        },
                        itemCount: artistSongs.length,
                      )
                    ],
                  ),
                ),
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  late ArtistModel artistModel;
  MyDelegate({required this.artistModel});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var shrinkPercentage =
        min(1, shrinkOffset / (maxExtent - minExtent)).toDouble();

    return Stack(
      clipBehavior: Clip.hardEdge,
      fit: StackFit.expand,
      children: [
        //how top bar will change while scrolling the screen
        Container(
          child: Stack(
            children: [
              Container(
                color: Colors.black,
                height: 40,
              ),
              Opacity(
                opacity: 1 - shrinkPercentage,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    alignment: FractionalOffset.topCenter,
                    image: NetworkImage(artistModel.photo),
                  )),
                ),
              ),
            ],
          ),
        ),

        //main bar when sliding the window
        Stack(
          clipBehavior: Clip.hardEdge,
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  //small top bar
                  Container(
                    height: _appTopBarHeight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Opacity(
                            opacity: shrinkPercentage,
                            child: UiHelper.customText(artistModel.artistname,
                                fontweight: FontWeight.bold,
                                fontsize: 20,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: max(1 - shrinkPercentage * 6, 0),
                    child: Column(
                      children: [
                        SizedBox(height: 70),
                        UiHelper.customText(artistModel.artistname,
                            fontweight: FontWeight.bold,
                            fontsize: 60,
                            color: Colors.white),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => 200; //maximum height for the image

  @override
  double get minExtent => 50; //minimum height for the image

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
