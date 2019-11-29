SET(CMAKE_SYSTEM_NAME Linux)
SET(ARCH armhf)

SET(CMAKE_C_COMPILER   /usr/bin/arm-linux-gnueabihf-gcc)
SET(CMAKE_CXX_COMPILER /usr/bin/arm-linux-gnueabihf-g++)
SET(ENV{PKG_CONFIG_PATH} /usr/lib/arm-linux-gnueabihf/pkgconfig)

SET(CMAKE_FIND_ROOT_PATH /lib/arm-linux-gnueabihf /usr/lib/arm-linux-gnueabihf /usr/include/arm-linux-gnueabihf)
SET(CMAKE_LIBRARY_PATH /usr/include/arm-linux-gnueabihf)

SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
