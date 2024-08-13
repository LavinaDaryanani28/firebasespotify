import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:spotifyfirebase/MusicPlayerWidget.dart';

import 'AudioPlayerService.dart';

class MiniPlayerWidget extends StatelessWidget {
  final String songTitle;
  final bool isPlaying;
  final VoidCallback onPlayPauseToggle;

  MiniPlayerWidget({
    required this.songTitle,
    required this.isPlaying,
    required this.onPlayPauseToggle,
  });

  @override
  Widget build(BuildContext context) {
    
    return
      // GestureDetector(
      // onTap: (){
      //   // Navigator.push(context,  MaterialPageRoute(builder: (context) => MusicPlayerWidget(
      //   //   songs: _isShuffled ? _shuffledSongs : _songs,
      //   //   currentIndex: _currentIndex,
      //   //   isPlaying: _isPlaying,
      //   //   position: position,
      //   //   duration: duration,
      //   //   onPlayPauseToggle: () {
      //   //     if (_isPlaying) {
      //   //       pauseCurrentSong();
      //   //     } else {
      //   //       playCurrentSong();
      //   //     }
      //   //   },
      //   //   onNext: playNextSong,
      //   //   onPrevious: playPrevSong,
      //   //   onSeek: _seekToPosition,
      //   // )),);
      // },
      // child:
      Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey[900],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              songTitle,
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {
                if (isPlaying) {
                  audioPlayerService.audioPlayer.pause();
                } else {
                  audioPlayerService.audioPlayer.resume();
                }
              },
            ),
          ],
        ),
      );
    // );
  }
}