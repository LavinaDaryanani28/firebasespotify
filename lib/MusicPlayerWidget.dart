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

class MusicPlayerWidget extends StatelessWidget {
  final List<Song> songs;
  final int currentIndex;
  late final bool isPlaying;
  late final Duration position;
  final Duration duration;
  final VoidCallback onPlayPauseToggle;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final String url;
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
    Key? key, required this.url,
    // required this.isShuffle,
    // required this.onShuffle
  }): super(key: key);

  // @override
  // State<MusicPlayerWidget> createState() => _MusicPlayerWidgetState();
  @override
  Widget build(BuildContext context) {
    print("Slider Value: ${position.inSeconds.toDouble()}");
    print("Slider Max: ${duration.inSeconds.toDouble()}");
    return StatefulBuilder(builder: (context, setState) {
      return songs.isEmpty
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
                Slider(
                  value: duration.inSeconds > 0
                      ? position.inSeconds.toDouble()
                      : 0.0,
                  min: 0.0,
                  max: duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    onSeek(Duration(seconds: value.toInt()));
                    // setState(() {
                    //   position = Duration(seconds: value.toInt());
                    // });
                  },
                  // onChangeEnd: (value) {
                  //   onSeek(Duration(seconds: value.toInt()));
                  //   // setState(() {
                  //   //   position = Duration(seconds: value.toInt());
                  //   // });
                  // },
                ),
                Slider(
                  value: position.inSeconds.toDouble(),
                  min: 0.0,
                  max: duration.inSeconds.toDouble(),
                  onChanged: (double value) {
                    final newposition = Duration(seconds: value.toInt());
                    onSeek(newposition);
                    // setState(() {
                    //   position = newposition;
                    // });
                  },
                ),
                Slider(
                  value: position.inSeconds.toDouble(),
                  min: 0.0,
                  max: duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      position = Duration(seconds: value.toInt());
                      // audioPlayerService.audioPlayer.seek(newPosition);
                      // print("Position: ${curPosition.inSeconds}, Duration: ${curDuration.inSeconds}, Slider Value: ${position.inSeconds.toDouble()}");
                    });
                    onSeek(position);
                  },
                ),
                // Slider(
                //   value: 50.0, // Set this to any fixed value
                //   min: 0.0,
                //   max: 100.0,
                //   onChanged: (value) {
                //     setState(() {
                //       position = Duration(seconds: value.toInt());
                //     });
                //   },
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       UiHelper.customText(
                //           "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
                //           color: Colors.white),
                //       UiHelper.customText(
                //           "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
                //           color: Colors.white),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UiHelper.customText(
                          "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
                          color: Colors.white),
                      UiHelper.customText(
                          "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
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
                        onPressed: onPrevious
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
                        isPlaying
                            ? Icons.pause_circle
                            : Icons.play_circle,
                        color: Colors.white,
                        size: 70,
                      ),
                      // onPressed: _togglePlayPause,
                      onPressed: () {
                        // setState(() {
                        //   if(isPlaying!=isPlaying){
                        //     isPlaying=isPlaying;
                        //   }
                        //   // isPlaying = !isPlaying;
                        //   print('Icon toggled: $isPlaying');
                        // });
                        print('Icon toggled: $isPlaying');
                        onPlayPauseToggle();
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
                        onPressed: onNext
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
//
// class _MusicPlayerWidgetState extends State<MusicPlayerWidget> {
//   bool _isPlaying = false;
//   late Duration duration;
//   late Duration position;
//   // late AudioPlayer _audioPlayer;
//   @override
//   void initState() {
//     super.initState();
//     // _audioPlayer = AudioPlayer();
//     _isPlaying = isPlaying;
//     duration=duration;
//     position=position;
//     onSeek(position);
//     // _audioPlayer.onPositionChanged.listen((newPosition) {
//     //   setState(() {
//     //     position = newPosition;
//     //   });
//     // });
//     //
//     // _audioPlayer.onDurationChanged.listen((newDuration) {
//     //   setState(() {
//     //     duration = newDuration;
//     //   });
//     // });
//     //
//     // _audioPlayer.setSource(UrlSource(url));
//
//   }
//
//   @override
//   void didUpdateWidget(MusicPlayerWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     print("Old Position: ${oldposition}, New Position: ${position}");
//     print("Old Duration: ${oldduration}, New Duration: ${duration}");
//     print("${oldisPlaying}, New isPlaying: ${isPlaying}");
//     if (oldisPlaying != isPlaying) {
//       setState(() {
//         _isPlaying = isPlaying;
//         print('_isPlaying updated to: $_isPlaying');
//       });
//     }
//     // if (oldposition != position) {
//     //   setState(() {
//     //     print("Position: ${position}"); // Debug
//     //     position = position;
//     //   });
//     // }
//     //
//     // if (oldduration != duration) {
//     //   setState(() {
//     //     print("Duration: ${duration}"); // Debug
//     //     duration = duration;
//     //   });
//     // }
//     // if (isPlaying != oldisPlaying) {
//     //   _isPlaying = isPlaying;
//     //   if (_isPlaying) {
//     //     _audioPlayer.play(UrlSource(url));
//     //   } else {
//     //     _audioPlayer.pause();
//     //   }
//     // }
//
//     if (position != oldposition) {
//       position = position;
//       // _audioPlayer.seek(position);
//     }
//
//     if (duration != oldduration) {
//       duration = duration;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("Slider Value: ${position.inSeconds.toDouble()}");
//     print("Slider Max: ${duration.inSeconds.toDouble()}");
//     return StatefulBuilder(builder: (context, setState) {
//       return songs.isEmpty
//           ? Container(
//               child: Text("No data"),
//             )
//           : Scaffold(
//               body: SingleChildScrollView(
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           UiHelper.iconBtn(30, callback: () {
//                             Navigator.pop(context);
//                           },
//                               icondata: Icons.keyboard_arrow_down_sharp,
//                               color: Colors.white),
//                           UiHelper.iconBtn(25,
//                               icondata: Icons.menu, color: Colors.white),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: Image.network(
//                           songs[currentIndex].photo,
//                           width: double.infinity,
//                           height: 350,
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           UiHelper.customText(
//                             songs[currentIndex].name,
//                             color: Colors.white,
//                             fontweight: FontWeight.bold,
//                             fontsize: 30,
//                           ),
//                           UiHelper.iconBtn(30,
//                               icondata: Icons.add_circle_outline_outlined,
//                               color: Colors.white),
//                         ],
//                       ),
//                       Slider(
//                         value: duration.inSeconds > 0
//                             ? position.inSeconds.toDouble()
//                             : 0.0,
//                         min: 0.0,
//                         max: duration.inSeconds.toDouble(),
//                         onChanged: (value) {
//                             onSeek(Duration(seconds: value.toInt()));
//                           // setState(() {
//                           //   position = Duration(seconds: value.toInt());
//                           // });
//                         },
//                         // onChangeEnd: (value) {
//                         //   onSeek(Duration(seconds: value.toInt()));
//                         //   // setState(() {
//                         //   //   position = Duration(seconds: value.toInt());
//                         //   // });
//                         // },
//                       ),
//                       Slider(
//                         value: position.inSeconds.toDouble(),
//                         min: 0.0,
//                         max: duration.inSeconds.toDouble(),
//                         onChanged: (double value) {
//                           final newposition = Duration(seconds: value.toInt());
//                           onSeek(newposition);
//                           // setState(() {
//                           //   position = newposition;
//                           // });
//                         },
//                       ),
//                       Slider(
//                         value: position.inSeconds.toDouble(),
//                         min: 0.0,
//                         max: duration.inSeconds.toDouble(),
//                         onChanged: (value) {
//                           setState(() {
//                             position = Duration(seconds: value.toInt());
//                             // audioPlayerService.audioPlayer.seek(newPosition);
//                             // print("Position: ${curPosition.inSeconds}, Duration: ${curDuration.inSeconds}, Slider Value: ${position.inSeconds.toDouble()}");
//                           });
//                           onSeek(position);
//                         },
//                       ),
//                       // Slider(
//                       //   value: 50.0, // Set this to any fixed value
//                       //   min: 0.0,
//                       //   max: 100.0,
//                       //   onChanged: (value) {
//                       //     setState(() {
//                       //       position = Duration(seconds: value.toInt());
//                       //     });
//                       //   },
//                       // ),
//                       // Padding(
//                       //   padding: const EdgeInsets.symmetric(horizontal: 16),
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //     children: [
//                       //       UiHelper.customText(
//                       //           "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
//                       //           color: Colors.white),
//                       //       UiHelper.customText(
//                       //           "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
//                       //           color: Colors.white),
//                       //     ],
//                       //   ),
//                       // ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             UiHelper.customText(
//                                 "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
//                                 color: Colors.white),
//                             UiHelper.customText(
//                                 "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
//                                 color: Colors.white),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           // UiHelper.iconBtn(
//                           //     30,
//                           //     icondata: repeatMode==RepeatMode.repeatOne?Icons.repeat_one:Icons.repeat,
//                           //     color: repeatMode==RepeatMode.noRepeat?Colors.white:Colors.green,
//                           //     callback: _cycleRepeatMode
//                           // ),
//                           // IconButton(
//                           //   icon:Icon(Icons.repeat,color: color,size: 30),
//                           //   onPressed: () async{
//                           //     if(isRepeat==false){
//                           //       audioPlayer.setReleaseMode(ReleaseMode.loop);
//                           //       setState(() {
//                           //         isRepeat=true;
//                           //         color=Colors.green;
//                           //       });
//                           //     }
//                           //     else if(isRepeat==true)
//                           //     {
//                           //       setState(() {
//                           //         isRepeat=false;
//                           //         color=Colors.white;
//                           //       });
//                           //     }
//                           //   },
//                           // ),
//                           IconButton(
//                               icon: Icon(Icons.skip_previous,
//                                   color: Colors.white, size: 40),
//                               onPressed: onPrevious
//                               //     () async{
//                               //   await playPrevSong();
//                               //   setState(() {
//                               //     _isPlaying = true;
//                               //   });
//                               // },
//                               ),
//                           IconButton(
//                             icon: Icon(
//                               // _isPlaying ? Icons.pause_circle : Icons.play_circle,
//                               _isPlaying
//                                   ? Icons.pause_circle
//                                   : Icons.play_circle,
//                               color: Colors.white,
//                               size: 70,
//                             ),
//                             // onPressed: _togglePlayPause,
//                             onPressed: () {
//                               setState(() {
//                                 _isPlaying = !_isPlaying;
//                                 print('Icon toggled: $_isPlaying');
//                               });
//                               onPlayPauseToggle();
//                             },
//                             // onPressed: () async {
//                             //
//                             // if (_isPlaying) {
//                             //   await _audioPlayer.pause();
//                             // } else {
//                             //   // playaudio(songs[currentIndex].url);
//                             //   playCurrentSong();
//                             //   // await audioPlayer.play(NetworkSource(""));
//                             //   // log(Music[0].toString());
//                             //   // log(playModel);
//                             //   // await audioPlayer.play(AssetSource('audio/song.mp3'));
//                             // }
//                             // },
//                           ),
//                           IconButton(
//                               icon: Icon(Icons.skip_next,
//                                   color: Colors.white, size: 40),
//                               onPressed: onNext
//                               //     () {
//                               //   playNextSong().then((_) {
//                               //     setState(() {
//                               //       _isPlaying=true;
//                               //     }); // Update UI after playing next song
//                               //   });
//                               // },
//                               ),
//
//                           // IconButton(
//                           //   icon: Icon(Icons.shuffle, color: isShuffle?Colors.green:Colors.white, size: 30),
//                           //   // onPressed:_toggleShuffle,
//                           //   onPressed: onShuffle,
//                           // ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               backgroundColor: Colors.black,
//             );
//     });
//   }
// }
