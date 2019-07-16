import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kamus_maluku/screen/main_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    });

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              color: Color(0xff312323),
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/splash_screen.png'))),
          child: null,
        ),
      ),
    );
  }
}
