import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart' as ffi;

import 'src/opencv_native.dart';

final _lib = DynamicLibrary.open('opencv_plugin.dll');
final _opencv = OpenCV(_lib);

Uint8List laplacian(Uint8List source, int width, int height) {
  final data = ffi.malloc<Uint8>(source.length);
  try {
    for (var i = 0; i < source.length; i++) {
      data.elementAt(i).value = source[i];
    }
    _opencv.laplacian(data, width, height);
    return data.asTypedList(source.length);
  } finally {
    ffi.malloc.free(data);
  }
}
