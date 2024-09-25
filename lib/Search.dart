import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotifyfirebase/AudioPlayerModel.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _searchQuery = '';
  // bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    // Filter the list based on the search query
    final filteredSongs = _searchQuery.isEmpty
        ? audioPlayerModel.songs
        : audioPlayerModel.songs
        .where((song) => song.songname.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Songs',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                  // _isSearching = query.isNotEmpty;
                });
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredSongs.length,
        itemBuilder: (context, index) {
          final song = filteredSongs[index];
          return ListTile(
            title: Text(song.songname, style: TextStyle(color: Colors.white)),
            subtitle: Text(song.artist, style: TextStyle(color: Colors.grey)),
            onTap: () {
              audioPlayerModel.currentIndex = index;
              audioPlayerModel.playCurrentSong();
            },
          );
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}
