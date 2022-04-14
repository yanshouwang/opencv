# opencv

Use OpenCV with dart:ffi

## Getting Started

### Windows

- Download Windows and Android SDK from [OpenCV releases](https://opencv.org/releases/)
- Extract the Windows SDK, set `OpenCV_DIR` with `<opencv direcotry>/build` in the `PATH`
- Extract the Android SDK, set `OpenCV_ANDROID` with `<opencv direcotry>/sdk/native` in the `PATH`
- Run the `setup_windows.ps1` script in the scripts folder.
- Now you can run the opencv example which call the `laplacian` function with dart:ffi

## Available APIs

- laplcian

## Konwn Issues

- Only available on Windows and Android for now, iOS, macOS and Linux is on the way!

## Acknowledgments

- [westracer/flutter_native_opencv](https://github.com/westracer/flutter_native_opencv)
