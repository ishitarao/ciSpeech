if(NOT TARGET ciSpeech)
    # Define ${ciSpeech_PROJECT_ROOT}. ${CMAKE_CURRENT_LIST_DIR} is just the current directory.
    get_filename_component(ciSpeech_PROJECT_ROOT "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)

    # Define ${CINDER_PATH} as usual.
    get_filename_component(CINDER_PATH "${ciSpeech_PROJECT_ROOT}/../.." ABSOLUTE)

    # Make a list of source files and define that to be ${SOURCE_LIST}.
    file(GLOB SOURCE_LIST CONFIGURE_DEPENDS
            "${ciSpeech_PROJECT_ROOT}/src/**/*.h"
            "${ciSpeech_PROJECT_ROOT}/src/**/*.hpp"
            "${ciSpeech_PROJECT_ROOT}/src/**/*.cc"
            "${ciSpeech_PROJECT_ROOT}/src/**/*.cpp"
            "${ciSpeech_PROJECT_ROOT}/src/**/*.c"
            "${ciSpeech_PROJECT_ROOT}/src/*.h"
            "${ciSpeech_PROJECT_ROOT}/src/*.hpp"
            "${ciSpeech_PROJECT_ROOT}/src/*.cc"
            "${ciSpeech_PROJECT_ROOT}/src/*.cpp"
            "${ciSpeech_PROJECT_ROOT}/src/*.c")

    # Create the library!
    add_library(ciSpeech ${SOURCE_LIST})

    # Add include directories.
    # Notice that `cinderblock.xml` has `<includePath>src</includePath>`.
    # So you need to set `../../src/` to include.
    target_include_directories(ciSpeech PUBLIC "${ciSpeech_PROJECT_ROOT}/src" )
    target_include_directories(ciSpeech SYSTEM BEFORE PUBLIC "${CINDER_PATH}/include" )
    target_include_directories(ciSpeech PUBLIC
            "${CMAKE_CURRENT_LIST_DIR}/../../include"
            "${CMAKE_CURRENT_LIST_DIR}/../../include/pocketsphinx"
            "${CMAKE_CURRENT_LIST_DIR}/../../include/sphinxbase"
            )
    target_include_directories(ciSpeech PRIVATE
            "${CMAKE_CURRENT_LIST_DIR}/../../include/sphinx"
            )


    # If your Cinder block has no source code but instead pre-build libraries,
    # you can specify all of them here (uncomment the below line and adjust to your needs).
    # Make sure to use the libraries for the right platform.
    # # target_link_libraries(ciSpeech "${Cinder-OpenCV_PROJECT_ROOT}/lib/libopencv_core.a")

    if(NOT TARGET cinder)
        include("${CINDER_PATH}/proj/cmake/configure.cmake")
        find_package(cinder REQUIRED PATHS
                "${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
                "$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}")
    endif()
    target_link_libraries(ciSpeech PRIVATE cinder)

endif()