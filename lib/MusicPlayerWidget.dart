import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:spotifyfirebase/AudioPlayerModel.dart';
import 'package:spotifyfirebase/Song.dart';
import 'package:spotifyfirebase/uihelper.dart';

// enum RepeatMode {
//   noRepeat,
//   repeatOne,
//   repeatAll,
// }

class MusicPlayerWidget extends StatefulWidget {
  @override
  State<MusicPlayerWidget> createState() => _MusicPlayerWidgetState();
}

class _MusicPlayerWidgetState extends State<MusicPlayerWidget> {
  bool _isPlaying = false;
  late Duration duration;
  late Duration position;
  late String url;
  late DatabaseReference ref;
  @override
  void initState(){
    ref = FirebaseDatabase.instance.ref('likedSongs');
  }
  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    return audioPlayerModel.songs.isEmpty
        ? Center(child: Text("No data", style: TextStyle(color: Colors.white)))
        : Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Column(
                  children: [
                    _buildTopBar(context),
                    const SizedBox(height: 20),
                    _buildAlbumArt(audioPlayerModel),
                    const SizedBox(height: 30),
                    _buildSongInfo(audioPlayerModel),
                    _buildSlider(audioPlayerModel),
                    _buildSliderTimes(audioPlayerModel),
                    const SizedBox(height: 10),
                    _buildControlButtons(audioPlayerModel),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UiHelper.iconBtn(
          30,
          callback: () {
            Navigator.pop(context);
          },
          icondata: Icons.keyboard_arrow_down_sharp,
          color: Colors.white,
        ),
        UiHelper.iconBtn(25, icondata: Icons.menu, color: Colors.white),
      ],
    );
  }

  Widget _buildAlbumArt(AudioPlayerModel audioPlayerModel) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        audioPlayerModel.currentSongPhoto ?? '',
        width: double.infinity,
        height: 350,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildSongInfo(AudioPlayerModel audioPlayerModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UiHelper.customText(
          audioPlayerModel.currentSongName ?? '',
          color: Colors.white,
          fontweight: FontWeight.bold,
          fontsize: 30,
        ),
        UiHelper.iconBtn(
          30,
          icondata: Icons.add_circle_outline_outlined,
          color: Colors.white,
          callback:(){
            Map<dynamic,dynamic> likedSongs={
              'songname':audioPlayerModel.currentSongName,
              'url':audioPlayerModel.currentSongUrl,
              'photo':audioPlayerModel.currentSongPhoto
            };
            ref.push().set(likedSongs);
            log(likedSongs.toString());
          }
        ),
      ],
    );
  }

  Widget _buildSlider(AudioPlayerModel audioPlayerModel) {
    return Slider(
      min: 0,
      max: audioPlayerModel.duration.inSeconds.toDouble(),
      value: audioPlayerModel.position.inSeconds.toDouble(),
      onChanged: (value) {
        final position = Duration(seconds: value.toInt());
        audioPlayerModel.seek(position);
      },
    );
  }

  Widget _buildSliderTimes(AudioPlayerModel audioPlayerModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UiHelper.customText(
            audioPlayerModel.formatDuration(audioPlayerModel.position),
            color: Colors.white,
          ),
          UiHelper.customText(
            audioPlayerModel.formatDuration(audioPlayerModel.duration),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButtons(AudioPlayerModel audioPlayerModel) {
    print("controlbuttons : " + audioPlayerModel.repeatMode.toString());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(
            audioPlayerModel.repeatMode == RepeatMode.noRepeat
                ? Icons.repeat
                : (audioPlayerModel.repeatMode == RepeatMode.repeatOne
                    ? Icons.repeat_one
                    : Icons.repeat),
            color: audioPlayerModel.repeatMode == RepeatMode.noRepeat
                ? Colors.white
                : (audioPlayerModel.repeatMode == RepeatMode.repeatOne
                    ? Colors.green
                    : Colors.blue), // Update based on your color choice
          ),
          onPressed: () {
            audioPlayerModel.toggleRepeatMode();
          },
        ),
        IconButton(
          icon: Icon(Icons.skip_previous, color: Colors.white, size: 40),
          onPressed: () {
            audioPlayerModel.playPrevSong();
          },
        ),
        IconButton(
          icon: Icon(
            audioPlayerModel.isPlaying ? Icons.pause_circle : Icons.play_circle,
            color: Colors.white,
            size: 70,
          ),
          onPressed: () {
            if (audioPlayerModel.isPlaying) {
              audioPlayerModel.pause();
            } else {
              audioPlayerModel.playCurrentSong();
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.skip_next, color: Colors.white, size: 40),
          onPressed: () {
            audioPlayerModel.playNextSong();
          },
        ),
        IconButton(
          icon: Icon(
            Icons.shuffle,
            color: audioPlayerModel.isShuffled ? Colors.green : Colors.white,
            size: 30,
          ),
          onPressed: () {
            audioPlayerModel.toggleShuffle();
          },
        ),
      ],
    );
  }
}
