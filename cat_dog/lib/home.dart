import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  File _image;
  List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((val) {
      setState(() {});
    });
  }

  classifiedImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Tflite.close();
  }

  PickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    }
    setState(() {
      _image = File(image.path);
    });
    classifiedImage(_image);
  }

  PickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    setState(() {
      _image = File(image.path);
    });
    classifiedImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    print(_output);
    print(_image);
    return Scaffold(
      backgroundColor: Color(0xFF101010),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 85.0,
              ),
              Text("TeachableMachine.com CNN",
                  style: TextStyle(color: Color(0xFFEEDAADA), fontSize: 16)),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Detect Dogs and Cats',
                style: TextStyle(
                    color: Color(0xFF0999FAA),
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: 40.0,
              ),
              Center(
                child: _loading
                    ? Container(
                        width: 280,
                        child: Column(
                          children: [
                            Image.asset('assets/mainImg.png'),
                            SizedBox(height: 50),
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          children: [
                            Container(
                              height: 250,
                              child: Image.file(_image),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            _output != null
                                ? Text(
                                    "${_output[0]['label']}",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Container(),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: PickGalleryImage,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 150,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                        decoration: BoxDecoration(
                          color: Color(0xFFFEFEFE),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Take a photo',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: PickImage,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 150,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                        decoration: BoxDecoration(
                          color: Color(0xFFFEFEFE),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Camera roll',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
