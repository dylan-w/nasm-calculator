set -e # Exit if any command fails
nasm -f macho64 calculator.asm -o calculator.o
ld -macos_version_min 10.7.0 -L$(xcode-select -p)/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib -lSystem -o calculator calculator.o