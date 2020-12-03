#!/bin/bash

make clean || echo clean
rm -f config.status
./autogen.sh || echo done

extracflags="$extracflags -Ofast -flto -fuse-linker-plugin -ftree-loop-if-convert-stores"

if [ ! "0" = `cat /proc/cpuinfo | grep -c avx` ]; then
    # march native doesn't always works, ex. some Pentium Gxxx (no avx)
    extracflags="$extracflags -march=native"
fi

./configure --with-crypto --with-curl CFLAGS="$extracflags -g -rdynamic" --host="arm-linux-gnu" 

make -j 4

# strip -s cpuminer



# ./configure --with-crypto --with-curl CFLAGS="-O3 $extracflags -pg -g -rdynamic -funwind-tables" --host="arm-linux-gnu"

