cmake_minimum_required(VERSION 3.1)
project(v9_cpu)

#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
#set(CMAKE_C_FLAGS "${CMAKE_CXX_FLAGS} -m32 -I../linux -I../root/lib")
include_directories(${v9_cpu_SOURCE_DIR}/linux ${v9_cpu_SOURCE_DIR}/root/lib)
set(CMAKE_C_FLAGS "${CMAKE_CXX_FLAGS} -m32")
link_libraries(m)
set(CPU_SOURCE_FILES
    linux/dir.h
    linux/libc.h
    linux/libm.h
    root/lib/ctype.h
    root/lib/libc.h
    root/lib/libm.h
    root/lib/mem.h
    root/lib/u.h
    root/bin/em.c)

set(CC_SOURCE_FILES
    linux/dir.h
    linux/libc.h
    linux/libm.h
    root/lib/ctype.h
    root/lib/libc.h
    root/lib/libm.h
    root/lib/mem.h
    root/lib/u.h
    root/bin/c.c)

set(EX_SOURCE_FILES
    root/usr/os/os0.c
    root/usr/os/os1.c
    root/usr/os/os2.c
    root/usr/os/os3.c
    root/usr/emhello.c)

set(EX_FILES
        os0
        os1
        os2
        os3
        emhello)

message(STATUS ${CMAKE_C_FLAGS})
message(STATUS ${v9_cpu_BINARY_DIR})
add_executable(v9_cpu ${CPU_SOURCE_FILES})
add_executable(xc ${CC_SOURCE_FILES})

foreach(EX ${EX_FILES})
    add_custom_command(
            OUTPUT ${v9_cpu_BINARY_DIR}/${EX}
            DEPENDS ${v9_cpu_BINARY_DIR}/xc
            COMMAND ${v9_cpu_BINARY_DIR}/xc
            ARGS -o ${v9_cpu_BINARY_DIR}/${EX} -I${v9_cpu_SOURCE_DIR}/root/lib ${v9_cpu_SOURCE_DIR}/root/usr/os/${EX}.c
    )

endforeach(EX)

add_custom_target(ALL
        DEPENDS ${EX_FILES}
        )