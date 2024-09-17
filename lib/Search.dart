import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotifyfirebase/AudioPlayerModel.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _showDropdown = false; // Flag to track if dropdown should be shown
  String _searchQuery = '';
  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 140.0, //set your height
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                      children: [TextField(
                        decoration: InputDecoration(
                          labelText: 'Search',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged:  (query) {
                          setState(() {
                            _searchQuery = query;
                            log("search query in home "+_searchQuery);
                            if (query.isEmpty) {
                              _showDropdown = false;
                            } else {
                              _showDropdown = true;
                              log("true");// Show dropdown when typing
                            }
                          });
                          // Call the search function
                          audioPlayerModel.searchSongs(query);
                        },
                      ),
                        if (_showDropdown)
                          Positioned(
                            top: 60, // Position the dropdown below the TextField
                            left: 0,
                            right: 0,
                            child: _buildSearchResultsDropdown(audioPlayerModel),
                          ),
                      ]
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildSearchResultsDropdown(AudioPlayerModel audioPlayerModel) {
    final searchResults = audioPlayerModel.searchResults;
    if (searchResults.isEmpty) {
      return Container(
        color: Colors.white,
        child: Center(child: Text('No songs found')),
      );
    }

    return Container(
      color: Colors.white,
      height: 200, // Limit the height of the dropdown
      child: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final song = searchResults[index];
          return ListTile(
            title: Text(song['songname']),
            onTap: () {
              setState(() {
                _showDropdown = false; // Hide the dropdown on song selection
              });
              // Handle song selection and play it
              audioPlayerModel.playCurrentSong();
            },
          );
        },
      ),
    );
  }
}
