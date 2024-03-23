cmake_minimum_required(VERSION 3.10)
project(jvm-hijack-lib)
set(CMAKE_C_STANDARD 99)
set(JAVA_HOME /Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home)

find_package(JNI REQUIRED)
include_directories(${JNI_INCLUDE_DIRS} ${JAVA_INCLUDE_PATH} ${JNI_LIBRARIES})
find_library(JVM_LIBRARY jvm PATHS ${JAVA_HOME}/lib/server ${JAVA_HOME}/lib/client  ${JAVA_HOME}/jre/lib/client)
include(UseJava)
include_directories(${JNI_INCLUDE_DIRS} ${_classDir} ${_stubDir})

if (JNI_FOUND)
    message (STATUS "JNI_INCLUDE_DIRS=${JNI_INCLUDE_DIRS}")
    message (STATUS "JNI_LIBRARIES=${JNI_LIBRARIES}")
    message (STATUS "JAVA_HOME=${JAVA_HOME}")
endif()

#set(SOURCE_FILES redefineProcessBuilder.cpp)
#add_library(jvm-hijack-lib SHARED ${SOURCE_FILES})
