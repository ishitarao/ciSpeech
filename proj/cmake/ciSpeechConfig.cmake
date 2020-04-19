if(NOT TARGET ciSpeech)
    # Define ${ciSpeech_PROJECT_ROOT}. ${CMAKE_CURRENT_LIST_DIR} is just the current directory.
    get_filename_component(ciSpeech_PROJECT_ROOT "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)

    # Define ${CINDER_PATH} as usual.
    get_filename_component(CINDER_PATH "${ciSpeech_PROJECT_ROOT}/../.." ABSOLUTE)

    # Translate the <staticLibrary> tag.
    # pocketsphinx
    add_library(pocketsphinx STATIC IMPORTED)
    set_property(TARGET pocketsphinx PROPERTY IMPORTED_LOCATION "${ciSpeech_PROJECT_ROOT}/lib/macosx/libpocketsphinx.a")

    # sphinxbase
    add_library(sphinxbase STATIC IMPORTED)
    set_property(TARGET sphinxbase PROPERTY IMPORTED_LOCATION "${ciSpeech_PROJECT_ROOT}/lib/macosx/libsphinxbase.a")

    # Translate the <sourcePattern> tag.
    file(GLOB SOURCE_LIST CONFIGURE_DEPENDS
            "${ciSpeech_PROJECT_ROOT}/src/sphinx/*.cpp"
            )

    # Create the library from the source files. The target is now defined.
    add_library(ciSpeech ${SOURCE_LIST})

    # Link the prebuilt libraries.
    target_link_libraries(ciSpeech pocketsphinx sphinxbase)

    # Translate <includePath> tag.
    target_include_directories(ciSpeech PUBLIC
            "${ciSpeech_PROJECT_ROOT}/include"
            "${ciSpeech_PROJECT_ROOT}/include/pocketsphinx"
            "${ciSpeech_PROJECT_ROOT}/include/sphinxbase"
            )

    # Translate <headerPattern> tag.
    target_include_directories(ciSpeech PRIVATE
            "${ciSpeech_PROJECT_ROOT}/include/sphinx"
            )

    target_include_directories(ciSpeech SYSTEM BEFORE PUBLIC "${CINDER_PATH}/include" )
endif()