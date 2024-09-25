import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
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
  String? _currentSongUrl;
  String? _currentSongName;
  String? _currentSongPhoto;
  String? _currentSongArtist;
  String? _currentSongAlbum;
  List<Song> _songs = []; // List of songs
  List<ArtistModel> _artist = [];
  List<AlbumModel> _album = [];
  List<Song> _shuffledSongs = [];
  int currentIndex = 0;
  RepeatMode _repeatMode = RepeatMode.noRepeat;
  late DatabaseReference ref;
  List<dynamic> dataList = [];
  List<Song> _likedSongs = [];
  List<Map<dynamic, dynamic>> _searchResults = [];

  List<Map<dynamic, dynamic>> get searchResults => _searchResults;
  List<Song> get songs => isShuffled ? _shuffledSongs : _songs;
  List<ArtistModel> get artist => _artist;
  List<AlbumModel> get album => _album;
  List<Song> get likedSongs => _likedSongs;
  RepeatMode get repeatMode => _repeatMode;
  String get currentSongName => _currentSongName!;
  String get currentSongUrl => _currentSongUrl!;
  String get currentSongPhoto => _currentSongPhoto!;
  String get currentSongArtist => _currentSongArtist!;
  String get currentSongAlbum => _currentSongAlbum!;
  AudioPlayerModel() {
    _initializeAudioPlayer();
  }

  Future<void> _initializeAudioPlayer() async {
    await _fetchSongs(); // Fetch songs and initialize
    await fetchArtist();
    await fetchAlbum();
    await fetchLiked();
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

  Future<void> searchSongs(String query) async {
    print("Search query: $query");
    if (query.isEmpty) {
      _searchResults = []; // Clear search results if the query is empty
      notifyListeners();
      return;
    }

    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value != null) {
      List<Map<dynamic, dynamic>> searchResults = [];
      Map<dynamic, dynamic> rawData = snapshot.value as Map<dynamic, dynamic>;

      rawData.forEach((key, song) {
        final songTitle = song['songname'].toString().toLowerCase();
        final searchQuery = query.toLowerCase();

        if (songTitle.contains(searchQuery)) {
          searchResults.add(song);
        }
      });
      _searchResults = searchResults;
      notifyListeners();
    }
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
                .map((el) => AlbumModel.fromDocument(
                    el ?? {})) // Ensure element is not null
                .toList();
          } else if (snapshot.value is Map) {
            Map<dynamic, dynamic> rawData =
                snapshot.value as Map<dynamic, dynamic>;
            _album = rawData.values
                .map((el) => AlbumModel.fromDocument(
                    el ?? {})) // Ensure element is not null
                .toList();
          } else {
            print("Error: Unsupported data type.");
          }
          log("Fetched album: ${_album.length}");
          if (_album.isNotEmpty) {
            _setCurrentSong(0); // Set the first song as the current song
          } else {
            log("Error: No songs available");
          }
          notifyListeners();
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
                .map((el) => ArtistModel.fromDocument(
                    el ?? {})) // Ensure element is not null
                .toList();
          } else if (snapshot.value is Map) {
            Map<dynamic, dynamic> rawData =
                snapshot.value as Map<dynamic, dynamic>;

            _artist = rawData.values
                .map((el) => ArtistModel.fromDocument(
                    el ?? {})) // Ensure element is not null
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
                .map((el) =>
                    Song.fromDocument(el ?? {})) // Ensure element is not null
                .toList();
          } else if (snapshot.value is Map) {
            Map<dynamic, dynamic> rawData =
                snapshot.value as Map<dynamic, dynamic>;

            _songs = rawData.values
                .map((el) =>
                    Song.fromDocument(el ?? {})) // Ensure element is not null
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
        } else {
          print("Error: snapshot.value is null.");
        }
      } catch (e) {
        print("Error: $e");
      }
    } catch (e) {
      log("Error fetching songs: $e");
    }
  }

  Future<void> removeSongFromLiked(String songName) async {
    try {
      // Reference to the Firebase Realtime Database
      ref = FirebaseDatabase.instance.ref('likedSongs');

      // Fetch the liked songs
      DatabaseEvent event = await ref.once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null && snapshot.value is Map) {
        final likedSongsMap = snapshot.value as Map<dynamic, dynamic>;

        var filteredSongs = likedSongsMap.entries
            .where((entry) => entry.value['songname'] == songName);

        if (filteredSongs.isNotEmpty) {
          // If song is found, get the first match
          var songKeyToRemove = filteredSongs.first.key;
          await ref.child(songKeyToRemove).remove().then((_) {
            // Update UI after successful removal
            _likedSongs.removeWhere(
                (song) => song.songname == songName); // Remove locally
            notifyListeners();
          });
          print('Successfully removed song with name: $songName');
        } else {
          print('Song with name $songName not found in liked list');
        }
        notifyListeners();
      } else {
        print('No liked songs found or incorrect data format');
      }
    } catch (e) {
      print('Error removing song: $e');
    }
  }

  Future<void> fetchLiked() async {
    try {
      ref = FirebaseDatabase.instance.ref('likedSongs');

      try {
        DatabaseEvent event = await ref.once();
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.value != null) {
          if (snapshot.value is List) {
            List<dynamic> rawData = snapshot.value as List<dynamic>;

            // Process the list into the Song model
            _likedSongs = rawData
                .map((el) =>
                    Song.fromDocument(el ?? {})) // Ensure element is not null
                .toList();
            notifyListeners();
          } else if (snapshot.value is Map) {
            Map<dynamic, dynamic> rawData =
                snapshot.value as Map<dynamic, dynamic>;

            _likedSongs = rawData.values
                .map((el) =>
                    Song.fromDocument(el ?? {})) // Ensure element is not null
                .toList();
            notifyListeners();
          } else {
            print("Error: Unsupported data type.");
          }

          log("Fetched liked songs from Firestore: ${_likedSongs.length}");
          if (_likedSongs.isNotEmpty) {
            _setCurrentSong(0);
            // Set the first song as the current song
          } else {
            log("Error: No songs available");
          }
          log("likedSongs" + _likedSongs.toString());
          notifyListeners();
        } else {
          print("Error: snapshot.value is null.");
        }
      } catch (e) {
        print("Error: $e");
      }
    } catch (e) {
      log("Error fetching liked Songs: $e");
    }
  }

  Future<void> addCurrentSongToLiked() async {
    try {
      // Verify Firebase instance
      ref = FirebaseDatabase.instance.ref('likedSongs');
      print('Firebase reference initialized.');

      // Create a map with the current song details
      Map<String, dynamic> likedSong = {
        'songname': _currentSongName,
        'url': _currentSongUrl,
        'photo': _currentSongPhoto
      };

      // Log the song data being sent
      print('Pushing song to Firebase: $likedSong');

      // Push the song to the likedSongs node
      await ref.push().set(likedSong);
      // Manually add the song to _likedSongs list for immediate feedback
      _likedSongs.add(Song(
          songname: _currentSongName!,
          url: _currentSongUrl!,
          photo: _currentSongPhoto!,
          artist: _currentSongArtist!,
          album: _currentSongAlbum!));
      notifyListeners();
      print('Song added to likedSongs: ${_currentSongName}');
    } catch (e, stackTrace) {
      print('Error adding song to likedSongs: $e');
      print('StackTrace: $stackTrace');
    }
  }

  void _setCurrentSong(int index) {
    if (index >= 0 && index < songs.length) {
      currentIndex = index;
      _currentSongUrl = songs[currentIndex].url;
      _currentSongName = songs[currentIndex].songname;
      _currentSongPhoto = songs[currentIndex].photo;
      _currentSongArtist = songs[currentIndex].artist;
      _currentSongAlbum = songs[currentIndex].album;
      notifyListeners();
    }
  }

  void play() async {
    if (_currentSongUrl != null) {
      await _audioPlayer.play(UrlSource(_currentSongUrl!));
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

  void setCurrentSongFromAlbum(List<Song> albumSongs, int index) {
    _songs = albumSongs; // Update the list of songs to only album songs
    setCurrentSong(index); // Set the song at the selected index
  }

  Future<void> playAlbumSongs(List<Song> albumSongs) async {
    // Set the songs to the album songs
    _songs = albumSongs;
    _shuffledSongs = albumSongs; // If shuffle is on
    currentIndex = 0; // Start from the first song

    // Play the first song
    await playCurrentSong();
  }

  void setCurrentSong(int index) {
    if (index >= 0 && index < songs.length) {
      currentIndex = index;
      _currentSongUrl = songs[currentIndex].url;
      _currentSongName = songs[currentIndex].songname;
      _currentSongPhoto = songs[currentIndex].photo;
      _currentSongArtist = songs[currentIndex].artist;
      _currentSongAlbum = songs[currentIndex].album;
      notifyListeners();
    }
  }

  Future<void> playCurrentSong() async {
    if (_songs.isNotEmpty) {
      final song = songs[currentIndex];
      log("songname : "+song.songname);
      _currentSongUrl = song.url;
      _currentSongName = song.songname;
      _currentSongPhoto = song.photo;
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
