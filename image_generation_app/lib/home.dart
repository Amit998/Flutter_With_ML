import 'dart:convert';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_generation_app/drawingarea.dart';

import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DrawingArea> points = [];

  void saveToImage(List<DrawingArea> points) async {
    final recorder = ui.PictureRecorder();
    final canvas =
        Canvas(recorder, Rect.fromPoints(Offset(0, 0), Offset(200, 200)));

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    final paint2 = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    canvas.drawRect(Rect.fromLTRB(0, 0, 256, 256), paint2);

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i].point, points[i + 1].point, paint);
      }
    }

    final picture = recorder.endRecording();

    final img = await picture.toImage(256, 256);

    final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);

    final listBytes = Uint8List.view(pngBytes.buffer);

    // final file= await writBy

    String base64 = base64Encode(listBytes);

    fetchResponse(base64);
    
  }

  void fetchResponse(var base64Image) async {
    var data = {"Image": base64Image};
    var url = 'http://172.30.64.1:5000/predict';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'Keep-Alive',
    };

    var body = json.encode(data);

    try {
      var response =
          await http.post(Uri.parse(url), body: body, headers: headers);

      final Map<String, dynamic> responseData = json.decode(response.body);

      String outputBytes = responseData['Image'];
    } catch (e) {
      print("Error has occured");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromRGBO(138, 35, 135, 1.0),
                  Color.fromRGBO(255, 0, 255, 1.0),
                  Color.fromRGBO(255, 0, 191, 1.0),
                ])),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: 256,
                    height: 256,
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 5.0,
                              spreadRadius: 1)
                        ]),
                    child: GestureDetector(
                      onPanDown: (details) {
                        // print(details);
                        setState(() {
                          points.add(DrawingArea(
                              point: details.localPosition,
                              areaPaint: Paint()
                                ..strokeCap = StrokeCap.round
                                ..isAntiAlias = true
                                ..color = Colors.white
                                ..strokeWidth = 2.0));
                        });
                      },
                      onPanUpdate: (details) {
                        // print(details.localPosition);
                        setState(() {
                          points.add(DrawingArea(
                              point: details.localPosition,
                              areaPaint: Paint()
                                ..strokeCap = StrokeCap.round
                                ..isAntiAlias = true
                                ..color = Colors.white
                                ..strokeWidth = 2.0));
                        });
                      },
                      onPanEnd: (details) {
                        setState(() {
                          points.add(null);
                        });
                      },
                      child: SizedBox.expand(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: CustomPaint(
                            painter: MyCustomPainter(points: points),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              points.clear();
                            });
                          },
                          icon: Icon(
                            Icons.layers_clear,
                            color: Colors.black,
                          ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
