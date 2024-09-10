import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:spotifyfirebase/AudioPlayerModel.dart';
import 'package:spotifyfirebase/MusicPlayerWidget.dart';

class MiniPlayerWidget extends StatelessWidget {
  bool cond = true;

  @override
  Widget build(BuildContext context) {
    final audioPLayerModel = Provider.of<AudioPlayerModel>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MusicPlayerWidget()));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey[900],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.read<AudioPlayerModel>().currentSongName.toString(),
              style: TextStyle(color: Colors.white),
            ),
            //
            IconButton(
              icon: Icon(
                context.watch<AudioPlayerModel>().isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
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
          ],
        ),
      ),
    );
    //
  }
}
