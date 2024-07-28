import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:spotifyfirebase/uihelper.dart';

class trial extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<trial> {
  final audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isRepeat = false;
  Color color = Colors.white;
  List data=[];
  // String formatTime(int seconds) {
  //   return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  // }
  String formatDuration(Duration d) {
    final min = d.inMinutes.remainder(60);
    final sec = d.inSeconds.remainder(60);
    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    log("init");
    getItem();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    // Listener for duration changes
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // Listener for position changes
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    // fetchMusic();
    // Load the audio file to get its duration - Changed by Abhay
    audioPlayer.setSource(AssetSource('audio/song.mp3'));

  }

  void handleSeek(double value) {
    audioPlayer.seek(Duration(seconds: value.toInt()));
  }

  Future<void> playaudio(String url) async{
    await audioPlayer.play(UrlSource(url));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
  Future<void> fetchMusic() async {
    log("hey");
    QuerySnapshot querySnapshot=await FirebaseFirestore.instance.collection("trial").get();
    data=querySnapshot.docs.map((doc)=>doc.data()).toList();
    log(data.toString());
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("trial").snapshots(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) return Text("Loading");
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemBuilder: (_, i) {
              // final data = docs[i].data();
              final data = docs[i].data()! as Map<String, dynamic>;
              // var a=snapshot.data!.docs[i];
              log(data['songname']);
              return SingleChildScrollView(
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
                          "https://i.scdn.co/image/ab67616d0000b273ba5db46f4b838ef6027e6f96",
                          width: double.infinity,
                          height: 350,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UiHelper.customText(
                            data['songname'],
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
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: (value) async {
                          final position = Duration(seconds: value.toInt());
                          audioPlayer.seek(position);
                          audioPlayer.resume();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UiHelper.customText(formatDuration(position),
                                color: Colors.white),
                            UiHelper.customText(formatDuration(duration - position),
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
                          UiHelper.iconBtn(
                            30,
                            icondata: Icons.repeat,
                            color: color,
                            callback: () async {
                              if (isRepeat == false) {
                                audioPlayer.setReleaseMode(ReleaseMode.loop);
                                setState(() {
                                  isRepeat = true;
                                  color = Colors.green;
                                });
                              } else if (isRepeat == true) {
                                setState(() {
                                  isRepeat = false;
                                  color = Colors.white;
                                });
                              }
                            },
                          ),
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
                            onPressed: () async {
                              await audioPlayer.pause();
                              await audioPlayer.seek(Duration(seconds: 10));
                              await audioPlayer.resume();
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              _isPlaying ? Icons.pause_circle : Icons.play_circle,
                              color: Colors.white,
                              size: 70,
                            ),
                            onPressed: () async {
                              if (_isPlaying) {
                                await audioPlayer.pause();
                              } else {
                                playaudio("https://audio.jukehost.co.uk/VGbs8JV3KFkeNQlZrvlK1TYUiemabBUa");
                                // await audioPlayer.play(NetworkSource(""));
                                // log(Music[0].toString());
                                // log(playModel);
                                // await audioPlayer.play(AssetSource('audio/song.mp3'));
                              }
                            },
                          ),
                          IconButton(
                            icon:
                            Icon(Icons.skip_next, color: Colors.white, size: 40),
                            onPressed: () async {
                              // audioPlayer.setPlaybackRate();
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.shuffle, color: Colors.white, size: 30),
                            onPressed: () async {
                              // audioPlayer.setPlaybackRate();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
      },
    );
  }

  Future getItem()async{
    String documentid = "BXFj7yvqhxNnJ8Tu9YNx";
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("trial").get();
    for(int i=0 ; i<querySnapshot.docs.length; i++){
      // print(querySnapshot);
      var a=querySnapshot.docs[i];
      log("hello "+a["artist"]);
    }
  }
}
