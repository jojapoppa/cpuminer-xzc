#!/bin/bash

# Linux build

make clean || echo clean

rm -f config.status
./autogen.sh || echo done

# ./configure --with-crypto --with-curl CFLAGS="-O2 $extracflags -DUSE_ASM -pg" * -pg is a link command too in Makefile

./configure --with-crypto --with-curl --host="arm-linux-gnu" CFLAGS="-O3 -march=armv8-a+simd+fp+crypto -mcpu=cortex-a53 -mtune=cortex-a53 -funsafe-math-optimizations -mfix-cortex-a53-835769 -fvariable-expansion-in-unroller -fwhole-program -Ofast -flto -fuse-linker-plugin -ftree-loop-if-convert-stores -funwind-tables -Wall -D_REENTRANT -funroll-loops -fvariable-expansion-in-unroller -fmerge-all-constants -fbranch-target-load-optimize2 -fsched2-use-superblocks -falign-loops=16 -falign-functions=16 -falign-jumps=16 -falign-labels=16"

CC="arm-linux-gnueabi-gcc-6"
make -j 4

strip -s cpuminer
