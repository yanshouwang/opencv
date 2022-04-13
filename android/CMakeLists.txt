cmake_minimum_required(VERSION 3.4.1)

include_directories(C:/Users/yanshouwang/source/Android/opencv/sdk/native/jni/include)
add_library(lib_opencv SHARED IMPORTED)
set_target_properties(lib_opencv PROPERTIES IMPORTED_LOCATION C:/Users/yanshouwang/source/Android/opencv/sdk/native/libs/${ANDROID_ABI}/libopencv_java4.so)
add_library(opencv_ffi SHARED src/main/cpp/opencv_ffi.cpp)
target_link_libraries(opencv_ffi lib_opencv)