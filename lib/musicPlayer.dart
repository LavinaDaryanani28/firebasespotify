import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'MusicPlayerWidget.dart';
import 'Song.dart';
enum RepeatMode {
  noRepeat,
  repeatOne,
  repeatAll,
}
class MusicController extends StatefulWidget {
  const MusicController({super.key});

  @override
  State<MusicController> createState() => _MusicControllerState();
}

class _MusicControllerState extends State<MusicController> with ChangeNotifier{
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

    setState(() {});
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
    notifyListeners();
  }
  Future<void> pauseCurrentSong() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
    notifyListeners();
  }

  Future<void> stopCurrentSong() async {
    await _audioPlayer.stop();
    notifyListeners();
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
    notifyListeners();
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
    notifyListeners();
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
    notifyListeners();
  }

  void unshuffleSongs() {
    _isShuffled = false;
    _currentIndex = _songs.indexOf(_shuffledSongs[_currentIndex]);
    notifyListeners();
  }

  void setRepeatMode(RepeatMode mode) {
    _repeatMode = mode;
    notifyListeners();
  }
  void dispose(){
    _audioPlayer.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:spotifyfirebase/MiniPlayerWidget.dart';
// import 'package:spotifyfirebase/MusicPlayerWidget.dart';
// import 'package:spotifyfirebase/Song.dart';
// import 'package:spotifyfirebase/player.dart';
//
// enum RepeatMode {
//   noRepeat,
//   repeatOne,
//   repeatAll,
// }
// class MusicPlayer extends StatefulWidget {
//   const MusicPlayer({super.key});
//
//   @override
//   State<MusicPlayer> createState() => _MusicPlayerState();
// }
//
// class _MusicPlayerState extends State<MusicPlayer> {
//   final AudioPlayer _audioPlayer=AudioPlayer();
//   List<Song> _songs=[];
//   int _currentIndex=0;
//   RepeatMode _repeatMode = RepeatMode.noRepeat;
//   List<Song> get songs => _isShuffled ? _shuffledSongs : _songs;
//   int get currentIndex=>_currentIndex;
//   List<Song> _shuffledSongs = [];
//   bool _isShuffled = false;
//   bool _isPlaying = false;
//   RepeatMode get repeatMode => _repeatMode;
//   Duration position = Duration.zero;
//   Duration duration = Duration.zero;
//   @override
//   void initState() {
//     super.initState();
//     _initializeMusicPlayer();
//   }
//   Future<void> _handleSongCompletion() async {
//     await playNextSong();
//   }
//   Future<void> _initializeMusicPlayer() async {
//     // _songs = await fetchSongs();
//     _shuffledSongs = List.from(_songs);
//
//     _audioPlayer.onPositionChanged.listen((newposition) {
//       setState(() {
//         position = newposition;
//       });
//     });
//
//     _audioPlayer.onDurationChanged.listen((newduration) {
//       setState(() {
//         duration = newduration;
//       });
//     });
//
//     _audioPlayer.onPlayerComplete.listen((event) async {
//       await _handleSongCompletion();
//     });
//
//     _audioPlayer.onPlayerStateChanged.listen((state) {
//       setState(() {
//         _isPlaying = state == PlayerState.playing;
//       });
//     });
//
//     setState(() {});
//   }
//   Future<void> initialize() async{
//     // _songs=await fetchSongs();
//   }
//   void _seekToPosition(Duration position) async {
//     await _audioPlayer.seek(position);
//     setState(() {
//       position = position;
//     });
//
//     if (!_isPlaying) {
//       await _audioPlayer.resume();
//       setState(() {
//         _isPlaying = true;
//       });
//     }
//   }
//   Future<void> playCurrentSong() async{
//     if(_songs.isNotEmpty){
//       final song=_songs[_currentIndex];
//       await _audioPlayer.play(UrlSource(song.url));
//     }
//   }
//   Future<void> pauseCurrentSong() async {
//     await _audioPlayer.pause();
//   }
//
//   Future<void> stopCurrentSong() async {
//     await _audioPlayer.stop();
//   }
//   Future<void> playPrevSong() async{
//     if (_songs.isNotEmpty) {
//       await _audioPlayer.stop(); // Stop the current song
//       _currentIndex = (_currentIndex - 1) % _songs.length;
//       if (_currentIndex < 0) {
//         _currentIndex = _songs.length - 1; // Wrap around to the last song
//       }
//       await playCurrentSong(); // Play the previous song
//     }
//   }
//   Future<void> playNextSong() async{
//     if (songs.isNotEmpty) {
//       await _audioPlayer.stop(); // Stop the current song
//       if (_repeatMode == RepeatMode.repeatOne) {
//         await playCurrentSong(); // Play the same song again
//       } else {
//         _currentIndex = (_currentIndex + 1) % songs.length;
//         if (_currentIndex == 0 && _repeatMode == RepeatMode.noRepeat) {
//           await stopCurrentSong(); // Stop if no repeat mode and end of playlist
//         } else {
//           await playCurrentSong(); // Play the next song
//         }
//       }
//     }
//   }
//   void shuffleSongs() {
//     if (_songs.isNotEmpty) {
//       final currentSong = songs[_currentIndex];
//       _shuffledSongs = List.from(_songs);
//       _shuffledSongs.remove(currentSong);
//       _shuffledSongs.shuffle(Random());
//       _shuffledSongs.insert(0, currentSong); // Keep the current song at the first position
//       _isShuffled = true;
//     }
//   }
//
//   void unshuffleSongs() {
//     _isShuffled = false;
//     _currentIndex = _songs.indexOf(_shuffledSongs[_currentIndex]);
//   }
//
//   void setRepeatMode(RepeatMode mode) {
//     _repeatMode = mode;
//   }
//   void dispose(){
//     _audioPlayer.dispose();
//   }
//   AudioPlayer get audioPlayer => _audioPlayer;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(child:
//           MusicPlayerWidget(
//             songs:_isShuffled?_shuffledSongs:_songs,
//         currentIndex: _currentIndex,
//         isPlaying: _isPlaying,
//         position: position,
//         duration: duration,
//         onPlayPauseToggle: () {
//           if (_isPlaying) {
//             pauseCurrentSong();
//           } else {
//             playCurrentSong();
//           }
//         },
//         onNext: playNextSong,
//         onPrevious: playPrevSong,
//         onSeek: _seekToPosition,
//       ),
//           ),
//           MiniPlayerWidget(
//             songTitle: _isShuffled
//                 ? _shuffledSongs[_currentIndex].name
//                 : _songs[_currentIndex].name,
//             isPlaying: _isPlaying,
//             onPlayPauseToggle: () {
//               if (_isPlaying) {
//                 pauseCurrentSong();
//               } else {
//                 playCurrentSong();
//               }
//             }, onTap: () {  },
//           ),
//         ],
//       ),
//     );
//   }
// }
