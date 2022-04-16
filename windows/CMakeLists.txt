cmake_minimum_required(VERSION 3.14)
set(PROJECT_NAME "opencv")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "opencv_plugin")

set(OpenCV_DIR $ENV{OPENCV_WINDOWS})
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

get_target_property(OPENCV_DLL_DEBUG opencv_world IMPORTED_LOCATION_DEBUG)
get_target_property(OPENCV_DLL_RELEASE opencv_world IMPORTED_LOCATION_RELEASE)

set(OPENCV_DLL
  $<$<CONFIG:Debug>:${OPENCV_DLL_DEBUG}>
  $<$<CONFIG:Profile>:${OPENCV_DLL_RELEASE}>
  $<$<CONFIG:Release>:${OPENCV_DLL_RELEASE}>
)

add_library(${PLUGIN_NAME} SHARED
  "opencv_plugin.cpp"
  "wrapcv.cpp"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE ${OpenCV_LIBS} flutter flutter_wrapper_plugin)

# List of absolute paths to libraries that should be bundled with the plugin
set(opencv_bundled_libraries
  ""
  ${OPENCV_DLL}
  PARENT_SCOPE
)
