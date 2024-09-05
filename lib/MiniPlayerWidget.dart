import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyfirebase/AudioPlayerModel.dart';

class MiniPlayerWidget extends StatelessWidget {
  final String songTitle;
  final String songUrl;
  final bool isPlaying;
  final VoidCallback onPlayPauseToggle;
  final VoidCallback onTap;
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration> onSeek;

  MiniPlayerWidget({
    required this.songTitle,
    required this.isPlaying,
    required this.onPlayPauseToggle,
    required this.onTap, required this.position, required this.duration, required this.onSeek, required this.songUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey[900],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              songTitle,
              style: TextStyle(color: Colors.white),
            ),
            // IconButton(
            //   icon: Icon(
            //     isPlaying ? Icons.pause : Icons.play_arrow,
            //     color: Colors.white,
            //   ),
            //   onPressed: onPlayPauseToggle,
            // ),
            IconButton(
              icon: Icon(
                context.watch<AudioPlayerModel>().isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {
                if (context.read<AudioPlayerModel>().isPlaying) {
                  context.read<AudioPlayerModel>().pauseCurrentSong();
                } else {
                  context.read<AudioPlayerModel>().playCurrentSong();
                }
              },
            ),
            // Slider(
            //     value: position.inSeconds.toDouble(),
            //     min: 0.0,
            //     max: duration.inSeconds.toDouble(),
            //     onChanged: (value) {
            //       final newPosition = Duration(seconds: value.toInt());
            //       onSeek(newPosition);
            //     },
            //   ),
          ],
        ),
      ),
    );
  }
}

// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:spotifyfirebase/MusicPlayerWidget.dart';
//
// import 'AudioPlayerService.dart';
//
// class MiniPlayerWidget extends StatelessWidget {
//   final String songTitle;
//   final bool isPlaying;
//   final VoidCallback onPlayPauseToggle;
//
//   MiniPlayerWidget({
//     required this.songTitle,
//     required this.isPlaying,
//     required this.onPlayPauseToggle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     return
//       // GestureDetector(
//       // onTap: (){
//       //   // Navigator.push(context,  MaterialPageRoute(builder: (context) => MusicPlayerWidget(
//       //   //   songs: _isShuffled ? _shuffledSongs : _songs,
//       //   //   currentIndex: _currentIndex,
//       //   //   isPlaying: _isPlaying,
//       //   //   position: position,
//       //   //   duration: duration,
//       //   //   onPlayPauseToggle: () {
//       //   //     if (_isPlaying) {
//       //   //       pauseCurrentSong();
//       //   //     } else {
//       //   //       playCurrentSong();
//       //   //     }
//       //   //   },
//       //   //   onNext: playNextSong,
//       //   //   onPrevious: playPrevSong,
//       //   //   onSeek: _seekToPosition,
//       //   // )),);
//       // },
//       // child:
//       Container(
//         padding: EdgeInsets.all(10),
//         color: Colors.grey[900],
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               songTitle,
//               style: TextStyle(color: Colors.white),
//             ),
//             IconButton(
//               icon: Icon(
//                 isPlaying ? Icons.pause : Icons.play_arrow,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 if (isPlaying) {
//                   audioPlayerService.audioPlayer.pause();
//                 } else {
//                   audioPlayerService.audioPlayer.resume();
//                 }
//               },
//             ),
//           ],
//         ),
//       );
//     // );
//   }
// }