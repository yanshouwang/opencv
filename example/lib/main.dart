import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opencv/opencv.dart';

void main() {
  runApp(const MyApp());
}

const name = 'images/gage.png';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late ValueNotifier<ui.Image?> imageNotifier;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    imageNotifier = ValueNotifier(null);
    const duration = Duration(seconds: 2);
    controller = AnimationController(vsync: this, duration: duration);
    loadImage();

    controller.repeat();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> loadImage() async {
    try {
      final bytes =
          await rootBundle.load(name).then((data) => data.buffer.asUint8List());
      final codec = await ui.instantiateImageCodec(bytes);
      final image = await codec.getNextFrame().then((frame) => frame.image);
      final source =
          await image.toByteData().then((value) => value!.buffer.asUint8List());
      final data =
          opencv.laplacian(source, image.width, image.height, ksize: 3);
      ui.decodeImageFromPixels(
        data,
        image.width,
        image.height,
        ui.PixelFormat.rgba8888,
        (image) {
          imageNotifier.value = image;
        },
      );
    } catch (error, stack) {
      log('$error\n$stack');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: buildBody(context),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          name,
          fit: BoxFit.cover,
        ),
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return ValueListenableBuilder<ui.Image?>(
              valueListenable: imageNotifier,
              builder: (context, image, child) {
                if (image == null) {
                  return Container();
                } else {
                  return ShaderMask(
                    shaderCallback: (bounds) {
                      const height = 2.0;
                      final top = ui.lerpDouble(
                        -1.0 - height,
                        1.0,
                        animation.value,
                      )!;
                      final bottom = top + height;
                      final colors = [
                        Colors.transparent,
                        Colors.white,
                        Colors.transparent,
                      ];
                      return LinearGradient(
                        begin: Alignment(0.5, top),
                        end: Alignment(0.5, bottom),
                        colors: colors,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: CustomPaint(
                      painter: ImagePainter(image),
                    ),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    imageNotifier.dispose();
    controller.dispose();
    super.dispose();
  }
}

class ImagePainter extends CustomPainter {
  final ui.Image image;

  ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    paintImage(
      canvas: canvas,
      rect: bounds,
      image: image,
      fit: BoxFit.cover,
    );
  }

  @override
  bool shouldRepaint(covariant ImagePainter oldDelegate) {
    return oldDelegate.image != image;
  }
}

class RectClipper extends CustomClipper<Rect> {
  final double value;

  RectClipper(this.value);

  @override
  Rect getClip(ui.Size size) {
    final height = size.height * 0.5;
    final dy = value * (size.height + height);
    final top = dy < height ? 0.0 : dy - height;
    final bottom = dy < size.height ? dy : size.height;
    return Rect.fromLTRB(0.0, top, size.width, bottom);
  }

  @override
  bool shouldReclip(covariant RectClipper oldClipper) {
    return oldClipper.value != value;
  }
}
