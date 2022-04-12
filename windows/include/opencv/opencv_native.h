#ifndef OPENCV_NATIVE_H_
#define OPENCV_NATIVE_H_

#if defined(__GNUC__)
// Attributes to prevent 'unused' function from being removed and to make it visible
#define OPENCV_NATIVE_EXPORT __attribute__((visibility("default"))) __attribute__((used))
#elif defined(_MSC_VER)
// Marking a function for export
#define OPENCV_NATIVE_EXPORT __declspec(dllexport)
#endif

typedef unsigned char BYTE;
typedef unsigned long long ULONG;

#if defined(__cplusplus)
extern "C"
{
#endif // __cplusplus

    OPENCV_NATIVE_EXPORT void laplacian(BYTE *data, int width, int height);

#if defined(__cplusplus)
}
#endif // __cplusplus

#endif // OPENCV_NATIVE_H_
