import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart' as ffi;

import 'src/opencv_native.dart';

late final _lib = Platform.isAndroid
    ? DynamicLibrary.open('libopencv_ffi.so')
    : Platform.isWindows
        ? DynamicLibrary.open('opencv_plugin.dll')
        : DynamicLibrary.process();

late final _opencv = OpenCV(_lib);

Uint8List laplacian(
  Uint8List source,
  int width,
  int height, {
  int ksize = 1,
}) {
  final size = sizeOf<Uint8>() * source.length;
  final data = ffi.malloc.allocate<Uint8>(size);
  try {
    final view = data.asTypedList(source.length);
    view.setAll(0, source);
    _opencv.laplacian(data, width, height, ksize);
    return Uint8List.fromList(view);
  } finally {
    ffi.malloc.free(data);
  }
}
