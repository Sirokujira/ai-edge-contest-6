# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/ubuntu/cmake-3.22.2-linux-x86_64/bin/cmake

# The command to remove a file.
RM = /home/ubuntu/cmake-3.22.2-linux-x86_64/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ubuntu/ai-edge-contest-6/test_app

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ubuntu/ai-edge-contest-6/test_app/build

# Include any dependencies generated for this target.
include CMakeFiles/sample_pointpillars_graph_runner.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/sample_pointpillars_graph_runner.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/sample_pointpillars_graph_runner.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/sample_pointpillars_graph_runner.dir/flags.make

CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.o: CMakeFiles/sample_pointpillars_graph_runner.dir/flags.make
CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.o: ../src/anchor.cpp
CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.o: CMakeFiles/sample_pointpillars_graph_runner.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/ai-edge-contest-6/test_app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.o -MF CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.o.d -o CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.o -c /home/ubuntu/ai-edge-contest-6/test_app/src/anchor.cpp

CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ubuntu/ai-edge-contest-6/test_app/src/anchor.cpp > CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.i

CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ubuntu/ai-edge-contest-6/test_app/src/anchor.cpp -o CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.s

CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.o: CMakeFiles/sample_pointpillars_graph_runner.dir/flags.make
CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.o: ../src/helper.cpp
CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.o: CMakeFiles/sample_pointpillars_graph_runner.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/ai-edge-contest-6/test_app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.o -MF CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.o.d -o CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.o -c /home/ubuntu/ai-edge-contest-6/test_app/src/helper.cpp

CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ubuntu/ai-edge-contest-6/test_app/src/helper.cpp > CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.i

CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ubuntu/ai-edge-contest-6/test_app/src/helper.cpp -o CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.s

CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.o: CMakeFiles/sample_pointpillars_graph_runner.dir/flags.make
CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.o: ../src/preprocess.cpp
CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.o: CMakeFiles/sample_pointpillars_graph_runner.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/ai-edge-contest-6/test_app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.o -MF CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.o.d -o CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.o -c /home/ubuntu/ai-edge-contest-6/test_app/src/preprocess.cpp

CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ubuntu/ai-edge-contest-6/test_app/src/preprocess.cpp > CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.i

CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ubuntu/ai-edge-contest-6/test_app/src/preprocess.cpp -o CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.s

CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.o: CMakeFiles/sample_pointpillars_graph_runner.dir/flags.make
CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.o: ../src/pointpillars_post.cpp
CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.o: CMakeFiles/sample_pointpillars_graph_runner.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/ai-edge-contest-6/test_app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.o -MF CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.o.d -o CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.o -c /home/ubuntu/ai-edge-contest-6/test_app/src/pointpillars_post.cpp

CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ubuntu/ai-edge-contest-6/test_app/src/pointpillars_post.cpp > CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.i

CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ubuntu/ai-edge-contest-6/test_app/src/pointpillars_post.cpp -o CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.s

CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.o: CMakeFiles/sample_pointpillars_graph_runner.dir/flags.make
CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.o: ../src/parse_display_result.cpp
CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.o: CMakeFiles/sample_pointpillars_graph_runner.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/ai-edge-contest-6/test_app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.o -MF CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.o.d -o CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.o -c /home/ubuntu/ai-edge-contest-6/test_app/src/parse_display_result.cpp

CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ubuntu/ai-edge-contest-6/test_app/src/parse_display_result.cpp > CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.i

CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ubuntu/ai-edge-contest-6/test_app/src/parse_display_result.cpp -o CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.s

CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.o: CMakeFiles/sample_pointpillars_graph_runner.dir/flags.make
CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.o: ../src/main.cpp
CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.o: CMakeFiles/sample_pointpillars_graph_runner.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/ai-edge-contest-6/test_app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.o -MF CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.o.d -o CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.o -c /home/ubuntu/ai-edge-contest-6/test_app/src/main.cpp

CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ubuntu/ai-edge-contest-6/test_app/src/main.cpp > CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.i

CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ubuntu/ai-edge-contest-6/test_app/src/main.cpp -o CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.s

# Object files for target sample_pointpillars_graph_runner
sample_pointpillars_graph_runner_OBJECTS = \
"CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.o" \
"CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.o" \
"CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.o" \
"CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.o" \
"CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.o" \
"CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.o"

# External object files for target sample_pointpillars_graph_runner
sample_pointpillars_graph_runner_EXTERNAL_OBJECTS =

sample_pointpillars_graph_runner: CMakeFiles/sample_pointpillars_graph_runner.dir/src/anchor.o
sample_pointpillars_graph_runner: CMakeFiles/sample_pointpillars_graph_runner.dir/src/helper.o
sample_pointpillars_graph_runner: CMakeFiles/sample_pointpillars_graph_runner.dir/src/preprocess.o
sample_pointpillars_graph_runner: CMakeFiles/sample_pointpillars_graph_runner.dir/src/pointpillars_post.o
sample_pointpillars_graph_runner: CMakeFiles/sample_pointpillars_graph_runner.dir/src/parse_display_result.o
sample_pointpillars_graph_runner: CMakeFiles/sample_pointpillars_graph_runner.dir/src/main.o
sample_pointpillars_graph_runner: CMakeFiles/sample_pointpillars_graph_runner.dir/build.make
sample_pointpillars_graph_runner: CMakeFiles/sample_pointpillars_graph_runner.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ubuntu/ai-edge-contest-6/test_app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Linking CXX executable sample_pointpillars_graph_runner"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/sample_pointpillars_graph_runner.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/sample_pointpillars_graph_runner.dir/build: sample_pointpillars_graph_runner
.PHONY : CMakeFiles/sample_pointpillars_graph_runner.dir/build

CMakeFiles/sample_pointpillars_graph_runner.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/sample_pointpillars_graph_runner.dir/cmake_clean.cmake
.PHONY : CMakeFiles/sample_pointpillars_graph_runner.dir/clean

CMakeFiles/sample_pointpillars_graph_runner.dir/depend:
	cd /home/ubuntu/ai-edge-contest-6/test_app/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ubuntu/ai-edge-contest-6/test_app /home/ubuntu/ai-edge-contest-6/test_app /home/ubuntu/ai-edge-contest-6/test_app/build /home/ubuntu/ai-edge-contest-6/test_app/build /home/ubuntu/ai-edge-contest-6/test_app/build/CMakeFiles/sample_pointpillars_graph_runner.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/sample_pointpillars_graph_runner.dir/depend
