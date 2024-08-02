import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotifyfirebase/player.dart';
import 'package:spotifyfirebase/playtrial.dart';
import 'package:spotifyfirebase/splashscreen.dart';
import 'package:spotifyfirebase/trial.dart';
import 'package:spotifyfirebase/trial2.dart';

import 'firebase_options.dart';
import 'home.dart';
import 'navbar.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Trial2(),
      ),
    );
  }
}
