# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.7

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = "C:\Program Files\JetBrains\CLion 2017.1.1\bin\cmake\bin\cmake.exe"

# The command to remove a file.
RM = "C:\Program Files\JetBrains\CLion 2017.1.1\bin\cmake\bin\cmake.exe" -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "C:\Users\idan8\Google Drive\UTK\Spring 2017\ECE 459\labs\ece459\project\Hamming_distance"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "C:\Users\idan8\Google Drive\UTK\Spring 2017\ECE 459\labs\ece459\project\Hamming_distance\cmake-build-debug"

# Include any dependencies generated for this target.
include CMakeFiles/Hamming_distance.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/Hamming_distance.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Hamming_distance.dir/flags.make

CMakeFiles/Hamming_distance.dir/scratch.cpp.obj: CMakeFiles/Hamming_distance.dir/flags.make
CMakeFiles/Hamming_distance.dir/scratch.cpp.obj: ../scratch.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\idan8\Google Drive\UTK\Spring 2017\ECE 459\labs\ece459\project\Hamming_distance\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/Hamming_distance.dir/scratch.cpp.obj"
	C:\TDM-GCC-64\bin\g++.exe   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\Hamming_distance.dir\scratch.cpp.obj -c "C:\Users\idan8\Google Drive\UTK\Spring 2017\ECE 459\labs\ece459\project\Hamming_distance\scratch.cpp"

CMakeFiles/Hamming_distance.dir/scratch.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Hamming_distance.dir/scratch.cpp.i"
	C:\TDM-GCC-64\bin\g++.exe  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\idan8\Google Drive\UTK\Spring 2017\ECE 459\labs\ece459\project\Hamming_distance\scratch.cpp" > CMakeFiles\Hamming_distance.dir\scratch.cpp.i

CMakeFiles/Hamming_distance.dir/scratch.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Hamming_distance.dir/scratch.cpp.s"
	C:\TDM-GCC-64\bin\g++.exe  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\idan8\Google Drive\UTK\Spring 2017\ECE 459\labs\ece459\project\Hamming_distance\scratch.cpp" -o CMakeFiles\Hamming_distance.dir\scratch.cpp.s

CMakeFiles/Hamming_distance.dir/scratch.cpp.obj.requires:

.PHONY : CMakeFiles/Hamming_distance.dir/scratch.cpp.obj.requires

CMakeFiles/Hamming_distance.dir/scratch.cpp.obj.provides: CMakeFiles/Hamming_distance.dir/scratch.cpp.obj.requires
	$(MAKE) -f CMakeFiles\Hamming_distance.dir\build.make CMakeFiles/Hamming_distance.dir/scratch.cpp.obj.provides.build
.PHONY : CMakeFiles/Hamming_distance.dir/scratch.cpp.obj.provides

CMakeFiles/Hamming_distance.dir/scratch.cpp.obj.provides.build: CMakeFiles/Hamming_distance.dir/scratch.cpp.obj


# Object files for target Hamming_distance
Hamming_distance_OBJECTS = \
"CMakeFiles/Hamming_distance.dir/scratch.cpp.obj"

# External object files for target Hamming_distance
Hamming_distance_EXTERNAL_OBJECTS =

Hamming_distance.exe: CMakeFiles/Hamming_distance.dir/scratch.cpp.obj
Hamming_distance.exe: CMakeFiles/Hamming_distance.dir/build.make
Hamming_distance.exe: CMakeFiles/Hamming_distance.dir/linklibs.rsp
Hamming_distance.exe: CMakeFiles/Hamming_distance.dir/objects1.rsp
Hamming_distance.exe: CMakeFiles/Hamming_distance.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="C:\Users\idan8\Google Drive\UTK\Spring 2017\ECE 459\labs\ece459\project\Hamming_distance\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable Hamming_distance.exe"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\Hamming_distance.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Hamming_distance.dir/build: Hamming_distance.exe

.PHONY : CMakeFiles/Hamming_distance.dir/build

CMakeFiles/Hamming_distance.dir/requires: CMakeFiles/Hamming_distance.dir/scratch.cpp.obj.requires

.PHONY : CMakeFiles/Hamming_distance.dir/requires

CMakeFiles/Hamming_distance.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles\Hamming_distance.dir\cmake_clean.cmake
.PHONY : CMakeFiles/Hamming_distance.dir/clean

CMakeFiles/Hamming_distance.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" "C:\Users\idan8\Google Drive\UTK\Spring 2017\ECE 459\labs\ece459\project\Hamming_distance" "C:\Users\idan8\Google Drive\UTK\Spring 2017\ECE 459\labs\ece459\project\Hamming_distance" "C:\Users\idan8\Google Drive\UTK\Spring 2017\ECE 459\labs\ece459\project\Hamming_distance\cmake-build-debug" "C:\Users\idan8\Google Drive\UTK\Spring 2017\ECE 459\labs\ece459\project\Hamming_distance\cmake-build-debug" "C:\Users\idan8\Google Drive\UTK\Spring 2017\ECE 459\labs\ece459\project\Hamming_distance\cmake-build-debug\CMakeFiles\Hamming_distance.dir\DependInfo.cmake" --color=$(COLOR)
.PHONY : CMakeFiles/Hamming_distance.dir/depend
