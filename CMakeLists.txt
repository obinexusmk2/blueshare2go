cmake_minimum_required(VERSION 3.16)
project(BlueShare VERSION 1.0.0 LANGUAGES C)

# OBINexus Constitutional Compliance
set(CONSTITUTIONAL_COMPLIANCE ON CACHE BOOL "Enable constitutional compliance verification")

# Build configuration
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# OBINexus Computing integration (optional in local/dev environments)
find_package(PkgConfig REQUIRED)
pkg_check_modules(GOSI_LANG QUIET gosi-lang)
pkg_check_modules(NODE_ZERO QUIET node-zero)
pkg_check_modules(LIBPOLYCALL QUIET libpolycall)

# Platform detection
if(ANDROID)
    set(PLATFORM_ANDROID 1)
    add_definitions(-DPLATFORM_ANDROID=1)
elseif(IOS)
    set(PLATFORM_IOS 1)
    add_definitions(-DPLATFORM_IOS=1)
else()
    set(PLATFORM_LINUX 1)
    add_definitions(-DPLATFORM_LINUX=1)
endif()

# Constitutional compliance flags
if(CONSTITUTIONAL_COMPLIANCE)
    add_definitions(-DCONSTITUTIONAL_COMPLIANCE=1)
    add_definitions(-DOBINEXUS_GOVERNANCE=1)
endif()

# Include directories
include_directories(
    src/core
    src/platform
    ${GOSI_LANG_INCLUDE_DIRS}
    ${NODE_ZERO_INCLUDE_DIRS}
    ${LIBPOLYCALL_INCLUDE_DIRS}
)

# Core library sources
set(BLUESHARE_CORE_SOURCES
    src/core/blueshare_core.c
    src/core/network_management.c
    src/core/bandwidth_monitoring.c
    src/core/payment_processing.c
    src/core/constitutional_compliance.c
)

# Platform-specific sources
if(PLATFORM_LINUX)
    list(APPEND BLUESHARE_CORE_SOURCES src/platform/linux_platform.c)
else()
    message(STATUS "TODO: Android/iOS platform source files are not implemented yet.")
endif()

# Create core library
add_library(blueshare_core SHARED ${BLUESHARE_CORE_SOURCES})

# Link OBINexus Computing libraries when available
if(GOSI_LANG_FOUND)
    target_link_libraries(blueshare_core ${GOSI_LANG_LIBRARIES})
else()
    message(STATUS "gosi-lang not found; building without it.")
endif()

if(NODE_ZERO_FOUND)
    target_link_libraries(blueshare_core ${NODE_ZERO_LIBRARIES})
else()
    message(STATUS "node-zero not found; building without it.")
endif()

if(LIBPOLYCALL_FOUND)
    target_link_libraries(blueshare_core ${LIBPOLYCALL_LIBRARIES})
else()
    message(STATUS "libpolycall not found; building without it.")
endif()

# Create CLI tool
add_executable(blueshare_cli src/cli/blueshare_cli.c)
target_link_libraries(blueshare_cli blueshare_core)

# Create test executable
add_executable(blueshare_test src/tests/blueshare_test.c)
target_link_libraries(blueshare_test blueshare_core)

# Installation
install(TARGETS blueshare_core blueshare_cli
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
)

install(FILES src/core/blueshare_core.h
    DESTINATION include/blueshare
)

# Constitutional compliance verification
if(CONSTITUTIONAL_COMPLIANCE)
    add_custom_target(constitutional_verify
        COMMAND ${CMAKE_SOURCE_DIR}/tests/constitutional/test_constitutional_compliance.sh
        DEPENDS blueshare_core blueshare_test
        COMMENT "Verifying constitutional compliance"
    )
endif()
