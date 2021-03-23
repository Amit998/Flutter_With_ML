import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600]),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final Classifier classifier = Classfier();
  final picker = ImagePicker();
  String dogBreed;
  String dogProb;

  // Image image;

  void imageFromCamera() async {
    final image = await picker.getImage(
        source: ImageSource.camera,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100);

    // final outputs=
    // await classifier=classifyImage(image);
    // setState(() {
    //   dogBreed=outputs[0];
    //   dogProb=outputs[1];
    // });
  }

  void imageFromGallery() {
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              height: size.height * 0.4,
              width: size.width,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/dbreed2.jpg"),
                      fit: BoxFit.fill),
                ),
              )),
          Positioned(
            top: size.height * 0.35,
            height: size.height * 0.65,
            width: size.width,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Text(
                    "Prediction",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "80% Gold Retriver",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          OutlineButton(
                              highlightedBorderColor: Colors.orange,
                              highlightElevation: 10.0,
                              color: Colors.white,
                              textColor: Colors.white,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(16),
                              child: Icon(
                                Icons.camera_alt,
                                size: 32,
                                color: Colors.orange,
                              ),
                              onPressed: imageFromCamera),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Take Photo",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          OutlineButton(
                              highlightedBorderColor: Colors.orange,
                              highlightElevation: 10.0,
                              color: Colors.white,
                              textColor: Colors.white,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(16),
                              child: Icon(
                                Icons.photo,
                                size: 32,
                                color: Colors.blue,
                              ),
                              onPressed: imageFromGallery),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Take Photo From Gallery",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
