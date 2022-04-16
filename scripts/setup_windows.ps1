$headerName = "wrapcv.h"
$cppName = "wrapcv.cpp"
# Native
$nativeDirectory = "native"
$nativeHeaderDirectory = "$nativeDirectory/include"
# Windows
$windowsDirectory = "windows"
$windowsHeaderDirectory = "$windowsDirectory/include"
New-Item "$windowsHeaderDirectory/$headerName" -ItemType HardLink -Value "$nativeHeaderDirectory/$headerName"
New-Item "$windowsDirectory/$cppName" -ItemType HardLink -Value "$nativeDirectory/$cppName"
# Android
$androidDirectory = "android/src/main/cpp"
$androidHeaderDirectory = "$androidDirectory/include"
New-Item $androidDirectory, $androidHeaderDirectory -ItemType Directory
New-Item "$androidHeaderDirectory/$headerName" -ItemType HardLink -Value "$nativeHeaderDirectory/$headerName"
New-Item "$androidDirectory/$cppName" -ItemType HardLink -Value "$nativeDirectory/$cppName"