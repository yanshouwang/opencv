#ifndef OPENCV_FFI_H
#define OPENCV_FFI_H

#if defined(__GNUC__)
// Attributes to prevent 'unused' function from being removed and to make it visible
#define OPENCV_NATIVE_EXPORT __attribute__((visibility("default"))) __attribute__((used))
#elif defined(_MSC_VER)
// Marking a function for export
#define OPENCV_NATIVE_EXPORT __declspec(dllexport)
#endif

typedef unsigned char BYTE;

#if defined(__cplusplus)
extern "C"
{
#endif // __cplusplus

    OPENCV_NATIVE_EXPORT void laplacian(BYTE *data, int width, int height, int ksize = 1);

#if defined(__cplusplus)
}
#endif // __cplusplus

#endif // OPENCV_NATIVE_H_
