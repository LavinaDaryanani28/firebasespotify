import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:spotifyfirebase/Song.dart';

enum RepeatMode {
  noRepeat,
  repeatOne,
  repeatAll,
}

class MusicPlayer{
  final AudioPlayer _audioPlayer=AudioPlayer();
  List<Song> _songs=[];
  int _currentIndex=0;
  RepeatMode _repeatMode = RepeatMode.noRepeat;
  List<Song> get songs => _isShuffled ? _shuffledSongs : _songs;
  int get currentIndex=>_currentIndex;
  List<Song> _shuffledSongs = [];
  bool _isShuffled = false;
  RepeatMode get repeatMode => _repeatMode;
  Future<void> initialize() async{
    _songs=await fetchSongs();
  }
  Future<void> playCurrentSong() async{
    if(_songs.isNotEmpty){
      final song=_songs[_currentIndex];
      await _audioPlayer.play(UrlSource(song.url));
    }
  }
  Future<void> pauseCurrentSong() async {
    await _audioPlayer.pause();
  }

  Future<void> stopCurrentSong() async {
    await _audioPlayer.stop();
  }
  Future<void> playPrevSong() async{
    if (_songs.isNotEmpty) {
      await _audioPlayer.stop(); // Stop the current song
      _currentIndex = (_currentIndex - 1) % _songs.length;
      if (_currentIndex < 0) {
        _currentIndex = _songs.length - 1; // Wrap around to the last song
      }
      await playCurrentSong(); // Play the previous song
    }
  }
  Future<void> playNextSong() async{
    if (songs.isNotEmpty) {
      await _audioPlayer.stop(); // Stop the current song
      if (_repeatMode == RepeatMode.repeatOne) {
        await playCurrentSong(); // Play the same song again
      } else {
        _currentIndex = (_currentIndex + 1) % songs.length;
        if (_currentIndex == 0 && _repeatMode == RepeatMode.noRepeat) {
          await stopCurrentSong(); // Stop if no repeat mode and end of playlist
        } else {
          await playCurrentSong(); // Play the next song
        }
      }
    }
  }
  void shuffleSongs() {
    if (_songs.isNotEmpty) {
      final currentSong = songs[_currentIndex];
      _shuffledSongs = List.from(_songs);
      _shuffledSongs.remove(currentSong);
      _shuffledSongs.shuffle(Random());
      _shuffledSongs.insert(0, currentSong); // Keep the current song at the first position
      _isShuffled = true;
    }
  }

  void unshuffleSongs() {
    _isShuffled = false;
    _currentIndex = _songs.indexOf(_shuffledSongs[_currentIndex]);
  }

  void setRepeatMode(RepeatMode mode) {
    _repeatMode = mode;
  }
  void dispose(){
    _audioPlayer.dispose();
  }
  AudioPlayer get audioPlayer => _audioPlayer;
}