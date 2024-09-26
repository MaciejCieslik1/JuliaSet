cmake_minimum_required(VERSION 3.12)
project(JuliaSet C CXX ASM_NASM)

# Set language standards
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Enable NASM for assembly
enable_language(ASM_NASM)

# Find Allegro5 libraries using pkg-config
find_package(PkgConfig REQUIRED)
pkg_check_modules(ALLEGRO5 REQUIRED allegro-5 allegro_font-5)

# Include directories and link directories for Allegro
include_directories(${ALLEGRO5_INCLUDE_DIRS})
link_directories(${ALLEGRO5_LIBRARY_DIRS})

# Set NASM assembly flags
set(CMAKE_ASM_NASM_FLAGS "-f elf64")

# Add the executable with C++, C, and Assembly source files
add_executable(julia SetJulia.c SetJulia.h SetJulia.asm)

# Link the Allegro libraries
target_link_libraries(julia ${ALLEGRO5_LIBRARIES})
