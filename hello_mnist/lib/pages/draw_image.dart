import 'package:flutter/material.dart';
import 'package:hello_mnist/dll_models/classifier.dart';
// import 'drawing_page.dart';

class DrawImage extends StatefulWidget {
  @override
  _DrawImageState createState() => _DrawImageState();
}

class _DrawImageState extends State<DrawImage> {
  int digit = -1;

  List<Offset> points = List<Offset>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("HELLO MNIS"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.close),
        onPressed: () async {
          // print(image);
          points.clear();
          digit = -1;
        },
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Draw Digit Inside The box",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              width: 300,
              // color: Colors.blue,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2, color: Colors.black)),
              child: GestureDetector(
                onPanUpdate: (DragUpdateDetails details) {
                  Offset localPosition = details.localPosition;
                  setState(() {
                    if (localPosition.dx >= 0 &&
                        localPosition.dx < 300 &&
                        localPosition.dy >= 0 &&
                        localPosition.dy < 300) {
                      points.add(localPosition);
                    }

                    // print(points);
                  });
                },
                onPanEnd: (DragEndDetails details) {
                  points.add(null);
                  // digit=await classifier
                },
                child: CustomPaint(painter: Painter(points: points)),
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
              height: 30,
            ),
            Text(
              digit == -1 ? "" : "$digit",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  final List<Offset> points;
  Painter({this.points});

  // print();

  final Paint paintDetails = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..color = Colors.black;
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paintDetails);
      }
    }
  }

  @override
  bool shouldRepaint(Painter oldDelegate) {
    return true;
  }
}
