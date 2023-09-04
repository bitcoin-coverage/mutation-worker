#!/bin/bash
set -e
ccache --show-stats

cd /tmp/bitcoin && git pull origin master
git fetch origin pull/$PR_NUM/head && git checkout FETCH_HEAD

./test/get_previous_releases.py -b
./autogen.sh && ./configure --disable-fuzz --enable-fuzz-binary=no --with-gui=no --disable-zmq --disable-bench BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8" BDB_CFLAGS="-I${BDB_PREFIX}/include"

echo $PAYLOAD | jq -r .patch | base64 -d > patch
patch -p0 < patch

make -j$(nproc)
make check -j$(nproc)
python3 test/functional/test_runner.py -j$(nproc) -F
