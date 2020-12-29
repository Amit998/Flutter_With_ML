import 'package:flutter/material.dart';
import 'package:live_caption_generator/home.dart';
import 'package:live_caption_generator/mysplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Text Generator",
      home: MySplash(),
    );
  }
}
