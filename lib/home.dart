import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotifyfirebase/uihelper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, String>> albums = [
    {
      'title': 'Album 1',
      'image':
          'https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b'
    },
    {
      'title': 'Album 2',
      'image':
          'https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b'
    },
    {
      'title': 'Album 3',
      'image':
          'https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b'
    },
    {
      'title': 'Album 4',
      'image':
          'https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b'
    },
  ];

  final List<Map<String, String>> artists = [
    {
      'name': 'Artist 1',
      'image':
          'https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b'
    },
    {
      'name': 'Artist 2',
      'image':
          'https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b'
    },
    {
      'name': 'Artist 3',
      'image':
          'https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b'
    },
    {
      'name': 'Artist 4',
      'image':
          'https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b'
    },
  ];

  final List<Map<String, String>> songs = [
    {'title': 'Song 1', 'artist': 'Artist 1'},
    {'title': 'Song 2', 'artist': 'Artist 2'},
    {'title': 'Song 3', 'artist': 'Artist 3'},
    {'title': 'Song 4', 'artist': 'Artist 4'},
  ];

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
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
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
                // SizedBox(height: 30,),
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
                    itemCount: albums.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.network(albums[index]['image']!,
                                height: 100, width: 100),
                            SizedBox(height: 8),
                            Text(
                              albums[index]['title']!,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
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
                    itemCount: artists.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(artists[index]['image']!),
                              radius: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              artists[index]['name']!,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // UiHelper.customText("Top Artist", color:Colors.white,fontsize:  20),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       // IconButton(onPressed: (){
                //       //   Navigator.push(context, MaterialPageRoute(builder: (context)=>AudioPlayerWidget()));
                //       // }, icon: Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),)
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       // Image.network("https://i.scdn.co/image/ab67616d0000b2735c2e8fa840241ce6adf33a35",height: 150,width: 120,),
                //       // SizedBox(width: 20,),
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width:20,),
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       Image.network("https://https://i.scdn.co/image/ab67616d00001e021ad922dae0ba39e07cc15038",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 30,
                ),
                // UiHelper.customText("India's Best",  color:Colors.white,fontsize:  20),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       Image.network("https://i.scdn.co/image/ab67706c0000da84c6567ac6fe1cb8b9ad541b52",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width:20,),
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       // Image.network("https://https://i.scdn.co/image/ab67616d0000b2735c2e8fa840241ce6adf33a35",height: 150,width: 120,),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UiHelper.customText('Songs',
                      fontsize: 24, color: Colors.white),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.music_note),
                      title: Text(songs[index]['title']!),
                      subtitle: Text(songs[index]['artist']!),
                      onTap: () {
                        // Handle song click
                      },
                    );
                  },
                ),
                // UiHelper.customText("Songs that you may like", color:Colors.white,fontsize:  20),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       Image.network("https://i.scdn.co/image/ab67706c0000da84c6567ac6fe1cb8b9ad541b52",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width:20,),
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       // Image.network("https://https://i.scdn.co/image/ab67616d0000b2735c2e8fa840241ce6adf33a35",height: 150,width: 120,),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 30,),
                // UiHelper.customText("Top Mixes",  color:Colors.white,fontsize:  20),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       Image.network("https://i.scdn.co/image/ab67706c0000da84c6567ac6fe1cb8b9ad541b52",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width:20,),
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       Image.network("https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b",height: 150,width: 120,),
                //       SizedBox(width: 20,),
                //       // Image.network("https://https://i.scdn.co/image/ab67616d0000b2735c2e8fa840241ce6adf33a35",height: 150,width: 120,),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      // floatingActionButton: floatingActionItem,
    );
  }
// get floatingActionItem {
//   Widget floatingPlayer = GestureDetector(
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(width: 35,),
//         Container(
//           height: 125,
//           width: 325,
//           color: Colors.teal,
//         ),
//       ],
//     ),
//     onTap: () {
//       setState(() {
//         isPlayerOpened = false;
//       });
//     },
//   );
//
//   Widget floatingActionButton = FloatingActionButton(
//     onPressed: () {
//       setState(() {
//         isPlayerOpened = true;
//       });
//     },
//     child: Icon(Icons.play_arrow_outlined),
//   );
//
//   return AnimatedSwitcher(
//     reverseDuration: Duration(milliseconds: 0),
//     duration: const Duration(milliseconds: 200),
//     transitionBuilder: (Widget child, Animation<double> animation) {
//       return ScaleTransition(child: child, scale: animation);
//     },
//     child: isPlayerOpened ? floatingPlayer : floatingActionButton,
//   );
// }
}
