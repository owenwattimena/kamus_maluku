import 'package:flutter/material.dart';
// import 'package:kamus_maluku/screen/main_screen.dart';
import 'package:kamus_maluku/screen/splash_screen.dart';
// import 'package:kamus_maluku/screen/bookmark_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: BookmarkScreen(),
      home: SplashScreen(),
    );
  }
}
