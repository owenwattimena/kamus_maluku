import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:kamus_maluku/screen/main_screen.dart';
import 'package:kamus_maluku/screen/splash_screen.dart';
// import 'package:kamus_maluku/screen/bookmark_screen.dart';

void main() {
  setPotraitOnly();
  runApp(MyApp());
}

setPotraitOnly() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: BookmarkScreen(),
      home: SplashScreen(),
    );
  }
}
