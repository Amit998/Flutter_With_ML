import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Home(),
      title: Text(
        'Fruits and Vegitables',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Color(0xFFE99600),
        ),
      ),
      image: Image.asset('assets/fpage2.png',height: 300,width: 200),
      gradientBackground: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.004, 1],
          colors: [
            Color(0xFF00B4DB),
            Color(0xFF00B6DB)
            ]),
      photoSize: 50,
      loaderColor: Colors.white,
    );
  }
}
