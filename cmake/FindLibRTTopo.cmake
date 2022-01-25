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
# If it's found it sets LIBRTTOPO_FOUND to TRUE
# and following variables are set:
#    LIBRTTOPO_INCLUDE_DIR
#    LIBRTTOPO_LIBRARY
#

find_path(LIBRTTOPO_INCLUDE_DIR NAMES librttopo.h
          HINTS ${LIBRTTOPO_PREFIX}/include)
find_library(LIBRTTOPO_LIBRARY NAMES rttopo
             HINTS ${LIBRTTOPO_PREFIX}/lib)
mark_as_advanced(LIBRTTOPO_INCLUDE_DIR LIBRTTOPO_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibRTTopo FOUND_VAR LIBRTTOPO_FOUND
                                  REQUIRED_VARS LIBRTTOPO_LIBRARY LIBRTTOPO_INCLUDE_DIR)

if(LIBRTTOPO_FOUND)
    set(LIBRTTOPO_LIBRARIES ${LIBRTTOPO_LIBRARY})
    set(LIBRTTOPO_INCLUDE_DIRS ${LIBRTTOPO_INCLUDE_DIR})

    if(NOT TARGET LibRTTopo::LibRTTopo)
        add_library(LibRTTopo::LibRTTopo UNKNOWN IMPORTED)
        set_target_properties(LibRTTopo::LibRTTopo PROPERTIES
                              INTERFACE_INCLUDE_DIRECTORIES "${LIBRTTOPO_INCLUDE_DIR}"
                              IMPORTED_LINK_INTERFACE_LANGUAGES "C"
                              IMPORTED_LOCATION "${LIBRTTOPO_LIBRARY}")
    endif()
endif()
