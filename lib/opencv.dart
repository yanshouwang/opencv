import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart' as ffi;

import 'src/opencv_native.dart';

final _lib = DynamicLibrary.open('opencv_plugin.dll');
final _opencv = OpenCV(_lib);

Uint8List laplacian(Uint8List source, int width, int height) {
  final size = sizeOf<Uint8>() * source.length;
  final data = ffi.malloc.allocate<Uint8>(size);
  try {
    final view = data.asTypedList(source.length);
    view.setAll(0, source);
    _opencv.laplacian(data, width, height);
    return Uint8List.fromList(view);
  } finally {
    ffi.malloc.free(data);
  }
}
