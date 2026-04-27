cmake_minimum_required(VERSION 3.13)

# Pull in the SDK from $PICO_SDK_PATH.
set(PICO_BOARD pico2 CACHE STRING "Board type")

include(pico_sdk_import.cmake)

project(hardware_check C CXX ASM)

pico_sdk_init()

add_executable(sd_probe sd_probe.c)

target_link_libraries(sd_probe
    pico_stdlib
    hardware_spi
    hardware_gpio
    hardware_clocks
)

# Use UART (GP0/GP1) for stdio so the Debug Probe CDC-ACM picks it up.
pico_enable_stdio_uart(sd_probe 1)
pico_enable_stdio_usb(sd_probe 0)

pico_add_extra_outputs(sd_probe)
