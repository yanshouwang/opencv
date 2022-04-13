#ifndef WRAPCV_H
#define WRAPCV_H

#if defined(__GNUC__)
// Attributes to prevent 'unused' function from being removed and to make it visible
#define WRAPCV_EXPORT __attribute__((visibility("default"))) __attribute__((used))
#elif defined(_MSC_VER)
// Marking a function for export
#define WRAPCV_EXPORT __declspec(dllexport)
#endif

typedef unsigned char BYTE;

#if defined(__cplusplus)
extern "C"
{
#endif // __cplusplus

    WRAPCV_EXPORT void laplacian(BYTE *data, int width, int height, int ksize);

#if defined(__cplusplus)
}
#endif // __cplusplus

#endif // WRAPCV_H
