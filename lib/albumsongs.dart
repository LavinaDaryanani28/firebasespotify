import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:spotifyfirebase/AlbumModel.dart';
import 'package:spotifyfirebase/AudioPlayerModel.dart';
import 'package:spotifyfirebase/Song.dart';
import 'package:spotifyfirebase/uihelper.dart';

import 'ArtistModel.dart';
import 'artist.dart';

double _appTopBarHeight = 40;

final borderside = BorderSide(color: Colors.white, width: 2);

class AlbumSongs extends StatelessWidget {
  final AlbumModel albumModel;
  final String? artistname;
  AlbumSongs({required this.albumModel, this.artistname});

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    List<Song> albumsongs;
    if (artistname is Null) {
      albumsongs = audioPlayerModel.songs
          .where((el) =>
              el.album.toLowerCase() == albumModel.albumname.toLowerCase())
          .toList();
    } else {
      albumsongs = audioPlayerModel.songs
          .where((el) =>
              el.album.toLowerCase() == albumModel.albumname.toLowerCase() &&
              el.artist.toLowerCase() == artistname!.toLowerCase())
          .toList();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MyDelegate(albumModel: albumModel!),
              floating: true,
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            UiHelper.iconBtn(25,
                                color: Colors.white,
                                icondata: Icons.shuffle,
                                callback: () {}),
                            UiHelper.iconBtn(35,
                                color: Colors.white,
                                icondata: Icons.play_circle,
                                callback: () {}),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        UiHelper.customText("Album Songs",
                            color: Colors.white, fontsize: 25),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.network(
                                    height: 70,
                                    width: 70,
                                    albumsongs[index].photo,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      child: UiHelper.customText(
                                          albumsongs[index].songname,
                                          color: Colors.white,
                                          fontsize: 15)),
                                  // Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.more_vert),
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: albumsongs.length,
                        ),
                      ],
                    ),
                  );
                },
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
  late AlbumModel albumModel;
  MyDelegate({required this.albumModel});

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
          // flex: 1,
          child: Stack(
            children: [
              Container(
                color: Colors.black,
                height: 40,
              ),
              Opacity(
                // opacity: .2,
                opacity: 1 - shrinkPercentage,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    alignment: FractionalOffset.topCenter,
                    image: NetworkImage(
                      albumModel.photo,
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),

        //its for main bar when sliding the window
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
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          // Flexible(
                          //   child:
                          Flexible(
                            child: Opacity(
                              opacity: shrinkPercentage,
                              child: UiHelper.customText(albumModel.albumname,
                                  fontweight: FontWeight.bold,
                                  fontsize: 20,
                                  color: Colors.white),
                            ),
                          ),
                          // ),
                        ],
                      ),
                    ),
                  ),

                  Opacity(
                    opacity: max(1 - shrinkPercentage * 6, 0),
                    child: Column(
                      children: [
                        SizedBox(height: 70),
                        UiHelper.customText(albumModel.albumname,
                            fontweight: FontWeight.bold,
                            fontsize: 50,
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
