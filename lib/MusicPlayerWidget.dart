import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:spotifyfirebase/AudioPlayerService.dart';
import 'package:spotifyfirebase/Song.dart';
import 'package:spotifyfirebase/uihelper.dart';
enum RepeatMode {
  noRepeat,
  repeatOne,
  repeatAll,
}
class MusicPlayerWidget extends StatelessWidget{
  final List<Song> songs;
  final int currentIndex;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final VoidCallback onPlayPauseToggle;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final ValueChanged<Duration> onSeek;
  // final bool isShuffle;
  // final VoidCallback onShuffle;

  MusicPlayerWidget({
    required this.songs,
    required this.currentIndex,
    required this.isPlaying,
    required this.position,
    required this.duration,
    required this.onPlayPauseToggle,
    required this.onNext,
    required this.onPrevious,
    required this.onSeek,
    // required this.isShuffle,
    // required this.onShuffle
  });
  @override
  Widget build(BuildContext context) {
    return songs.isEmpty ? Container() :Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UiHelper.iconBtn(30, callback: () {
                    Navigator.pop(context);
                  },
                      icondata: Icons.keyboard_arrow_down_sharp,
                      color: Colors.white),
                  UiHelper.iconBtn(25,
                      icondata: Icons.menu, color: Colors.white),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  songs[currentIndex].photo,
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UiHelper.customText(
                    songs[currentIndex].name,
                    color: Colors.white,
                    fontweight: FontWeight.bold,
                    fontsize: 30,
                  ),
                  UiHelper.iconBtn(30,
                      icondata: Icons.add_circle_outline_outlined,
                      color: Colors.white),
                ],
              ),
              // Slider(
              //   value: widget.duration.inSeconds > 0
              //       ? widget.position.inSeconds.toDouble()
              //       : 0.0,
              //   min: 0.0,
              //   max: widget.duration.inSeconds.toDouble(),
              //   onChanged: (value) {
              //       widget.onSeek(Duration(seconds: value.toInt()));
              //     // setState(() {
              //     //   position = Duration(seconds: value.toInt());
              //     // });
              //   },
              //   // onChangeEnd: (value) {
              //   //   onSeek(Duration(seconds: value.toInt()));
              //   //   // setState(() {
              //   //   //   position = Duration(seconds: value.toInt());
              //   //   // });
              //   // },
              // ),
              Slider(
                value: duration.inSeconds > 0
                    ? position.inSeconds.toDouble()
                    : 0.0,
                min: 0.0,
                max: duration.inSeconds.toDouble(),
                onChanged: (double value) {
                  final newposition = Duration(seconds: value.toInt());
                  audioPlayerService.audioPlayer.seek(newposition);
                  // setState(() {
                  //   position = newposition;
                  // });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UiHelper.customText("${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
                        color: Colors.white),
                    UiHelper.customText("${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
                        color: Colors.white),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // UiHelper.iconBtn(
                  //     30,
                  //     icondata: repeatMode==RepeatMode.repeatOne?Icons.repeat_one:Icons.repeat,
                  //     color: repeatMode==RepeatMode.noRepeat?Colors.white:Colors.green,
                  //     callback: _cycleRepeatMode
                  // ),
                  // IconButton(
                  //   icon:Icon(Icons.repeat,color: color,size: 30),
                  //   onPressed: () async{
                  //     if(isRepeat==false){
                  //       audioPlayer.setReleaseMode(ReleaseMode.loop);
                  //       setState(() {
                  //         isRepeat=true;
                  //         color=Colors.green;
                  //       });
                  //     }
                  //     else if(isRepeat==true)
                  //     {
                  //       setState(() {
                  //         isRepeat=false;
                  //         color=Colors.white;
                  //       });
                  //     }
                  //   },
                  // ),
                  IconButton(
                    icon: Icon(Icons.skip_previous,
                        color: Colors.white, size: 40),
                    onPressed:
                    onPrevious
                    //     () async{
                    //   await playPrevSong();
                    //   setState(() {
                    //     _isPlaying = true;
                    //   });
                    // },
                  ),
                  IconButton(
                    icon: Icon(
                      // _isPlaying ? Icons.pause_circle : Icons.play_circle,
                      isPlaying ? Icons.pause_circle : Icons.play_circle,
                      color: Colors.white,
                      size: 70,
                    ),
                    // onPressed: _togglePlayPause,
                    onPressed: onPlayPauseToggle,
                    // onPressed: () async {
                    //
                    // if (_isPlaying) {
                    //   await _audioPlayer.pause();
                    // } else {
                    //   // playaudio(songs[currentIndex].url);
                    //   playCurrentSong();
                    //   // await audioPlayer.play(NetworkSource(""));
                    //   // log(Music[0].toString());
                    //   // log(playModel);
                    //   // await audioPlayer.play(AssetSource('audio/song.mp3'));
                    // }
                    // },
                  ),
                  IconButton(
                    icon:
                    Icon(Icons.skip_next, color: Colors.white, size: 40),
                    onPressed:onNext
                    //     () {
                    //   playNextSong().then((_) {
                    //     setState(() {
                    //       _isPlaying=true;
                    //     }); // Update UI after playing next song
                    //   });
                    // },
                  ),

                  // IconButton(
                  //   icon: Icon(Icons.shuffle, color: isShuffle?Colors.green:Colors.white, size: 30),
                  //   // onPressed:_toggleShuffle,
                  //   onPressed: onShuffle,
                  // ),

                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
