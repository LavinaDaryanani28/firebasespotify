import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:spotifyfirebase/ArtistModel.dart';
import 'package:spotifyfirebase/uihelper.dart';

import 'AudioPlayerModel.dart';
import 'Song.dart';
import 'artistalbums.dart';

double _appTopBarHeight = 40;

var arrContent = [
  {
    "image":
        "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
    "songname": "Lorem Ipsum1",
    "threedot": Icons.more_vert,
  },
  {
    "image":
        "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
    "songname": "Lorem Ipsum1",
    "threedot": Icons.more_vert,
  },
  {
    "image":
        "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
    "songname": "Lorem Ipsum1",
    "threedot": Icons.more_vert,
  },
  {
    "image":
        "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
    "songname": "Lorem Ipsum1",
    "threedot": Icons.more_vert,
  },
  {
    "image":
        "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
    "songname": "Lorem Ipsum1",
    "threedot": Icons.more_vert,
  },
];

class Artist extends StatelessWidget {
  late ArtistModel artistModel;
  Artist({required this.artistModel});

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    // artist = audioPlayerModel.artist.firstWhere((el) => el.name == artistname);
    // artistSongs = audioPlayerModel.songs
    //     .where((el) => el.artist == artistname.toLowerCase())
    //     .toList();

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
                                            "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg"),
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
                      UiHelper.customText("Popular",
                          color: Colors.white, fontsize: 25),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Container(
                              height: 50,
                              width: 50,
                              child: Row(
                                children: [
                                  UiHelper.customText((index + 1).toString(),
                                      color: Colors.white,
                                      fontsize: 15,
                                      fontweight: FontWeight.bold),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Image.network(
                                    artistSongs[index].photo,
                                    // arrContent[index]["image"].toString()
                                    // as String,
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
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.more_vert),
                              color: Colors.white,
                            ),
                          );
                        },
                        itemCount: artistSongs.length,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      UiHelper.customText("Popular releases",
                          color: Colors.white, fontsize: 25),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Container(
                              height: 50,
                              width: 50,
                              child: Row(
                                children: [
                                  Image.network(
                                    arrContent[index]["image"].toString()
                                        as String,
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  UiHelper.customText(
                                      arrContent[index]["songname"].toString(),
                                      color: Colors.white),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: arrContent.length,
                      ),
                      Container(
                        child: Text("About"),
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
                          //   flex: 1,
                          //   fit: FlexFit.loose,
                          //   child:
                          Opacity(
                            opacity: shrinkPercentage,
                            child: UiHelper.customText(artistModel.artistname,
                                fontweight: FontWeight.bold,
                                fontsize: 20,
                                color: Colors.white),
                          ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: max(1 - shrinkPercentage * 6, 0),
                    // opacity: max(1 - shrinkPercentage * 6, 0),
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

// import 'package:spotify/Widgets/UiHelper.dart';
// import 'package:flutter/material.dart';
//
// import '../Albums/Album.dart';
//
// class Artist extends StatefulWidget {
//   const Artist({super.key});
//
//   @override
//   State<Artist> createState() => _ArtistState();
// }
//
// class _ArtistState extends State<Artist> {
//   var arrContent = [
//     {
//       "image":
//       "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
//       "songname": "Lorem Ipsum1",
//       "threedot": Icons.more_vert,
//     },
//     {
//       "image":
//       "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
//       "songname": "Lorem Ipsum1",
//       "threedot": Icons.more_vert,
//     },
//     {
//       "image":
//       "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
//       "songname": "Lorem Ipsum1",
//       "threedot": Icons.more_vert,
//     },
//     {
//       "image":
//       "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
//       "songname": "Lorem Ipsum1",
//       "threedot": Icons.more_vert,
//     },
//     {
//       "image":
//       "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
//       "songname": "Lorem Ipsum1",
//       "threedot": Icons.more_vert,
//     },
//   ];
//   final ScrollController _controller = ScrollController();
//   final double _height = 100.0;
//
//   void _animateToIndex(int index) {
//     _controller.animateTo(
//       index * _height,
//       duration: Duration(seconds: 2),
//       curve: Curves.fastOutSlowIn,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //
//       // ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             Stack(alignment: Alignment.bottomLeft, children: [
//               Container(
//                 child: Image.network(
//                   "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
//                   fit: BoxFit.fill,opacity: const AlwaysStoppedAnimation(.7),
//                 ),
//                 width: double.infinity,
//                 height: 200,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15),
//                 child: Positioned(
//                     child: Text("Arijit Singh",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 70,
//                             fontWeight: FontWeight.bold))),
//               ),
//             ]),
//             Padding(
//               padding: const EdgeInsets.only(left: 15, top: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       UiHelper.customButton("About",fontsize:  15, fontweight:FontWeight.bold, borderradius: 25, bgcolor:Colors.transparent, forecolor:Colors.white,side: 1.0,sidecolor: Colors.white,
//                       callback: () {showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
//                         return Container(
//                           height: 350,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: NetworkImage(
//                               "https://i.scdn.co/image/ab6761610000e5eb0261696c5df3be99da6ed3f3"),
//                               fit: BoxFit.cover,
//                             ),
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(16.0),
//                               topRight: Radius.circular(16.0),
//                             ),
//                             // color: Color(0xff232f34),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 children: [
//                                 // Stack(alignment: Alignment.bottomLeft, children: [
//                                 //   Container(
//                                 //     child: Image.network(
//                                 //       "https://i.scdn.co/image/ab6761610000e5eb0261696c5df3be99da6ed3f3",
//                                 //       fit: BoxFit.fill,opacity: const AlwaysStoppedAnimation(.7),
//                                 //     ),
//                                 //     width: double.infinity,
//                                 //     height: 350,
//                                 //   ),
//                                 //   Padding(
//                                 //     padding: const EdgeInsets.only(left: 15),
//                                 //     child: Positioned(
//                                 //         child: Text("Arijit Singh",
//                                 //             style: TextStyle(
//                                 //                 color: Colors.white,
//                                 //                 fontSize: 70,
//                                 //                 fontWeight: FontWeight.bold))),
//                                 //   ),
//                                 // ]),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       });}),
//                       SizedBox(width: 10,),
//                       UiHelper.customButton("Albums",fontsize:  15, fontweight:FontWeight.bold, borderradius: 25, bgcolor:Colors.transparent, forecolor:Colors.white,side: 1.0,sidecolor: Colors.white,callback:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Album()));}),
//                       // TextButton(onPressed: (){}, child:UiHelper.customText("About", color:Colors.green, 20),),
//                       // TextButton(onPressed: (){}, child:UiHelper.customText("Album", Colors.green, 20),),
//                       Spacer(),
//                       IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.shuffle,
//                           color: Colors.green,
//                           size: 25,
//                         ),
//                       ),
//                       IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.play_circle,
//                             color: Colors.green,
//                             size: 35,
//                           )),
//                     ],
//                     // mainAxisAlignment: MainAxisAlignment.end,
//                   ),
//                   SizedBox(height: 10,),
//                   UiHelper.customText("Popular", color:Colors.white,fontsize: 25),
//                   ListView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         leading:
//                         UiHelper.customText((index+1).toString(), color:Colors.white, fontsize: 15),
//                         title: Container(
//                           height: 50,
//                           width: 50,
//                           child: Row(
//                             children: [
//                               Image.network(
//                                 arrContent[index]["image"].toString() as String,fit: BoxFit.contain,
//                               ),
//                               SizedBox(width: 15,),
//                               UiHelper.customText(arrContent[index]["songname"].toString(), color:Colors.white, fontsize: 20),
//                               // Text(arrContent[index]["songname"].toString()),
//                             ],
//                           ),
//                         ),
//                         // subtitle: Text(arrContent[index]["songname"].toString()),
//                         trailing: IconButton(onPressed: (){},icon:Icon(Icons.more_vert),
//                           color: Colors.white,
//                         ),
//                       );
//                     },
//                     itemCount: arrContent.length,
//                   ),
//                   SizedBox(height: 20,),
//                   UiHelper.customText("Popular releases", color:Colors.white, fontsize: 25),
//                   ListView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Container(
//                           height: 50,
//                           width: 50,
//                           child: Row(
//                             children: [
//                               Image.network(
//                                 arrContent[index]["image"].toString() as String,
//                                 height: 70,
//                                 width: 70,
//                                 fit: BoxFit.fill,
//                               ),
//                               SizedBox(width: 15,),
//                               Text(arrContent[index]["songname"].toString(),style: TextStyle(color: Colors.white),),
//                               // Text(arrContent[index]["songname"].toString()),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     itemCount: arrContent.length,
//                   ),
//                   Container(
//                     child: Text("About"),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//       backgroundColor: Colors.black,
//     );
//   }
// }
