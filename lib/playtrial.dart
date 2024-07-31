import 'package:flutter/material.dart';
import 'package:spotifyfirebase/musicPlayer.dart';
import 'package:spotifyfirebase/Song.dart';

class Play extends StatefulWidget {
  const Play({super.key});

  @override
  State<Play> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<Play> {
  final MusicPlayer _musicPlayer=MusicPlayer();
  @override
  void initState(){
    super.initState();
    _musicPlayer.initialize().then((_){
      setState(() {

      });
    });
  }
  @override
  void dispose(){
    _musicPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _musicPlayer.songs.isNotEmpty?
            Text('Current Song:${_musicPlayer.songs[_musicPlayer.currentIndex].name}'):Text("no playing"),
            ElevatedButton(onPressed: _musicPlayer.playNextSong, child: Text('Next Song'))
          ],
        ),
      ),
    );
  }
}
