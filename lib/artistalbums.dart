import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:spotifyfirebase/AlbumModel.dart';
import 'package:spotifyfirebase/AudioPlayerModel.dart';
import 'package:spotifyfirebase/Song.dart';
import 'package:spotifyfirebase/albumsongs.dart';
import 'package:spotifyfirebase/uihelper.dart';

import 'ArtistModel.dart';
import 'artist.dart';

double _appTopBarHeight = 40;
// String AlbumName = 'Arijit Singh';

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

final borderside = BorderSide(color: Colors.white, width: 2);

class ArtistAlbums extends StatelessWidget {
  late ArtistModel artistModel;
  ArtistAlbums({required this.artistModel});

  @override
  Widget build(BuildContext context){
  final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    List<AlbumModel> albums = audioPlayerModel.album.where((el)=>artistModel.albums.contains(el.albumname)).toList();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MyDelegate(artistModel:artistModel),
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
                                          "https://i.scdn.co/image/ab6761610000e5eb0261696c5df3be99da6ed3f3"),
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
                        UiHelper.customButton("Artist",
                            fontsize: 15,
                            fontweight: FontWeight.bold,
                            borderradius: 25,
                            bgcolor: Colors.transparent,
                            forecolor: Colors.white,
                            side: 1.0,
                            sidecolor: Colors.white, callback: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Artist(artistname: artistName,)));
                        }),
                      ],
                    ),
                  );
                },
                childCount:
                    1, // SliverList displaying 20 items, each on a ListTile
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AlbumSongs(albumModel: albums[index],artistname:artistModel.artistname)));
                      },
                      child: Container(
                        height: 40.h,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Image.network(
                                    albums[index].photo,height: 140.h,width: 140.w,),
                            // UiHelper.iconBtn(30,imagePath:  "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg"),
                            // Image.network(
                            //     "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
                            //   ),
                            UiHelper.customText(
                                albums[index].albumname,
                                color: Colors.white,
                                fontsize: 20),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: albums.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // mainAxisSpacing: 0.1,
                crossAxisSpacing: 10, //for size of whole box
                // childAspectRatio: 1.1,
              ),
            ),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //         (_, index) => Padding(
            //       padding: const EdgeInsets.only(left: 15, top: 10),
            //       child:
            //       GridView.builder(
            //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            //         itemBuilder: (_, index) {
            //           return Column(children: [Image.network(
            //             "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
            //             height: 70,
            //             width: 70,
            //             fit: BoxFit.fill,
            //           ),
            //             UiHelper.customText(
            //                 arrContent[index]["songname"].toString(),
            //                 color: Colors.white, fontsize: 20),
            //           ],);
            //         },
            //         itemCount: arrContent.length,
            //       ),
            //       // Column(
            //       //   children: [
            //       //     Padding(
            //       //       padding: const EdgeInsets.only(left: 20,top: 40,right: 20),
            //       //       child: ListView.builder(
            //       //           shrinkWrap: true,
            //       //           itemBuilder: (context, index) {
            //       //             return Column(
            //       //               children: [
            //       //                 Container(
            //       //                   decoration: BoxDecoration(
            //       //                       border: Border(
            //       //                         left:borderside,
            //       //                         bottom: borderside,
            //       //                         right: borderside,
            //       //                       ),
            //       //                       borderRadius: BorderRadius.circular(5)
            //       //                   ),
            //       //                   child: Column(
            //       //                     children: [
            //       //                       // GridView(
            //       //                       //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            //       //                       //   children: <Widget>[
            //       //                       //       Image.network(
            //       //                       //           "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
            //       //                       //           height: 70,
            //       //                       //           width: 70,
            //       //                       //           fit: BoxFit.fill,
            //       //                       //         ),
            //       //                       //           UiHelper.customText(
            //       //                       //             arrContent[index]["songname"].toString(), color:Colors.white, fontsize: 20),
            //       //                       //   ],
            //       //                       // ),
            //       //                       ExpansionTile(
            //       //                         leading: Image.network(
            //       //                           "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
            //       //                           height: 70,
            //       //                           width: 70,
            //       //                           fit: BoxFit.fill,
            //       //                         ),
            //       //                         title: UiHelper.customText(
            //       //                             arrContent[index]["songname"].toString(), color:Colors.white, fontsize: 20),
            //       //                         childrenPadding: EdgeInsets.only(left: 40),
            //       //                         children: [
            //       //                           Padding(
            //       //                             padding: const EdgeInsets.only(left: 40.0),
            //       //                             child: ListView.builder(
            //       //                               shrinkWrap: true,
            //       //                               itemBuilder: (context, index) {
            //       //                                 return ListTile(
            //       //                                   title: UiHelper.customText(
            //       //                                       arrContent[index]["songname"]
            //       //                                           .toString(),
            //       //                                       color: Colors.white,
            //       //                                       fontsize:15),
            //       //                                   subtitle: UiHelper.customText(
            //       //                                       "Arijit Singh", color:Colors.white, fontsize:15),
            //       //                                   trailing: IconButton(onPressed: (){
            //       //                                   }, icon: Icon(Icons.add_circle_outline)),
            //       //                                   onTap: () {},
            //       //                                 );
            //       //                               },
            //       //                               itemCount: arrContent.length,
            //       //                             ),
            //       //                           ),
            //       //                         ],
            //       //                       ),
            //       //                       SizedBox(height: 10,),
            //       //                     ],
            //       //                   ),
            //       //                 ),
            //       //                 SizedBox(height: 20,),
            //       //               ],
            //       //             );
            //       //           },
            //       //           itemCount: arrContent.length),
            //       //
            //       //     ),
            //       //   ],
            //       // ),
            //     ),
            //     childCount: 1,
            //   ),
            // ),
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

// import 'dart:developer';
//
// import 'package:flutter/material.dart';
//
// import '../../Widgets/UiHelper.dart';
//
// class Album extends StatefulWidget {
//   const Album({super.key});
//
//   @override
//   State<Album> createState() => _AlbumState();
// }
//
// class _AlbumState extends State<Album> {
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
//   final borderside = BorderSide(color: Colors.white,width: 2);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         leading: BackButton(
//           color: Colors.white,
//         ),
//         // GestureDetector(child: Icon(Icons.arrow_back_ios,color: Colors.white,),onTap: (){Navigator.pop(context);},),
//         //
//         backgroundColor: Colors.black,
//         toolbarHeight: 200.0,
//         flexibleSpace: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(),
//             child: Column(
//               children: [
//                 Stack(alignment: Alignment.bottomLeft, children: [
//                   Container(
//                     child: Image.network(
//                       "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
//                       fit: BoxFit.fill,
//                       opacity: const AlwaysStoppedAnimation(.7),
//                     ),
//                     width: double.infinity,
//                     height: 200,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Positioned(
//                         child: Text("Arijit Singh",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 70,
//                                 fontWeight: FontWeight.bold))),
//                   ),
//                 ]),
//               ],
//             ),
//           )
//         ),
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 20,top: 40,right: 20),
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return Column(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                               border: Border(
//                                 left:borderside,
//                                 bottom: borderside,
//                                 right: borderside,
//                               ),
//                               borderRadius: BorderRadius.circular(5)
//                           ),
//                           child: Column(
//                             children: [
//                               ExpansionTile(
//                                 leading: Image.network(
//                                   "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
//                                   height: 70,
//                                   width: 70,
//                                   fit: BoxFit.fill,
//                                 ),
//                                 title: UiHelper.customText(
//                                     arrContent[index]["songname"].toString(), color:Colors.white, fontsize: 20),
//                                 childrenPadding: EdgeInsets.only(left: 40),
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 40.0),
//                                     child: ListView.builder(
//                                       // physics: NeverScrollableScrollPhysics(),
//                                       shrinkWrap: true,
//                                       itemBuilder: (context, index) {
//                                         return ListTile(
//                                           title: UiHelper.customText(
//                                               arrContent[index]["songname"]
//                                                   .toString(),
//                                               color: Colors.white,
//                                               fontsize:15),
//                                           subtitle: UiHelper.customText(
//                                               "Arijit Singh", color:Colors.white, fontsize:15),
//                                           trailing: IconButton(onPressed: (){
//                                             log("hello");
//                                           }, icon: Icon(Icons.add_circle_outline)),
//                                           onTap: () {},
//                                         );
//                                       },
//                                       itemCount: arrContent.length,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 10,),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 20,),
//                       ],
//                     );
//                   },
//                   itemCount: arrContent.length),
//
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// ExpansionTile(
//   leading: Image.network(
//     "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
//     height: 70,
//     width: 70,
//     fit: BoxFit.fill,
//   ),
//   title: UiHelper.customText("Account", Colors.white, 20),
//   childrenPadding: EdgeInsets.only(left: 40),
//   children: [
//     ListView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: UiHelper.customText(
//               arrContent[index]["songname"].toString(),
//               Colors.white,
//               15),
//           subtitle: UiHelper.customText(
//               "Arijit Singh", Colors.white, 15),
//           onTap: () {},
//         );
//       },
//       itemCount: arrContent.length,
//     ),
//   ],
// ),
// SizedBox(
//   height: 20,
// ),
// ExpansionTile(
//   leading: Image.network(
//     "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
//     height: 70,
//     width: 70,
//     fit: BoxFit.fill,
//   ),
//   title: UiHelper.customText("Account", Colors.white, 20),
//   childrenPadding: EdgeInsets.only(left: 40),
//   children: [
//     ListView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: UiHelper.customText(
//               arrContent[index]["songname"].toString(),
//               Colors.white,
//               15),
//           subtitle: UiHelper.customText(
//               "Arijit Singh", Colors.white, 15),
//           onTap: () {},
//         );
//       },
//       itemCount: arrContent.length,
//     ),
//   ],
// ),
// ExpansionTile(
//   leading: Image.network(
//     "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
//     height: 70,
//     width: 70,
//     fit: BoxFit.fill,
//   ),
//   title: UiHelper.customText("Account", Colors.white, 20),
//   childrenPadding: EdgeInsets.only(left: 40),
//   children: [
//     ListView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: UiHelper.customText(
//               arrContent[index]["songname"].toString(),
//               Colors.white,
//               15),
//           subtitle: UiHelper.customText(
//               "Arijit Singh", Colors.white, 15),
//           onTap: () {},
//         );
//       },
//       itemCount: arrContent.length,
//     ),
//   ],
// ),
// ExpansionTile(
//   leading: Image.network(
//     "https://m.media-amazon.com/images/I/610FLv2T1QL._AC_UF1000,1000_QL80_.jpg",
//     height: 70,
//     width: 70,
//     fit: BoxFit.fill,
//   ),
//   title: UiHelper.customText("Account", Colors.white, 20),
//   childrenPadding: EdgeInsets.only(left: 40),
//   children: [
//     ListView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: UiHelper.customText(
//               arrContent[index]["songname"].toString(),
//               Colors.white,
//               15),
//           subtitle: UiHelper.customText(
//               "Arijit Singh", Colors.white, 15),
//           onTap: () {},
//         );
//       },
//       itemCount: arrContent.length,
//     ),
//   ],
// ),

// ListView.builder(
//   physics: NeverScrollableScrollPhysics(),
//   shrinkWrap: true,
//   itemBuilder: (context, index) {
//     return ListTile(
//       leading:
//       UiHelper.customText((index+1).toString(), Colors.white, 15),
//       title: Container(
//         height: 50,
//         width: 50,
//         child: Row(
//           children: [
//             Image.network(
//               arrContent[index]["image"].toString() as String,fit: BoxFit.contain,
//             ),
//             SizedBox(width: 15,),
//             UiHelper.customText(arrContent[index]["songname"].toString(), Colors.white, 20),
//             // Text(arrContent[index]["songname"].toString()),
//           ],
//         ),
//       ),
//       // subtitle: Text(arrContent[index]["songname"].toString()),
//       trailing: IconButton(onPressed: (){},icon:Icon(Icons.more_vert),
//         color: Colors.white,
//       ),
//     );
//   },
