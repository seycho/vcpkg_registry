#vim:ts=4:

set(REV_PKG_NAME "revtest01")
set(REV_TEST1_VERSION 1.0.2)
set(GIT_VCPKG https://github.com/seycho)

#vcpkg_download_distfile(ARCHIVE
#    URLS
#        "https://ftp.gnu.org/gnu/${REV_PKG_NAME}/${REV_PKG_NAME}-${REV_TEST1_VERSION}.tar.gz"
#        "https://www.mirrorservice.org/sites/ftp.gnu.org/gnu/${REV_PKG_NAME}/${REV_PKG_NAME}-${REV_TEST1_VERSION}.tar.gz"
#    FILENAME "${REV_PKG_NAME}-${REV_TEST1_VERSION}.tar.gz"
#    SHA512 4dc62ed191342a61cc2767171bb1ff4050f390db14ef7100299888237b52ea0b04b939c843878fe7f5daec2b35a47b3c1b7e7c11fb32d458184fe6b19986a37c
#)
#
#vcpkg_extract_source_archive_ex(
#    ARCHIVE "${ARCHIVE}"
#    OUT_SOURCE_PATH SOURCE_PATH
#)

message("==================================================")
message("BUILD PATH: ${CURRENT_BUILDTREES_DIR}")
execute_process(COMMAND bash -c "pwd")
message("CWD: ${cwd} ${pwd}")
message("SRC URL: ${GIT_VCPKG}/${REV_PKG_NAME}")
message("==================================================")
vcpkg_from_git(
	OUT_SOURCE_PATH SOURCE_PATH
	URL ${GIT_VCPKG}/${REV_PKG_NAME}
	REF 788b2503b1aa0b695d50772d7599a3350594c235
)


message("==================================================")
message("BUILD PATH: ${CURRENT_BUILDTREES_DIR}")
message("VCPKG_LIBRARY_LINKAGE: ${VCPKG_LIBRARY_LINKAGE}")
message("==================================================")
if(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)

    vcpkg_install_msbuild(
        SOURCE_PATH "${SOURCE_PATH}"
		PROJECT_PATH revTest01_OCV.sln
        RELEASE_CONFIGURATION "Release"
        DEBUG_CONFIGURATION "Debug"
		#INCLUDES_SUBPATH RevUtility/include/hlib
		USE_VCPKG_INTEGRATION
		SKIP_CLEAN
    )
    
	file(GLOB REV_PKG_HEADERS "${SOURCE_PATH}/RevUtility/include/hlib/*.h")
	file(COPY ${REV_PKG_HEADERS} DESTINATION "${CURRENT_PACKAGES_DIR}/include/hlib")
endif()

file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
