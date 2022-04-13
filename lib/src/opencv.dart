import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart' as ffi;

import 'wrapcv.dart';

final opencv = OpenCV._();

abstract class OpenCV {
  factory OpenCV._() => _OpenCV();

  Uint8List laplacian(Uint8List source, int width, int height, {int ksize = 1});
}

class _OpenCV implements OpenCV {
  late final wrapcv = WrapCV(dynamicLibrary);

  DynamicLibrary get dynamicLibrary {
    if (Platform.isAndroid) {
      return DynamicLibrary.open('libwrapcv.so');
    } else if (Platform.isWindows) {
      return DynamicLibrary.open('opencv_plugin.dll');
    } else {
      return DynamicLibrary.process();
    }
  }

  @override
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
      wrapcv.laplacian(data, width, height, ksize);
      return Uint8List.fromList(view);
    } finally {
      ffi.malloc.free(data);
    }
  }
}
