import 'dart:developer';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyfirebase/AudioPlayerModel.dart';
import 'package:spotifyfirebase/MiniPlayerWidget.dart';
import 'package:spotifyfirebase/MusicPlayerWidget.dart';
import 'package:spotifyfirebase/home.dart';
import 'package:spotifyfirebase/library.dart';
import 'package:spotifyfirebase/musicPlayer.dart';
import 'package:spotifyfirebase/player.dart';
import 'package:spotifyfirebase/settings.dart';

import 'Song.dart';
enum RepeatMode {
  noRepeat,
  repeatOne,
  repeatAll,
}
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<NavBar> {
  final AudioPlayer _audioPlayer=AudioPlayer();
  List<Song> _songs = [];
  List<Song> _shuffledSongs = [];
  bool _isPlaying = false;
  bool _isShuffled = false;
  int _currentIndex = 0;
  // int get currentIndex=>_currentIndex;
  RepeatMode _repeatMode = RepeatMode.noRepeat;
  List<Song> get songs => _isShuffled ? _shuffledSongs : _songs;
  int _selectedIndex = 0;
  Duration duration=Duration.zero;
  Duration position=Duration.zero;
  bool isRepeat=false;
  Color color=Colors.white;
  // late String songUrl;
  @override
  void initState() {
    super.initState();
    _initializeMusicPlayer();

    // Load the audio file to get its duration - Changed by Abhay
    // audioPlayer.setSource(AssetSource('audio/song.mp3'));
  }
  Future<void> _handleSongCompletion() async {
    await playNextSong();
  }
  Future<void> _initializeMusicPlayer() async {
    _songs = await _fetchSongs();
    _shuffledSongs = List.from(_songs);
    // songUrl =_songs[_currentIndex].url;
    _audioPlayer.onPositionChanged.listen((newposition) {
      setState(() {
        position = newposition;
      });
    });

    _audioPlayer.onDurationChanged.listen((newduration) {
      setState(() {
        duration = newduration;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) async {
      await _handleSongCompletion();
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    // setState(() {});
  }
  Future<List<Song>> _fetchSongs() async {
    final snapshot = await FirebaseFirestore.instance.collection('trial').get();
    return snapshot.docs.map((doc) => Song.fromDocument(doc)).toList();
  }
  // Future<void> initialize() async{
  //   _songs=await fetchSongs();
  // }
  void _seekToPosition(Duration newposition) async {
    await _audioPlayer.seek(newposition);
    setState(() {
      position = newposition;
    });

    if (!_isPlaying) {
      await _audioPlayer.resume();
      setState(() {
        _isPlaying = true;
      });
    }
  }
  Future<void> playCurrentSong() async{
    if (_songs.isNotEmpty) {
      final song = _isShuffled ? _shuffledSongs[_currentIndex] : _songs[_currentIndex];
      await _audioPlayer.play(UrlSource(song.url));
      setState(() {
        _isPlaying = true;
      });
    }
  }
  Future<void> pauseCurrentSong() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> stopCurrentSong() async {
    await _audioPlayer.stop();
  }
  Future<void> playPrevSong() async{
    if (_songs.isNotEmpty) {
      await _audioPlayer.stop(); // Stop the current song
      _currentIndex = (_currentIndex - 1) % _songs.length;
      if (_currentIndex < 0) {
        _currentIndex = _songs.length - 1; // Wrap around to the last song
      }
      await playCurrentSong(); // Play the previous song
    }
  }
  Future<void> playNextSong() async{
    if (songs.isNotEmpty) {
      await _audioPlayer.stop(); // Stop the current song
      if (_repeatMode == RepeatMode.repeatOne) {
        await playCurrentSong(); // Play the same song again
      } else {
        _currentIndex = (_currentIndex + 1) % songs.length;
        if (_currentIndex == 0 && _repeatMode == RepeatMode.noRepeat) {
          await stopCurrentSong(); // Stop if no repeat mode and end of playlist
        } else {
          await playCurrentSong(); // Play the next song
        }
      }
    }
  }
  void shuffleSongs() {
    if (_songs.isNotEmpty) {
      final currentSong = songs[_currentIndex];
      _shuffledSongs = List.from(_songs);
      _shuffledSongs.remove(currentSong);
      _shuffledSongs.shuffle(Random());
      _shuffledSongs.insert(0, currentSong); // Keep the current song at the first position
      _isShuffled = true;
    }
  }

  void unshuffleSongs() {
    _isShuffled = false;
    _currentIndex = _songs.indexOf(_shuffledSongs[_currentIndex]);
  }

  void setRepeatMode(RepeatMode mode) {
    _repeatMode = mode;
  }
  void dispose(){
    _audioPlayer.dispose();
  }

  String formatDuration(Duration d){
    final min=d.inMinutes.remainder(60);
    final sec=d.inSeconds.remainder(60);
    return "${min.toString().padLeft(2,'0')}:${sec.toString().padLeft(2,'0')}";
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(UrlSource(_songs[_currentIndex].url));
    }
    setState(() {
      _isPlaying = !_isPlaying;
      print("value of isPlaying in navbar${_isPlaying}");
    });
    // if (_isPlaying) {
    //   await _audioPlayer.pause();
    //   setState(() {
    //     _isPlaying = false;
    //   });
    // } else {
    //
    //   final song = _isShuffled ? _shuffledSongs[_currentIndex] : _songs[_currentIndex];
    //   await _audioPlayer.play(UrlSource(song.url));
    //   setState(() {
    //     _isPlaying = true;
    //   });
    // }
  }
  void _openMusicPlayer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MusicPlayerWidget(
          songs: _isShuffled ? _shuffledSongs : _songs,
          currentIndex: _currentIndex,
          isPlaying: _isPlaying,
          position: position,
          duration: duration,
          onPlayPauseToggle:_togglePlayPause,
            //   ()  async{
            //
            // if (_isPlaying) {
            //  await pauseCurrentSong();
            //
            // } else {
            //   // playaudio(songs[currentIndex].url);
            //   await playCurrentSong();
            //   // await audioPlayer.play(NetworkSource(""));
            //   // log(Music[0].toString());
            //   // log(playModel);
            //   // await audioPlayer.play(AssetSource('audio/song.mp3'));
            // }
            // },
          onNext: playNextSong,
          onPrevious: playPrevSong,
          onSeek: _seekToPosition, url: '',
              songPhotoUrl: context.watch<AudioPlayerModel>().currentSongPhoto ?? '',
              songTitle: context.watch<AudioPlayerModel>().currentSongName.toString(),
              onRepeatToggle: () {  },
        ),
      ),
    ).then((_) {
      // Ensure that the latest state is updated in the mini player as well
      setState(() {});
    });
  }
  // Widget miniPlayer(){
  //   return AnimatedContainer(
  //     duration: const Duration(milliseconds: 500),
  //     color: Colors.blueGrey,
  //     width: double.infinity,
  //     height: 60,
  //     child:
  //     GestureDetector(
  //       onTap: (){
  //         _openMusicPlayer(context);
  //         // Navigator.push(context, MaterialPageRoute(builder: (context)=>AudioPlayerWidget()));
  //         // showModalBottomSheet<void>(context: context, isScrollControlled:true,backgroundColor: Colors.black,builder: (BuildContext context) {
  //         //   return
  //         // });
  //       },
  //       child:
  //       // Hero(
  //       // tag: "page",
  //       // child:
  //       _selectedIndex!=3?
  //       MiniPlayerWidget(
  //         songTitle:
  //         "song",
  //         // _isShuffled
  //         //     ? _shuffledSongs[_currentIndex].name
  //         //     : _songs[_currentIndex].name,
  //         isPlaying: _isPlaying,
  //         onPlayPauseToggle: () {
  //           if (_isPlaying) {
  //             pauseCurrentSong();
  //           } else {
  //             playCurrentSong();
  //           }
  //         }, onTap:  (){showModalBottomSheet<void>(context: context, isScrollControlled:true,backgroundColor: Colors.black,builder: (BuildContext context) {
  //     return MusicPlayerWidget(
  //       songs: _isShuffled ? _shuffledSongs : _songs,
  //       currentIndex: _currentIndex,
  //       isPlaying: _isPlaying,
  //       position: position,
  //       duration: duration,
  //       onPlayPauseToggle: () {
  //         if (_isPlaying) {
  //           pauseCurrentSong();
  //         } else {
  //           playCurrentSong();
  //         }
  //       },
  //       onNext: playNextSong,
  //       onPrevious: playPrevSong,
  //       onSeek: _seekToPosition,
  //     );
  //   });},
  //       ):null
  //       // ),
  //     ),
  //
  //   );
  // }

  Widget build(BuildContext context) {
    List<Widget> _pages = [
      Home(),
      Library(),
      Setting(),
      // MusicPlayerWidget(
      //   songs: _isShuffled ? _shuffledSongs : _songs,
      //   currentIndex: _currentIndex,
      //   isPlaying: _isPlaying,
      //   position: position,
      //   duration: duration,
      //   onPlayPauseToggle: () {
      //     if (_isPlaying) {
      //       pauseCurrentSong();
      //     } else {
      //       playCurrentSong();
      //     }
      //   },
      //   onNext: playNextSong,
      //   onPrevious: playPrevSong,
      //   onSeek: _seekToPosition,
      // ),
    ];

    return Scaffold(
      body: Stack(children: [_pages[_selectedIndex],
      if(_selectedIndex!=1)
        Align(
            alignment:  Alignment.bottomCenter,
            child: MiniPlayerWidget(
              songTitle: context.watch<AudioPlayerModel>().currentSongName.toString(),
              isPlaying: _isPlaying,
              onPlayPauseToggle: _togglePlayPause,
                  // () async{
                  // if (_isPlaying) {
                  //   await pauseCurrentSong();
                  // } else {
                  //   await playCurrentSong();
                  // }
              // },
              onTap: () {
                _openMusicPlayer(context);
              }, position: position, duration: duration, onSeek: _seekToPosition, songUrl: 'songUrl',
            ),
        )
      ]),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // miniPlayer(),
          // MiniPlayerWidget(),
          BottomNavigationBar(
            unselectedLabelStyle: const TextStyle(color: Colors.white, fontSize: 14),
            fixedColor: Colors.white,
            unselectedItemColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
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
