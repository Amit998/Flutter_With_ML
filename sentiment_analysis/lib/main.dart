import 'package:flutter/material.dart';
import 'package:sentiment_analysis/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sentiment Analysis',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: MySplash(),
    );
  }
}
