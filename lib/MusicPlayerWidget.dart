
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:spotifyfirebase/AudioPlayerModel.dart';
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
  late final bool isPlaying;
  late final Duration position;
  final Duration duration;
  final VoidCallback onPlayPauseToggle;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final String url;
  final String songPhotoUrl;
  final String songTitle;
  final ValueChanged<Duration> onSeek;
  final VoidCallback onRepeatToggle;
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
    Key? key, required this.url, required this.songPhotoUrl, required this.songTitle, required this.onRepeatToggle,
    // required this.isShuffle,
    // required this.onShuffle
  }): super(key: key);

  @override
  State<MusicPlayerWidget> createState() => _MusicPlayerWidgetState();
}

class _MusicPlayerWidgetState extends State<MusicPlayerWidget> {
  bool _isPlaying = false;
  late Duration duration;
  late Duration position;
  late String url;
  // late AudioPlayer _audioPlayer;
  @override
  void initState() {
    super.initState();
    // _audioPlayer = AudioPlayer();
    _isPlaying = widget.isPlaying;
    duration=widget.duration;
    position=widget.position;
    url=widget.url;
    // widget.onSeek(position);
    // _audioPlayer.onPositionChanged.listen((newPosition) {
    //   setState(() {
    //     position = newPosition;
    //   });
    // });
    //
    // _audioPlayer.onDurationChanged.listen((newDuration) {
    //   setState(() {
    //     duration = newDuration;
    //   });
    // });
    //
    // _audioPlayer.setSource(UrlSource(url));

  }

  @override
  void didUpdateWidget(MusicPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // print("Old Position: ${oldposition}, New Position: ${position}");
    // print("Old Duration: ${oldduration}, New Duration: ${duration}");
    // print("${oldisPlaying}, New isPlaying: ${isPlaying}");
    if (oldWidget.isPlaying != widget.isPlaying) {
      setState(() {
        _isPlaying = widget.isPlaying;
        print('_isPlaying updated to: $_isPlaying');
      });
    }
    if (widget.position != oldWidget.position) {
      // position = widget.position;
      setState(() {
        position = widget.position;
        print('position updated to: $position');
      });
      // _audioPlayer.seek(position);
    }

    if (widget.duration != oldWidget.duration) {
      // duration = widget.duration;
      setState(() {
        duration = widget.duration;
        print('duration updated to: $duration');
      });
    }
    if (oldWidget.currentIndex != widget.currentIndex)
      {
        setState(() {

        });
      }
  }
  String formatDuration(Duration d){
    final min=d.inMinutes.remainder(60);
    final sec=d.inSeconds.remainder(60);
    return "${min.toString().padLeft(2,'0')}:${sec.toString().padLeft(2,'0')}";
  }
  @override
  Widget build(BuildContext context) {
    final currentSong=widget.songs[widget.currentIndex];
    print("Slider Value: ${position.inSeconds.toDouble()}");
    print("Slider Max: ${duration.inSeconds.toDouble()}");
    print('Building widget with repeat mode: ${context.watch<AudioPlayerModel>().repeatMode}');

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
                          // widget.songs[widget.currentIndex].photo,
                          widget.songPhotoUrl,
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
                            // currentSong.name,
                            widget.songTitle,
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
                      //   value: duration.inSeconds > 0
                      //       ? position.inSeconds.toDouble()
                      //       : 0.0,
                      //   min: 0.0,
                      //   max: duration.inSeconds.toDouble(),
                      //   onChanged: (value) {
                      //     widget.onSeek(Duration(seconds: value.toInt()));
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
                      // Slider(
                      //   value: position.inSeconds.toDouble(),
                      //   min: 0.0,
                      //   max: duration.inSeconds.toDouble(),
                      //   onChanged: (double value) {
                      //     final newposition = Duration(seconds: value.toInt());
                      //     widget.onSeek(newposition);
                      //     // setState(() {
                      //     //   position = newposition;
                      //     // });
                      //   },
                      // ),
                      // Slider(
                      //   value: position.inSeconds.toDouble(),
                      //   min: 0.0,
                      //   max: duration.inSeconds.toDouble(),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       position = Duration(seconds: value.toInt());
                      //       // audioPlayerService.audioPlayer.seek(newPosition);
                      //       // print("Position: ${curPosition.inSeconds}, Duration: ${curDuration.inSeconds}, Slider Value: ${position.inSeconds.toDouble()}");
                      //     });
                      //     widget.onSeek(position);
                      //   },
                      // ),
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
                      Slider(
                        min: 0,
                        max: context.watch<AudioPlayerModel>().duration.inSeconds.toDouble(),
                        value: context.watch<AudioPlayerModel>().position.inSeconds.toDouble(),
                        onChanged: (value) {
                          final position = Duration(seconds: value.toInt());
                          context.read<AudioPlayerModel>().seek(position);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UiHelper.customText(formatDuration(context.watch<AudioPlayerModel>().position),color: Colors.white),
                            UiHelper.customText(formatDuration(context.watch<AudioPlayerModel>().duration),color: Colors.white),
                          ],
                        ),
                      ),
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Consumer<AudioPlayerModel>(
                            builder: (context, model, child) {
                              return IconButton(
                                icon: Icon( model.repeatMode == RepeatMode.noRepeat
                                  ? Icons.repeat
                                      : (model.repeatMode == RepeatMode.repeatOne
                                  ? Icons.repeat_one
                                      : Icons.repeat),), // Adjust icon
                                color: model.repeatMode == RepeatMode.noRepeat
                                    ? Colors.white
                                    : (model.repeatMode == RepeatMode.repeatOne
                                    ? Colors.green
                                    : Colors.blue),
                                onPressed: () {
                                    model.toggleRepeatMode();
                                },
                              );
                            },
                          ),
                          UiHelper.iconBtn(
                              30,
                              icondata:  context.watch<AudioPlayerModel>().repeatMode==RepeatMode.repeatOne?Icons.repeat: context.watch<AudioPlayerModel>().repeatMode == RepeatMode.repeatOne
                                  ? Icons.repeat_one
                                  : Icons.repeat,
                              color:
                              context.watch<AudioPlayerModel>().repeatMode==RepeatMode.noRepeat?Colors.white:Colors.green,
                              callback:  (){context.read<AudioPlayerModel>().toggleRepeatMode;setState((){});},
                          ),
                          IconButton(
                            icon:Icon(context.read<AudioPlayerModel>().repeatMode==RepeatMode.noRepeat?Icons.repeat:Icons.repeat_one,size: 30,color: (){  final mode = context.watch<AudioPlayerModel>().repeatMode;
                            print('Repeat Mode in widget: $mode');
                            return mode == RepeatMode.noRepeat ? Colors.white : Colors.green;}(),),
                            onPressed:context.read<AudioPlayerModel>().toggleRepeatMode,
                            // () async{
                            //   if(isRepeat==false){
                            //     audioPlayer.setReleaseMode(ReleaseMode.loop);
                            //     setState(() {
                            //       isRepeat=true;
                            //       color=Colors.green;
                            //     });
                            //   }
                            //   else if(isRepeat==true)
                            //   {
                            //     setState(() {
                            //       isRepeat=false;
                            //       color=Colors.white;
                            //     });
                            //   }
                            // },
                          ),
                          IconButton(
                              icon: Icon(Icons.skip_previous,
                                  color: Colors.white, size: 40),
                              onPressed:() {
                                context.read<AudioPlayerModel>().playPrevSong();
                              },
                              ),
                          IconButton(
                            icon: Icon(context.watch<AudioPlayerModel>().isPlaying ? Icons.pause_circle : Icons.play_circle,  color: Colors.white,
                                  size: 70,),
                            onPressed: () {
                              if (context.read<AudioPlayerModel>().isPlaying) {
                                context.read<AudioPlayerModel>().pauseCurrentSong();
                              } else {
                                context.read<AudioPlayerModel>().playCurrentSong();
                              }
                            },
                          ),
                          IconButton(
                              icon: Icon(Icons.skip_next,
                                  color: Colors.white, size: 40),
                              onPressed:() {
                                // context.read<AudioPlayerModel>().skipForward();
                                context.read<AudioPlayerModel>().playNextSong();
                              },
                              ),

                          IconButton(
                            icon: Icon(Icons.shuffle, color: context.watch<AudioPlayerModel>().isShuffled
                                ? Colors.blue
                                : Colors.white, size: 30),
                            // onPressed:_toggleShuffle,
                            onPressed:(){
                              context.read<AudioPlayerModel>().toggleShuffleMode();
                            },
                          ),
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