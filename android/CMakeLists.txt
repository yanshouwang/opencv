cmake_minimum_required(VERSION 3.4.1)

set("OpenCV_ANDROID" $ENV{OpenCV_ANDROID})
include_directories(${OpenCV_ANDROID}/jni/include)
add_library(lib_opencv SHARED IMPORTED)
set_target_properties(lib_opencv PROPERTIES IMPORTED_LOCATION ${OpenCV_ANDROID}/libs/${ANDROID_ABI}/libopencv_java4.so)
add_library(wrapcv SHARED src/main/cpp/wrapcv.cpp)
target_link_libraries(wrapcv lib_opencv)