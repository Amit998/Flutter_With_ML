import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hello_mnist/dll_models/classifier.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final picker = ImagePicker();
  // Classifier classifier;
  PickedFile image;
  int digit = -1;
  File imageCurr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("HELLO MNIS"),
        centerTitle: true,
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(),
          Text("IMAGE WILL BE SHOWN BELOW"),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.90,
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: BoxDecoration(
              color: Colors.white10,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: digit == -1
                      ? AssetImage("assets/no-image.png")
                      : FileImage(File(image.path))),
              border: Border.all(color: Colors.black, width: 2),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Current Prediction",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            digit == -1 ? "" : "$digit",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.camera_alt_outlined),
        onPressed: () async {
          image = await picker.getImage(source: ImageSource.gallery);
          // digit = await classifier.classifiyImage(image);
          digit = 1;

          setState(() {
            image = image;
          });
          // print(image);
        },
      ),
    );
  }
}
