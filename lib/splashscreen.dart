import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotifyfirebase/signup.dart';

import 'navbar.dart';

class SplashScreen2 extends StatefulWidget{
  const SplashScreen2({super.key});
  @override
  State<SplashScreen2> createState()=>_SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen2>{
  @override
  void initState() {
    Timer (Duration(seconds: 3),()async {
      SharedPreferences prefs=await SharedPreferences.getInstance();
      bool? check = prefs.getBool("islogin");
      if(check!=null)
      {
        if(check){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NavBar()));
        }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin()));
        }
      }
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin()));
      }
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>List()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: NetworkImage('https://play-lh.googleusercontent.com/7ynvVIRdhJNAngCg_GI7i8TtH8BqkJYmffeUHsG-mJOdzt1XLvGmbsKuc5Q1SInBjDKN=w240-h480-rw',),
        ),
      ),
      backgroundColor: Colors.black38,
    );
  }
}
