#include "include/opencv_ffi.h"

#include <opencv2/opencv.hpp>

using namespace cv;

void laplacian(BYTE *dataPointer, int width, int height, int ksize)
{
    auto src = Mat(height, width, CV_8UC4, dataPointer);
    Mat dst;
    Laplacian(src, dst, CV_8U, ksize);
    auto size = dst.total() * dst.elemSize() * sizeof(uchar);
    memcpy(dataPointer, dst.data, size);
}