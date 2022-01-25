# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#.rst:
# FindGEOS
# -----------
#
# CMake module to search for GEOS library
#
# Copyright (C) 2017-2018, Hiroshi Miura
# Copyright (c) 2008, Mateusz Loskot <mateusz@loskot.net>
# (based on FindGDAL.cmake by Magnus Homann)
#
# If it's found it sets MINIZIP_FOUND to TRUE
# and following variables are set:
#    MINIZIP_INCLUDE_DIR
#    MINIZIP_LIBRARY
#

find_path(MINIZIP_INCLUDE_DIR NAMES minizip/zip.h
          HINTS ${MINIZIP_PREFIX}/include)
find_library(MINIZIP_LIBRARY NAMES minizip
             HINTS ${MINIZIP_PREFIX}/lib)
mark_as_advanced(MINIZIP_INCLUDE_DIR MINIZIP_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Minizip FOUND_VAR MINIZIP_FOUND
                                  REQUIRED_VARS MINIZIP_LIBRARY MINIZIP_INCLUDE_DIR)

if(MINIZIP_FOUND)
    set(MINIZIP_LIBRARIES ${MINIZIP_LIBRARY})
    set(MINIZIP_INCLUDE_DIRS ${MINIZIP_INCLUDE_DIR})

    if(NOT TARGET Minizip::Minizip)
        add_library(Minizip::Minizip UNKNOWN IMPORTED)
        set_target_properties(Minizip::Minizip PROPERTIES
                              INTERFACE_INCLUDE_DIRECTORIES "${MINIZIP_INCLUDE_DIR}"
                              IMPORTED_LINK_INTERFACE_LANGUAGES "C"
                              IMPORTED_LOCATION "${MINIZIP_LIBRARY}")
    endif()
endif()
