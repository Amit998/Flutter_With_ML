import 'package:flutter/material.dart';
import 'package:picture_generator/drawingArea.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  List<DrawingArea> points = [];
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
                  Color.fromRGBO(233, 64, 62, 1.0),
                  Color.fromRGBO(64, 100, 33, 1.0),
                ])),
          ),
          _loading == true
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Container(
                              width: 256,
                              height: 256,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 5.0,
                                        spreadRadius: 1)
                                  ]),
                              child: GestureDetector(
                                onPanDown: (details) {
                                  this.setState(() {
                                    points.add(DrawingArea(
                                        point: details.localPosition,
                                        areaPaint: Paint()
                                          ..strokeCap = StrokeCap.round
                                          ..isAntiAlias = true
                                          ..color = Colors.black
                                          ..strokeWidth = 5.0));
                                  });
                                },
                                onPanUpdate: (details) {
                                  this.setState(() {
                                    points.add(DrawingArea(
                                        point: details.localPosition,
                                        areaPaint: Paint()
                                          ..strokeCap = StrokeCap.round
                                          ..isAntiAlias = true
                                          ..color = Colors.black
                                          ..strokeWidth = 5.0));
                                  });
                                },
                                onPanEnd: (details) {
                                  this.setState(() {
                                    points.add(null);
                                  });
                                },
                                child: SizedBox.expand(
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    child: CustomPaint(
                                      painter: MyCustomPainter(points: points),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
