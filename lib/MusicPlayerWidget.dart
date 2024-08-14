import 'dart:math';
import 'dart:developer';

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

class MusicPlayerWidget extends StatefulWidget {
  final List<Song> songs;
  final int currentIndex;
  final bool isPlaying;
  late final Duration position;
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
    required ValueKey<bool> key,
    // required this.isShuffle,
    // required this.onShuffle
  });

  @override
  State<MusicPlayerWidget> createState() => _MusicPlayerWidgetState();
}

class _MusicPlayerWidgetState extends State<MusicPlayerWidget> {
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _isPlaying = widget.isPlaying;
  }

  @override
  void didUpdateWidget(MusicPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("${oldWidget.isPlaying}, New isPlaying: ${widget.isPlaying}");
    if (oldWidget.isPlaying != widget.isPlaying) {
      setState(() {
        _isPlaying = widget.isPlaying;
        print('_isPlaying updated to: $_isPlaying');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return widget.songs.isEmpty
          ? Container(
              child: Text("No data"),
            )
          : Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
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
                          widget.songs[widget.currentIndex].photo,
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
                            widget.songs[widget.currentIndex].name,
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
                        value: widget.duration.inSeconds > 0
                            ? widget.position.inSeconds.toDouble()
                            : 0.0,
                        min: 0.0,
                        max: widget.duration.inSeconds.toDouble(),
                        onChanged: (double value) {
                          final newposition = Duration(seconds: value.toInt());
                          audioPlayerService.audioPlayer.seek(newposition);
                          // setState(() {
                          //   position = newposition;
                          // });
                        },
                      ),
                      // Slider(
                      //   value: widget.position.inSeconds.toDouble(),
                      //   min: 0.0,
                      //   max: widget.duration.inSeconds.toDouble(),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       final newPosition = Duration(seconds: value.toInt());
                      //       audioPlayerService.audioPlayer.seek(newPosition);
                      //       print("Position: ${widget.position.inSeconds}, Duration: ${widget.duration.inSeconds}, Slider Value: ${widget.position.inSeconds.toDouble()}");
                      //     });
                      //   },
                      // ),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UiHelper.customText(
                                "${widget.position.inMinutes}:${(widget.position.inSeconds % 60).toString().padLeft(2, '0')}",
                                color: Colors.white),
                            UiHelper.customText(
                                "${widget.duration.inMinutes}:${(widget.duration.inSeconds % 60).toString().padLeft(2, '0')}",
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
                              onPressed: widget.onPrevious
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
                              _isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              color: Colors.white,
                              size: 70,
                            ),
                            // onPressed: _togglePlayPause,
                            onPressed: () {
                              setState(() {
                                _isPlaying = !_isPlaying;
                                print('Icon toggled: $_isPlaying');
                              });
                              widget.onPlayPauseToggle();
                            },
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
                              icon: Icon(Icons.skip_next,
                                  color: Colors.white, size: 40),
                              onPressed: widget.onNext
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
    });
  }
}
