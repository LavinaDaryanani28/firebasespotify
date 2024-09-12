import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'AlbumModel.dart';
import 'ArtistModel.dart';
import 'Song.dart';

enum RepeatMode {
  noRepeat,
  repeatOne,
  repeatAll,
}

class AudioPlayerModel with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isShuffled = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String? currentSongUrl;
  String? currentSongName;
  String? currentSongPhoto;
  List<Song> _songs = []; // List of songs
  List<ArtistModel> _artist = [];
  List<AlbumModel> _album = [];
  List<Song> _shuffledSongs = [];
  int currentIndex = 0;
  RepeatMode _repeatMode = RepeatMode.noRepeat;
  late DatabaseReference ref;
  List<dynamic> dataList = [];

  List<Song> get songs => isShuffled ? _shuffledSongs : _songs;
  List<ArtistModel> get artist => _artist;
  List<AlbumModel> get album => _album;
  RepeatMode get repeatMode => _repeatMode;

  AudioPlayerModel() {
    _initializeAudioPlayer();
  }

  Future<void> _initializeAudioPlayer() async {
    await _fetchSongs(); // Fetch songs and initialize
    await fetchArtist();
    await fetchAlbum();
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

    // Add listener for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      next(); // Play the next song when the current one finishes
    });
  }

  Future<void> fetchAlbum() async {
    try {
      ref = FirebaseDatabase.instance.ref('album');

      try {
        DatabaseEvent event = await ref.once();
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.value != null) {
          if (snapshot.value is List) {
            List<dynamic> rawData = snapshot.value as List<dynamic>;
            // Process the list into the Song model
            _album = rawData
                .map((el) => AlbumModel.fromDocument(el ?? {})) // Ensure element is not null
                .toList();
          }
          else if (snapshot.value is Map) {
            Map<dynamic, dynamic> rawData = snapshot.value as Map<dynamic, dynamic>;
            _album = rawData.values
                .map((el) => AlbumModel.fromDocument(el ?? {})) // Ensure element is not null
                .toList();
          }
          else {
            print("Error: Unsupported data type.");
          }
          log("Fetched album: ${_album.length}");
          if (_album.isNotEmpty) {

            _setCurrentSong(0); // Set the first song as the current song
          } else {
            log("Error: No songs available");
          }
          notifyListeners();
          // example to get specific record only
          // log("arijit singh: ${_songs.where((el) => el.artist == 'arijit singh')}");
        } else {
          print("Error: snapshot.value is null.");
        }
      } catch (e) {
        print("Error: $e");
      }
    } catch (e) {
      log("Error fetching album: $e");
    }
  }
  Future<void> fetchArtist() async {
    try {
      ref = FirebaseDatabase.instance.ref('artist');

      try {
        DatabaseEvent event = await ref.once();
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.value != null) {
          if (snapshot.value is List) {
            List<dynamic> rawData = snapshot.value as List<dynamic>;

            // Process the list into the Song model
            _artist = rawData
                .map((el) => ArtistModel.fromDocument(el ?? {})) // Ensure element is not null
                .toList();
          } else if (snapshot.value is Map) {
            Map<dynamic, dynamic> rawData = snapshot.value as Map<dynamic, dynamic>;

            _artist = rawData.values
                .map((el) => ArtistModel.fromDocument(el ?? {})) // Ensure element is not null
                .toList();
          } else {
            print("Error: Unsupported data type.");
          }
          log("Fetched artist: ${_artist.length}");
          if (_artist.isNotEmpty) {

            _setCurrentSong(0); // Set the first song as the current song
          } else {
            log("Error: No songs available");
          }
          notifyListeners();
          // example to get specific record only
          // log("arijit singh: ${_songs.where((el) => el.artist == 'arijit singh')}");
        } else {
          print("Error: snapshot.value is null.");
        }
      } catch (e) {
        print("Error: $e");
      }
    } catch (e) {
      log("Error fetching artist: $e");
    }
  }
  Future<void> _fetchSongs() async {
    try {
      ref = FirebaseDatabase.instance.ref('songs');

      try {
        DatabaseEvent event = await ref.once();
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.value != null) {
          if (snapshot.value is List) {
            List<dynamic> rawData = snapshot.value as List<dynamic>;

            // Process the list into the Song model
            _songs = rawData
                .map((el) => Song.fromDocument(el ?? {})) // Ensure element is not null
                .toList();
          } else if (snapshot.value is Map) {
            Map<dynamic, dynamic> rawData = snapshot.value as Map<dynamic, dynamic>;

            _songs = rawData.values
                .map((el) => Song.fromDocument(el ?? {})) // Ensure element is not null
                .toList();
          } else {
            print("Error: Unsupported data type.");
          }
          _shuffledSongs = List.from(_songs)
            ..shuffle(); // Initialize shuffled list

          log("Fetched songs from Firestore: ${_songs.length}");
          if (_songs.isNotEmpty) {


            _setCurrentSong(0); // Set the first song as the current song
          } else {
            log("Error: No songs available");
          }
          notifyListeners();
          // example to get specific record only
          // log("arijit singh: ${_songs.where((el) => el.artist == 'arijit singh')}");
        } else {
          print("Error: snapshot.value is null.");
        }
      } catch (e) {
        print("Error: $e");
      }

      // final snapshot =
      //     await FirebaseFirestore.instance.collection('trial').get();
      // log("Fetched songs from Firestore: ${snapshot.docs.length}");
      // _songs = snapshot.docs.map((doc) => Song.fromDocument(doc)).toList();
      // _shuffledSongs = List.from(_songs)..shuffle(); // Initialize shuffled list
      // if (_songs.isNotEmpty) {
      //   _setCurrentSong(0); // Set the first song as the current song
      // }
      // notifyListeners(); // Notify listeners after fetching songs
    } catch (e) {
      log("Error fetching songs: $e");
    }
  }

  void _setCurrentSong(int index) {
    if (index >= 0 && index < songs.length) {
      currentIndex = index;
      currentSongUrl = songs[currentIndex].url;
      currentSongName = songs[currentIndex].name;
      currentSongPhoto = songs[currentIndex].photo;
      notifyListeners();
    }
  }

  void play() async {
    if (currentSongUrl != null) {
      await _audioPlayer.play(UrlSource(currentSongUrl!));
    }
  }

  void pause() async {
    await _audioPlayer.pause();
    isPlaying = false;
    notifyListeners();
  }

  void stop() async {
    await _audioPlayer.stop();
    position = Duration.zero;
    isPlaying = false;
    notifyListeners();
  }

  void next() {
    if (_songs.isEmpty) return;

    if (_repeatMode == RepeatMode.repeatOne) {
      _setCurrentSong(currentIndex); // Repeat the same song
    } else if (_repeatMode == RepeatMode.repeatAll &&
        currentIndex == songs.length - 1) {
      _setCurrentSong(0); // Go back to the first song
    } else if (currentIndex < songs.length - 1) {
      _setCurrentSong(currentIndex + 1); // Go to the next song
    } else if (currentIndex == songs.length - 1 &&
        _repeatMode == RepeatMode.noRepeat) {
      stop(); // Stop if the end of the playlist is reached and no repeat is set
      return;
    }
    play();
  }

  void previous() {
    if (currentIndex > 0) {
      _setCurrentSong(currentIndex - 1);
    } else if (_repeatMode == RepeatMode.repeatAll && currentIndex == 0) {
      _setCurrentSong(songs.length - 1);
    }
    play();
  }

  void toggleShuffle() {
    isShuffled = !isShuffled;
    currentIndex = 0; // Reset to the first song after toggling shuffle
    notifyListeners();
  }

  void seek(Duration newPosition) async {
    await _audioPlayer.seek(newPosition);
    position = newPosition;
    notifyListeners();
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  Future<void> playNextSong() async {
    if (_songs.isNotEmpty) {
      await _audioPlayer.stop();

      if (_repeatMode == RepeatMode.repeatOne) {
        await playCurrentSong();
      } else {
        currentIndex = (currentIndex + 1) % songs.length;
        if (currentIndex == 0 && _repeatMode == RepeatMode.noRepeat) {
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
      currentIndex = (currentIndex - 1) % _songs.length;
      if (currentIndex < 0) {
        currentIndex = _songs.length - 1;
      }
      await playCurrentSong();
    }
  }

  Future<void> playCurrentSong() async {
    if (_songs.isNotEmpty) {
      final song = songs[currentIndex];
      currentSongUrl = song.url;
      currentSongName = song.name;
      currentSongPhoto = song.photo;
      await _audioPlayer.play(UrlSource(song.url));
      isPlaying = true;
      notifyListeners();
    }
  }

  Future<void> stopCurrentSong() async {
    await _audioPlayer.stop();
  }

  Future<void> pauseCurrentSong() async {
    await _audioPlayer.pause();
    isPlaying = false;
    notifyListeners();
  }

  void shuffleSongs() {
    if (_songs.isNotEmpty) {
      final currentSong = songs[currentIndex];
      _shuffledSongs = List.from(_songs);
      _shuffledSongs.remove(currentSong);
      _shuffledSongs.shuffle();
      _shuffledSongs.insert(0, currentSong);
      isShuffled = true;
      notifyListeners();
    }
  }

  void unshuffleSongs() {
    isShuffled = false;
    currentIndex = _songs.indexOf(_shuffledSongs[currentIndex]);
    notifyListeners();
  }

  // void setRepeatMode(RepeatMode mode) {
  //   _repeatMode = mode;
  //   notifyListeners();
  // }

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
