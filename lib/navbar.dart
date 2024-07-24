import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:spotifyfirebase/player.dart';
import 'package:spotifyfirebase/settings.dart';

import 'home.dart';
import 'library.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<NavBar> {
  final audioPlayer=AudioPlayer();
  bool _isPlaying = false;
  @override
  int _currentIndex = 0;
  Duration duration=Duration.zero;
  Duration position=Duration.zero;
  bool isRepeat=false;
  Color color=Colors.white;
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    // Listener for duration changes
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // Listener for position changes
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    // Load the audio file to get its duration - Changed by Abhay
    audioPlayer.setSource(AssetSource('audio/song.mp3'));
  }
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
  String formatDuration(Duration d){
    final min=d.inMinutes.remainder(60);
    final sec=d.inSeconds.remainder(60);
    return "${min.toString().padLeft(2,'0')}:${sec.toString().padLeft(2,'0')}";
  }
  Widget miniPlayer(){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: Colors.blueGrey,
      width: double.infinity,
      height: 60,
      child:
      GestureDetector(
        onTap: (){
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>AudioPlayerWidget()));
          showModalBottomSheet<void>(context: context, isScrollControlled:true,backgroundColor: Colors.black,builder: (BuildContext context) {
            return AudioPlayerWidget();
          });
        },
        child:
        // Hero(
        // tag: "page",
        // child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Image.network("https://i.scdn.co/image/ab67616d0000b273ba5db46f4b838ef6027e6f96",fit: BoxFit.cover,),
            Text("Song A",style: TextStyle(color: Colors.white),),
            IconButton(
              icon:Icon(_isPlaying?Icons.pause:Icons.play_arrow,color:Colors.white,size: 30,),
              onPressed: () async{
                if(_isPlaying){
                  await audioPlayer.pause();
                }
                else{
                  await audioPlayer.play(AssetSource('audio/song.mp3'));
                }
              },
            )
          ],
        ),
        // ),
      ),

    );
  }
  final List<Widget> _screens = [
    Home(),
    Library(),
    Settings(),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          miniPlayer(),
          BottomNavigationBar(
            unselectedLabelStyle: const TextStyle(color: Colors.white, fontSize: 14),
            fixedColor: Colors.white,
            unselectedItemColor: Colors.white,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,color: Colors.white,size: 30,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_music_outlined,color: Colors.white,size: 30,),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,color: Colors.white,size: 30,),
                label: 'Profile',
              ),
            ],
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }

}
