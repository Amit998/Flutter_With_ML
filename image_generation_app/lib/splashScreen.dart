import 'package:flutter/material.dart';
import 'package:image_generation_app/home.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(
          seconds: 2,
          navigateAfterSeconds: MyHomePage(),
          gradientBackground: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(138, 35, 135, 1.0),
                Color.fromRGBO(255, 0, 255, 1.0),
                Color.fromRGBO(255, 0, 191, 1.0),
              ]),
          loaderColor: Colors.white,
          title: Text(
            "Face Generator App",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white),
          )),
    );
  }
}
