import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:spotifyfirebase/musicPlayer.dart';
import 'package:spotifyfirebase/uihelper.dart';

class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  // final audioPlayer = AudioPlayer()
  // bool _isPlaying = false;
  // Duration duration = Duration.zero;
  // Duration position = Duration.zero;
  // bool isRepeat = false;
  // List data=[];
  // final MusicPlayer _musicPlayer=MusicPlayer();
  // bool _isShuffled = false;
  //
  // // String formatTime(int seconds) {
  // //   return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  // // }
  // String formatDuration(Duration d) {
  //   final min = d.inMinutes.remainder(60);
  //   final sec = d.inSeconds.remainder(60);
  //   return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  // }
  //
  // @override
  // void initState(){
  //   super.initState();
  //   _musicPlayer.initialize().then((_){
  //     setState(() {
  //       // _musicPlayer.audioPlayer.setSource(UrlSource(_musicPlayer.songs[_musicPlayer.currentIndex].url));
  //     });
  //   });
  //   _musicPlayer.audioPlayer.onPlayerComplete.listen((event) {
  //     setState(() {
  //       _isPlaying = false;
  //       position = Duration.zero;
  //     });
  //   });
  //   _musicPlayer.audioPlayer.onPlayerStateChanged.listen((state) {
  //     setState(() {
  //       _isPlaying = state == PlayerState.playing;
  //     });
  //   });
  //
  //   // Listener for duration changes
  //   _musicPlayer.audioPlayer.onDurationChanged.listen((newDuration) {
  //     setState(() {
  //       duration = newDuration;
  //     });
  //   });
  //
  //   // Listener for position changes
  //   _musicPlayer.audioPlayer.onPositionChanged.listen((newPosition) {
  //     setState(() {
  //       position = newPosition;
  //     });
  //   });
  // }
  // void _togglePlayPause() async {
  //   if (_isPlaying) {
  //     await _musicPlayer.pauseCurrentSong();
  //     setState(() {
  //       _isPlaying=false;
  //     });
  //   } else {
  //     await _musicPlayer.playCurrentSong();
  //     setState(() {
  //       _isPlaying=true;
  //     });
  //   }
  //   // setState(() {
  //   //   _isPlaying = !_isPlaying;
  //   // });
  // }
  // void _toggleShuffle() {
  //   setState(() {
  //     if (_isShuffled) {
  //       _musicPlayer.unshuffleSongs();
  //     } else {
  //       _musicPlayer.shuffleSongs();
  //     }
  //     _isShuffled = !_isShuffled;
  //   });
  // }
  // void _seekToPosition(double value) async {
  //   final newposition = Duration(seconds: value.toInt());
  //   await _musicPlayer.audioPlayer.seek(newposition);
  //   setState(() {
  //     position = newposition;
  //   });
  //
  //   // Ensure playback starts if paused
  //   if (!_isPlaying) {
  //     await _musicPlayer.audioPlayer.resume();
  //     setState(() {
  //       _isPlaying = true;
  //     });
  //   }
  // }
  // void _cycleRepeatMode() {
  //   setState(() {
  //     switch (_musicPlayer.repeatMode) {
  //       case RepeatMode.noRepeat:
  //         _musicPlayer.setRepeatMode(RepeatMode.repeatOne);
  //         break;
  //       case RepeatMode.repeatOne:
  //         _musicPlayer.setRepeatMode(RepeatMode.repeatAll);
  //         break;
  //       case RepeatMode.repeatAll:
  //         _musicPlayer.setRepeatMode(RepeatMode.noRepeat);
  //         break;
  //     }
  //   });
  //   }
  // @override
  // void dispose() {
  //   _musicPlayer.dispose();
  //   super.dispose();
  // }
  // @override
  // Widget build(BuildContext context) {
  //   log(_musicPlayer.songs.length.toString());
  //   return _musicPlayer.songs.isEmpty ? Container() :Scaffold(
  //     body: SingleChildScrollView(
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         UiHelper.iconBtn(30, callback: () {
  //                           Navigator.pop(context);
  //                         },
  //                             icondata: Icons.keyboard_arrow_down_sharp,
  //                             color: Colors.white),
  //                         UiHelper.iconBtn(25,
  //                             icondata: Icons.menu, color: Colors.white),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 20,
  //                     ),
  //                     ClipRRect(
  //                       borderRadius: BorderRadius.circular(20),
  //                       child: Image.network(
  //                         _musicPlayer.songs[_musicPlayer.currentIndex].photo,
  //                         width: double.infinity,
  //                         height: 350,
  //                         fit: BoxFit.fill,
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 30,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         UiHelper.customText(
  //                           _musicPlayer.songs[_musicPlayer.currentIndex].name,
  //                           color: Colors.white,
  //                           fontweight: FontWeight.bold,
  //                           fontsize: 30,
  //                         ),
  //                         UiHelper.iconBtn(30,
  //                             icondata: Icons.add_circle_outline_outlined,
  //                             color: Colors.white),
  //                       ],
  //                     ),
  //                     Slider(
  //                       value: position.inSeconds.toDouble(),
  //                       min: 0.0,
  //                       max: duration.inSeconds.toDouble(),
  //                       onChanged: (value) {
  //                         setState(() {
  //                           position = Duration(seconds: value.toInt());
  //                         });
  //                       },
  //                       onChangeEnd: _seekToPosition,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 16),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           UiHelper.customText("${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
  //                               color: Colors.white),
  //                           UiHelper.customText("${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
  //                               color: Colors.white),
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         UiHelper.iconBtn(
  //                           30,
  //                           icondata: _musicPlayer.repeatMode==RepeatMode.repeatOne?Icons.repeat_one:Icons.repeat,
  //                           color: _musicPlayer.repeatMode==RepeatMode.noRepeat?Colors.white:Colors.green,
  //                           callback: _cycleRepeatMode
  //                         ),
  //                         // IconButton(
  //                         //   icon:Icon(Icons.repeat,color: color,size: 30),
  //                         //   onPressed: () async{
  //                         //     if(isRepeat==false){
  //                         //       audioPlayer.setReleaseMode(ReleaseMode.loop);
  //                         //       setState(() {
  //                         //         isRepeat=true;
  //                         //         color=Colors.green;
  //                         //       });
  //                         //     }
  //                         //     else if(isRepeat==true)
  //                         //     {
  //                         //       setState(() {
  //                         //         isRepeat=false;
  //                         //         color=Colors.white;
  //                         //       });
  //                         //     }
  //                         //   },
  //                         // ),
  //                         IconButton(
  //                           icon: Icon(Icons.skip_previous,
  //                               color: Colors.white, size: 40),
  //                           onPressed: () async{
  //                             await _musicPlayer.playPrevSong();
  //                             setState(() {
  //                               _isPlaying = true;
  //                             });
  //                           },
  //                         ),
  //                         IconButton(
  //                           icon: Icon(
  //                             _isPlaying ? Icons.pause_circle : Icons.play_circle,
  //                             color: Colors.white,
  //                             size: 70,
  //                           ),
  //                           onPressed: _togglePlayPause,
  //                           // onPressed: () async {
  //
  //                             // if (_isPlaying) {
  //                             //   await audioPlayer.pause();
  //                             // } else {
  //                             //   playaudio(_musicPlayer.songs[_musicPlayer.currentIndex].url);
  //                             //   // _musicPlayer.playCurrentSong();
  //                             //   // await audioPlayer.play(NetworkSource(""));
  //                             //   // log(Music[0].toString());
  //                             //   // log(playModel);
  //                             //   // await audioPlayer.play(AssetSource('audio/song.mp3'));
  //                             // }
  //                           // },
  //                         ),
  //                         IconButton(
  //                           icon:
  //                           Icon(Icons.skip_next, color: Colors.white, size: 40),
  //                           onPressed: () {
  //                             _musicPlayer.playNextSong().then((_) {
  //                               setState(() {
  //                                 _isPlaying=true;
  //                               }); // Update UI after playing next song
  //                             });
  //                           },
  //                         ),
  //                         IconButton(
  //                           icon: Icon(Icons.shuffle, color: _isShuffled?Colors.green:Colors.white, size: 30),
  //                           onPressed:_toggleShuffle,
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //     backgroundColor: Colors.black,
  //   );
  // }

  // Future getItem()async{
  //   String documentid = "BXFj7yvqhxNnJ8Tu9YNx";
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("trial").get();
  //   for(int i=0 ; i<querySnapshot.docs.length; i++){
  //     // print(querySnapshot);
  //     var a=querySnapshot.docs[i];
  //     log("hello "+a["artist"]);
  //   }
  // }
}
