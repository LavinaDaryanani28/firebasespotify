import 'package:flutter/material.dart';
import 'package:spotifyfirebase/MiniPlayerWidget.dart';
import 'package:spotifyfirebase/home.dart';
import 'package:spotifyfirebase/library.dart';
import 'package:spotifyfirebase/settings.dart';
import 'Search.dart';

enum RepeatMode {
  noRepeat,
  repeatOne,
  repeatAll,
}
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      Home(),
      Library(),
      Search(),
      Setting(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MiniPlayerWidget(),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedLabelStyle: const TextStyle(fontSize: 14),
            selectedItemColor: Colors.green ,
            unselectedItemColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,size: 30,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_music_outlined,size: 30,),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search,size: 30,),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,size: 30,),
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