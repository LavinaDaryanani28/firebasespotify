import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:spotifyfirebase/AlbumModel.dart';
import 'package:spotifyfirebase/AudioPlayerModel.dart';
import 'package:spotifyfirebase/albumsongs.dart';
import 'package:spotifyfirebase/uihelper.dart';
import 'ArtistModel.dart';

double _appTopBarHeight = 40;
final borderside = BorderSide(color: Colors.white, width: 2);

class ArtistAlbums extends StatelessWidget {
  late ArtistModel artistModel;
  ArtistAlbums({required this.artistModel});

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    List<AlbumModel> albums = audioPlayerModel.album
        .where((el) => artistModel.albums.contains(el.albumname))
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
                (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
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
                        })
                      ],
                    ),
                  );
                },
                childCount:1, // SliverList displaying 20 items, each on a ListTile
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AlbumSongs(
                                    albumModel: albums[index],
                                    artistname: artistModel.artistname)));
                      },
                      child: Column(
                        children: [
                          Container(
                            child: Image.network(
                              albums[index].photo,
                              fit: BoxFit.fill,
                            ),
                            height: 95.h,
                            width: double.infinity,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: UiHelper.customText(
                                  albums[index].albumname,
                                  color: Colors.white,
                                  fontsize: 15,
                                  fontweight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
                childCount: albums.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10, //for size of whole box
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
                    image: NetworkImage(
                      artistModel.photo,
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