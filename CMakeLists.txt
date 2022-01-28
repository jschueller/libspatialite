cmake_minimum_required (VERSION 3.2)

if (NOT DEFINED CMAKE_BUILD_TYPE)
  set (CMAKE_BUILD_TYPE Release CACHE STRING "Build type")
endif ()

project (libspatialite)

option(BUILD_SHARED_LIBS "shared/static" ON)


if (POLICY CMP0074)
  cmake_policy (SET CMP0074 NEW)
endif()

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)


include (GNUInstallDirs)
include (CheckIncludeFiles)
include (CheckIncludeFile)
include (CheckIncludeFileCXX)
include (CheckTypeSize)
include (CheckSymbolExists)
include (CheckFunctionExists)
include (CheckLibraryExists)
include (CheckCSourceCompiles)

check_include_file ("stdlib.h" HAVE_STDLIB_H)
check_include_file ("stdio.h" HAVE_STDIO_H)
check_include_file ("string.h" HAVE_STRING_H)
check_include_file ("memory.h" HAVE_MEMORY_H)
check_include_file ("math.h" HAVE_MATH_H)
check_include_file ("float.h" HAVE_FLOAT_H)
check_include_file ("inttypes.h" HAVE_INTTYPES_H)
check_include_file ("sys/time.h" HAVE_SYS_TIME_H)
check_include_file ("unistd.h" HAVE_UNISTD_H)


find_package (LibXml2 REQUIRED)
find_package (Minizip REQUIRED)
find_package (ZLIB REQUIRED)
find_package (SQLite3 REQUIRED)
find_package (Proj)
find_package (GEOS)
find_package (FreeXL)
find_package (LibRTTopo)
find_package (Iconv)

add_library (spatialite
  src/gaiaaux/gg_sqlaux.c src/gaiaaux/gg_utf8.c
  src/gaiaexif/gaia_exif.c
  src/gaiageo/gg_advanced.c
	src/gaiageo/gg_endian.c src/gaiageo/gg_ewkt.c
	src/gaiageo/gg_geodesic.c src/gaiageo/gg_geoJSON.c
	src/gaiageo/gg_geometries.c src/gaiageo/gg_geoscvt.c
	src/gaiageo/gg_gml.c src/gaiageo/gg_kml.c
	src/gaiageo/gg_relations.c src/gaiageo/gg_shape.c
	src/gaiageo/gg_transform.c src/gaiageo/gg_vanuatu.c
	src/gaiageo/gg_wkb.c src/gaiageo/gg_wkt.c
	src/gaiageo/gg_extras.c src/gaiageo/gg_xml.c
	src/gaiageo/gg_voronoj.c src/gaiageo/gg_matrix.c
	src/gaiageo/gg_relations_ext.c src/gaiageo/gg_rttopo.c
	src/connection_cache/alloc_cache.c src/connection_cache/gg_sequence.c
	src/spatialite/mbrcache.c src/shapefiles/shapefiles.c
	src/spatialite/spatialite.c src/spatialite/virtualdbf.c
	src/spatialite/virtualfdo.c src/spatialite/virtualnetwork.c
	src/spatialite/virtualshape.c src/spatialite/virtualspatialindex.c
	src/spatialite/statistics.c src/spatialite/metatables.c
	src/spatialite/virtualXL.c src/spatialite/extra_tables.c
	src/spatialite/virtualxpath.c src/spatialite/virtualbbox.c
	src/spatialite/spatialite_init.c src/spatialite/se_helpers.c
	src/spatialite/srid_aux.c src/spatialite/table_cloner.c
	src/spatialite/virtualelementary.c src/spatialite/virtualgeojson.c
	src/spatialite/virtualrouting.c src/spatialite/create_routing.c
	src/spatialite/dbobj_scopes.c src/spatialite/pause.c
	src/wfs/wfs_in.c src/srsinit/srs_init.c src/spatialite/virtualgpkg.c
	src/dxf/dxf_parser.c src/dxf/dxf_loader.c src/dxf/dxf_writer.c
	src/dxf/dxf_load_distinct.c src/dxf/dxf_load_mixed.c
	src/shapefiles/validator.c src/md5/md5.c src/md5/gaia_md5.c
	src/srsinit/epsg_inlined_00.c src/srsinit/epsg_inlined_01.c
	src/srsinit/epsg_inlined_02.c src/srsinit/epsg_inlined_03.c
	src/srsinit/epsg_inlined_04.c src/srsinit/epsg_inlined_05.c
	src/srsinit/epsg_inlined_06.c src/srsinit/epsg_inlined_07.c
	src/srsinit/epsg_inlined_08.c src/srsinit/epsg_inlined_09.c
	src/srsinit/epsg_inlined_10.c src/srsinit/epsg_inlined_11.c
	src/srsinit/epsg_inlined_12.c src/srsinit/epsg_inlined_13.c
	src/srsinit/epsg_inlined_14.c src/srsinit/epsg_inlined_15.c
	src/srsinit/epsg_inlined_16.c src/srsinit/epsg_inlined_17.c
	src/srsinit/epsg_inlined_18.c src/srsinit/epsg_inlined_19.c
	src/srsinit/epsg_inlined_20.c src/srsinit/epsg_inlined_21.c
	src/srsinit/epsg_inlined_22.c src/srsinit/epsg_inlined_23.c
	src/srsinit/epsg_inlined_24.c src/srsinit/epsg_inlined_25.c
	src/srsinit/epsg_inlined_26.c src/srsinit/epsg_inlined_27.c
	src/srsinit/epsg_inlined_28.c src/srsinit/epsg_inlined_29.c
	src/srsinit/epsg_inlined_30.c src/srsinit/epsg_inlined_31.c
	src/srsinit/epsg_inlined_32.c src/srsinit/epsg_inlined_33.c
	src/srsinit/epsg_inlined_34.c src/srsinit/epsg_inlined_35.c
	src/srsinit/epsg_inlined_36.c src/srsinit/epsg_inlined_37.c
	src/srsinit/epsg_inlined_38.c src/srsinit/epsg_inlined_39.c
	src/srsinit/epsg_inlined_40.c src/srsinit/epsg_inlined_41.c
	src/srsinit/epsg_inlined_42.c src/srsinit/epsg_inlined_43.c
	src/srsinit/epsg_inlined_44.c src/srsinit/epsg_inlined_45.c
	src/srsinit/epsg_inlined_46.c src/srsinit/epsg_inlined_47.c
	src/srsinit/epsg_inlined_48.c src/srsinit/epsg_inlined_49.c
	src/srsinit/epsg_inlined_50.c src/srsinit/epsg_inlined_51.c
	src/srsinit/epsg_inlined_52.c src/srsinit/epsg_inlined_53.c
	src/srsinit/epsg_inlined_54.c src/srsinit/epsg_inlined_55.c
	src/srsinit/epsg_inlined_56.c src/srsinit/epsg_inlined_57.c
	src/srsinit/epsg_inlined_58.c src/srsinit/epsg_inlined_59.c
	src/srsinit/epsg_inlined_extra.c src/srsinit/epsg_inlined_prussian.c
	src/srsinit/epsg_inlined_wgs84_00.c src/srsinit/epsg_inlined_wgs84_01.c
	src/versioninfo/version.c src/virtualtext/virtualtext.c
	src/cutter/gaia_cutter.c src/spatialite/virtualknn.c
	src/control_points/gaia_control_points.c
	src/control_points/grass_crs3d.c src/control_points/grass_georef_tps.c
	src/control_points/grass_georef.c src/stored_procedures/stored_procedures.c
	src/geopackage/gaia_cvt_gpkg.c
	src/geopackage/gpkgAddGeometryColumn.c
	src/geopackage/gpkg_add_geometry_triggers.c
	src/geopackage/gpkg_add_spatial_index.c
	src/geopackage/gpkg_add_tile_triggers.c
	src/geopackage/gpkgBinary.c
	src/geopackage/gpkgCreateBaseTables.c
	src/geopackage/gpkgCreateTilesTable.c
	src/geopackage/gpkgCreateTilesZoomLevel.c
	src/geopackage/gpkgGetImageType.c
	src/geopackage/gpkg_get_normal_row.c
	src/geopackage/gpkg_get_normal_zoom.c
	src/geopackage/gpkgInsertEpsgSRID.c
	src/geopackage/gpkgMakePoint.c
	src/topology/gaia_auxnet.c src/topology/gaia_auxtopo.c
	src/topology/gaia_auxtopo_table.c src/topology/gaia_netstmts.c
	src/topology/gaia_network.c src/topology/gaia_topology.c
	src/topology/gaia_topostmts.c src/topology/lwn_network.c
	src/topology/net_callbacks.c src/topology/topo_callbacks.c
)

install (FILES src/headers/spatialite.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install (DIRECTORY src/headers/spatialite DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

install(TARGETS spatialite
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

target_include_directories(spatialite PRIVATE ${PROJECT_SOURCE_DIR} ${PROJECT_SOURCE_DIR}/src/headers ${PROJECT_SOURCE_DIR}/src/topology)

target_link_libraries(spatialite PRIVATE LibXml2::LibXml2)
target_compile_definitions(spatialite PRIVATE ENABLE_LIBXML2)

target_link_libraries(spatialite PRIVATE ZLIB::ZLIB)

target_link_libraries(spatialite PRIVATE SQLite::SQLite3)

target_link_libraries(spatialite PRIVATE Minizip::Minizip)

if (FreeXL_FOUND)
  target_link_libraries(spatialite PRIVATE FREEXL::freexl)
else ()
  target_compile_definitions(spatialite PRIVATE OMIT_FREEXL)
endif ()

if (GEOS_FOUND)
  target_link_libraries(spatialite PRIVATE GEOS::GEOS)
else ()
  target_compile_definitions(spatialite PRIVATE OMIT_GEOS)
endif ()

if (Proj_FOUND)
  target_include_directories(spatialite PRIVATE ${PROJ_INCLUDE_DIR})
  target_link_libraries(spatialite PRIVATE ${PROJ_LIBRARY})
else ()
  target_compile_definitions(spatialite PRIVATE OMIT_PROJ)
endif ()

if (LibRTTopo_FOUND)
  target_link_libraries(spatialite PRIVATE LibRTTopo::LibRTTopo)
  target_compile_definitions(spatialite PRIVATE ENABLE_RTTOPO)
endif ()

if (Iconv_FOUND)
  target_link_libraries(spatialite PRIVATE Iconv::Iconv)
else ()
  target_compile_definitions(spatialite PRIVATE OMIT_ICONV)
endif ()

if (NOT HAVE_UNISTD_H)
  target_compile_definitions(spatialite PRIVATE YY_NO_UNISTD_H)
endif ()
