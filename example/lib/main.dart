import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:opencv/opencv.dart' as opencv;

void main() {
  runApp(const MyApp());
}

const name = 'images/apple.png';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ValueNotifier<ui.Image?> bytesNotifier;

  @override
  void initState() {
    super.initState();
    bytesNotifier = ValueNotifier(null);
    loadBytes();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> loadBytes() async {
    final bytes =
        await rootBundle.load(name).then((data) => data.buffer.asUint8List());
    final codec = await ui.instantiateImageCodec(bytes);
    final image = await codec.getNextFrame().then((frame) => frame.image);
    final source =
        await image.toByteData().then((value) => value!.buffer.asUint8List());
    final data = opencv.laplacian(source, image.width, image.height);
    try {
      ui.decodeImageFromPixels(
        data,
        image.width,
        image.height,
        ui.PixelFormat.rgba8888,
        (image) {
          bytesNotifier.value = image;
        },
      );
    } catch (e, s) {
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return ValueListenableBuilder<ui.Image?>(
      valueListenable: bytesNotifier,
      builder: (context, bytes, child) {
        if (bytes == null) {
          return Container();
        } else {
          return CustomPaint(
            painter: ImagePainter(bytes),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    bytesNotifier.dispose();
    super.dispose();
  }
}

class ImagePainter extends CustomPainter {
  final ui.Image image;

  ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    final paint = Paint();
    canvas.drawImage(image, bounds.center, paint);
  }

  @override
  bool shouldRepaint(covariant ImagePainter oldDelegate) {
    return oldDelegate.image != image;
  }
}
