# Windows
New-Item -ItemType HardLink -Path ../windows/opencv_ffi.cpp -Target ../ffi/opencv_ffi.cpp
New-Item -ItemType HardLink -Path ../windows/include/opencv_ffi.h -Target ../ffi/include/opencv_ffi.h
# Android
New-Item -ItemType HardLink -Path ../android/src/main/cpp/opencv_ffi.cpp -Target ../ffi/opencv_ffi.cpp
New-Item -ItemType HardLink -Path ../android/src/main/cpp/include/opencv_ffi.h -Target ../ffi/include/opencv_ffi.h