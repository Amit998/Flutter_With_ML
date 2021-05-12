// @dart=2.9
import 'package:flutter/material.dart';
import 'package:image_generation_app/home.dart';
import 'package:image_generation_app/splashScreen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Humen Generator',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MySplash(),
    );
  }
}
