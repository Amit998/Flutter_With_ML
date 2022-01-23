import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<File>? imageFile;
  File? _image;
  String result = '';
  ImagePicker? imagePicker;

  selectedFromGallery() async {
    XFile? pickedFile =
        await imagePicker!.pickImage(source: ImageSource.gallery);

    _image = File(pickedFile!.path);

    setState(() {
      _image;
      doImageClassification();
    });
  }

  capturePhotoFromCamera() async {
    XFile? pickedFile =
        await imagePicker!.pickImage(source: ImageSource.camera);

    _image = File(pickedFile!.path);

    setState(() {
      _image;
      doImageClassification();
    });
  }

  loadDataModelFiles() async {
    String? output = await Tflite.loadModel(
        model: 'assets/model_unquant.tflite',
        labels: 'assets/labels.txt',
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);

    print(output);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
    loadDataModelFiles();
  }

  doImageClassification() async {
    var recognition = await Tflite.runModelOnImage(
        path: _image!.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 1,
        threshold: 0.1,
        asynch: true);

    print(recognition!.length.toString());
    setState(() {
      result = '';
    });

    recognition.forEach((element) {
      setState(() {
        print(element.toString());
        result += element['label'] + '\n\n';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            SizedBox(
              width: 100.0,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Stack(
                children: [
                  Center(
                    child: TextButton(
                      onPressed: selectedFromGallery,
                      onLongPress: capturePhotoFromCamera,
                      child: Container(
                          margin:
                              EdgeInsets.only(top: 30.0, right: 35, left: 18),
                          child: _image != null
                              ? Image.file(
                                  _image!,
                                  height: 300,
                                  width: 400,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 140,
                                  height: 140,
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.black,
                                  ),
                                )),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 160,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                '$result',
                style: TextStyle(
                    color: Colors.pinkAccent,
                    backgroundColor: Colors.white60,
                    fontSize: 40),
              ),
            )
          ],
        ),
      ),
    );
  }
}
