import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_mnist/utilities/constants.dart';
// import 'tens';
import 'package:tflite/tflite.dart' as tfl;

class Classifier {
  Classifier();

  classifiyImage(PickedFile image) async {
    var _file = io.File(image.path);
    img.Image imageTemp = img.decodeImage(_file.readAsBytesSync());
    img.Image resizedImage = img.copyResize(imageTemp, height: 28, width: 28);
    var imageByetes = resizedImage.getBytes();
    var imgAsList = imageByetes.buffer.asUint8List();

    return getPred(imgAsList);
  }

  classifiyDrawing(List<Offset> points) async {
    final picture = toPicture(points);

    final resizedImage = await picture.toImage(28, 28);
    ByteData imageByetes = await resizedImage.toByteData();
    var imgAsList = imageByetes.buffer.asUint8List();

    return getPred(imgAsList);
  }

  Future<int> getPred(Uint8List imgAsList) async {
    final resultByte = List(28 * 28);

    int index = 0;

    for (int i = 0; i < imgAsList.length; i += 4) {
      final r = imgAsList[i];
      final g = imgAsList[i + 1];
      final b = imgAsList[i + 2];

      resultByte[index] = ((r + g + b) / 3.0) / 255.0;
      index++;
    }
    var input = resultByte.reshape([1, 28, 28, 1]);
    var output = List(1 * 10).reshape([1, 10]);

    InterpreterOptions interpreterOptions = InterpreterOptions();

    try {
      Interpreter interpreter = await Interpreter.fromAsset("model.tflite",
          options: interpreterOptions);
      // final interpreter = await tfl.Interpreter.fromAsset('your_model.tflite');
      interpreter.run(input, output);
    } catch (e) {
      print("Error Loading Model");
    }

    double heighstProb = 0;
    int digitPred;

    for (int i = 0; i < output[0].length; i++) {
      if (heighstProb < output[0][i]) {
        heighstProb = output[0][i];
        digitPred = i;
      }
    }

    return digitPred;
  }
}

ui.Picture toPicture(List<Offset> points) {
  final _whitePaint = Paint()
    ..strokeCap = StrokeCap.round
    ..color = Colors.white
    ..strokeWidth = 16.0;

  final _bgPaint = Paint()..color = Colors.black;
  final _canvasCallRect = Rect.fromPoints(Offset(0, 0), Offset(28.0, 28.0));

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder, _canvasCallRect)..scale(28 / 300);

  canvas.drawRect(Rect.fromLTWH(0, 0, 28, 28), _bgPaint);

  for (int i = 0; i < points.length - 1; i++) {
    if (points[i] != null && points[i + 1] != null) {
      canvas.drawLine(points[i], points[i + 1], _whitePaint);
    }
  }

  return recorder.endRecording();
}
