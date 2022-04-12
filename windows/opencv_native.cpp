#include "include/opencv/opencv_native.h"

#include <opencv2/opencv.hpp>

using namespace cv;

void laplacian(BYTE *data, int width, int height)
{
    Mat src = Mat(height, width, CV_8UC4, data);
    Mat dst;
    Laplacian(src, dst, CV_8U, 3);
    ULONG size = dst.total() * dst.elemSize() * sizeof(uchar);
    memcpy(data, dst.data, size);
}