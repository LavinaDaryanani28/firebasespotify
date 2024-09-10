import 'dart:developer';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Song.dart';
enum RepeatMode {
  noRepeat,
  repeatOne,
  repeatAll,
}
class AudioPlayerModel with ChangeNotifier{
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool _isShuffled = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String? currentSongUrl;
  String? currentSongName;
  String? currentSongPhoto;
  List<Song> _songs = []; // List of songs
  int _currentIndex = 0;
  RepeatMode _repeatMode = RepeatMode.noRepeat;

  RepeatMode get repeatMode => _repeatMode;
  bool get isShuffled => _isShuffled;
  List<Song> _shuffledSongs = [];
  List<Song> get songs => _isShuffled ? _shuffledSongs : _songs;
  AudioPlayerModel() {
    _initializeAudioPlayer();
  }
  void toggleShuffleMode() {
    if (_isShuffled) {
      // Call unshuffle when shuffle mode is off
      unshuffleSongs();
    } else {
      // Shuffle the songs
      shuffleSongs();
    }
    notifyListeners();
  }
  Future<void> _initializeAudioPlayer() async {
    _songs = await fetchSongs();

    // Initialize with the first song's details if available
    if (_songs.isNotEmpty) {
      currentSongUrl = _songs[0].url;
      currentSongName = _songs[0].name;
      currentSongPhoto = _songs[0].photo; // Assuming Song has a `photoUrl` field
    }

    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
      notifyListeners();
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      position = newPosition;
      notifyListeners();
    });
  }
  Future<List<Song>> fetchSongs() async {
    final snapshot = await FirebaseFirestore.instance.collection('trial').get();
    return snapshot.docs.map((doc) => Song.fromDocument(doc)).toList();
    // final snapshot = await FirebaseFirestore.instance.collection('trial').get();
    // _songs = snapshot.docs.map((doc) => Song.fromDocument(doc)).toList();
    // _shuffledSongs = List.from(_songs);
  }

  Future<void> playCurrentSong() async {
    if (_songs.isNotEmpty) {
      final song = _isShuffled ? _shuffledSongs[_currentIndex] : _songs[_currentIndex];
      currentSongUrl = song.url;
      currentSongName = song.name;
      currentSongPhoto = song.photo;
      await _audioPlayer.play(UrlSource(song.url));
      isPlaying = true;
      notifyListeners();
    }
  }
  // Future<void> playCurrentSong(String url) async{
  //   if (currentSongUrl != url) {
  //     currentSongUrl = url;
  //     await _audioPlayer.play(UrlSource(url));
  //   } else {
  //     await _audioPlayer.resume();
  //   }

  Future<void> pauseCurrentSong() async {
    await _audioPlayer.pause();
    isPlaying = false;
    notifyListeners();
  }

  // void seek(Duration position) async {
  //   await _audioPlayer.seek(position);
  // }
  void seek(Duration newPosition) async {
    await _audioPlayer.seek(newPosition);
    position = newPosition;
    notifyListeners();
  }
  Future<void> stopCurrentSong() async {
    await _audioPlayer.stop();
  }
  Future<void> playNextSong() async {
    if (_songs.isNotEmpty) {
      await _audioPlayer.stop();

      if (_repeatMode == RepeatMode.repeatOne) {
        await playCurrentSong();
      } else {
        _currentIndex = (_currentIndex + 1) % songs.length;
        if (_currentIndex == 0 && _repeatMode == RepeatMode.noRepeat) {
          await stopCurrentSong();
        } else {
          await playCurrentSong();
        }
      }
    }
  }

  Future<void> playPrevSong() async {
    if (_songs.isNotEmpty) {
      await _audioPlayer.stop();
      _currentIndex = (_currentIndex - 1) % _songs.length;
      if (_currentIndex < 0) {
        _currentIndex = _songs.length - 1;
      }
      await playCurrentSong();
    }
  }
  void shuffleSongs() {
    if (_songs.isNotEmpty) {
      final currentSong = songs[_currentIndex];
      _shuffledSongs = List.from(_songs);
      _shuffledSongs.remove(currentSong);
      _shuffledSongs.shuffle();
      _shuffledSongs.insert(0, currentSong);
      _isShuffled = true;
      notifyListeners();
    }
  }

  void unshuffleSongs() {
    _isShuffled = false;
    _currentIndex = _songs.indexOf(_shuffledSongs[_currentIndex]);
    notifyListeners();
  }

  void setRepeatMode(RepeatMode mode) {
    _repeatMode = mode;
    notifyListeners();
  }
  void toggleRepeatMode() {
    print('Current repeat mode: $_repeatMode');
    _repeatMode = _repeatMode == RepeatMode.noRepeat
        ? RepeatMode.repeatOne
        : (_repeatMode == RepeatMode.repeatOne
        ? RepeatMode.repeatAll
        : RepeatMode.noRepeat);
    print('New repeat mode: $_repeatMode');
    notifyListeners();
  }
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}