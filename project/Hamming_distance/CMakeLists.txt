cmake_minimum_required(VERSION 3.7)
project(Hamming_distance)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES
        HD.cpp)

add_executable(Hamming_distance ${SOURCE_FILES})