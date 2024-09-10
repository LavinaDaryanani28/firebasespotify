import 'dart:developer';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyfirebase/AudioPlayerModel.dart';
import 'package:spotifyfirebase/MiniPlayerWidget.dart';
import 'package:spotifyfirebase/MusicPlayerWidget.dart';
import 'package:spotifyfirebase/home.dart';
import 'package:spotifyfirebase/library.dart';
import 'package:spotifyfirebase/musicPlayer.dart';
import 'package:spotifyfirebase/player.dart';
import 'package:spotifyfirebase/settings.dart';

import 'Song.dart';
enum RepeatMode {
  noRepeat,
  repeatOne,
  repeatAll,
}
class Trial extends StatefulWidget {
  const Trial({super.key});

  @override
  State<Trial> createState() => _TrialState();
}

class _TrialState extends State<Trial> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    _selectedIndex = index;
  }

  Widget build(BuildContext context) {
    List<Widget> _pages = [
      Home(),
      Library(),
      Setting(),
    ];

    return Scaffold(
      body: Stack(children: [_pages[_selectedIndex],
        if(_selectedIndex!=1)
          Align(
            alignment:  Alignment.bottomCenter,
            child: MiniPlayerWidget(),
          )
      ]),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // miniPlayer(),
          // MiniPlayerWidget(),
          BottomNavigationBar(
            unselectedLabelStyle: const TextStyle(color: Colors.white, fontSize: 14),
            fixedColor: Colors.white,
            unselectedItemColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,color: Colors.white,size: 30,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_music_outlined,color: Colors.white,size: 30,),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,color: Colors.white,size: 30,),
                label: 'Profile',
              ),
            ],
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }

}
