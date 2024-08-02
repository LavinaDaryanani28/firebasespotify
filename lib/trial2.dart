import 'dart:developer';

import 'package:flutter/material.dart';

import 'Song.dart';
import 'musicPlayer.dart';

class Trial2 extends StatefulWidget {
  const Trial2({super.key});

  @override
  State<Trial2> createState() => _Trial2State();
}

class _Trial2State extends State<Trial2> {

  final MusicPlayer _musicPlayer=MusicPlayer();
  // Map <dynamic,dynamic>songlist="" as Map ;
  List <Song> songlist=[];
  @override
  void initState(){
    super.initState();
    _musicPlayer.initialize().then((_){
      setState(() {

      });
    });
    // log("song list : ${_musicPlayer.songs}");
    // songlist = _musicPlayer.songs.map((s)=>s.name="arijitsingh").toList();
        // where((s)=>s.artist="arijit singh");
    // songlist = songlist.where((s) => s.name.toLowerCase().contains(searchString.text.toLowerCase())).toList();
    // songlist = _musicPlayer.songs.where((s)=>s.name == "O Mahi").toList();
    // song = _musicPlayer.songs[0].name;
    // songlist.addAll(_musicPlayer.songs.where((s)=>s.name == "O Mahi"));
    // _musicPlayer.songs.forEach((el){
    _musicPlayer.songs.map((el){
      if(el.artist == "arijit singh")
      songlist.add(el);
    });

  }
  @override
  Widget build(BuildContext context) {
    print("widget : ${songlist.length}");
    return Scaffold(
      body: songlist.isEmpty ? Text("no text") : Text(songlist[0].name)
    );
  }
}
