# Windows
New-Item ../windows/include/wrapcv.h -ItemType HardLink -Value ../native/include/wrapcv.h
New-Item ../windows/wrapcv.cpp -ItemType HardLink -Value ../native/wrapcv.cpp
# Android
New-Item ../android/src/main/cpp, ../android/src/main/cpp/include -ItemType Directory 
New-Item ../android/src/main/cpp/include/wrapcv.h -ItemType HardLink -Value ../native/include/wrapcv.h
New-Item ../android/src/main/cpp/wrapcv.cpp -ItemType HardLink -Value ../native/wrapcv.cpp
