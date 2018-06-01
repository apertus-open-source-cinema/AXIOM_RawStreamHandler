#!/usr/bin/env bash

echo "--------------------------------------------------------"
echo "AXIOM Beta Raw Video Container Format Recorder emulation"
echo "in memory benchmarking"
echo "--------------------------------------------------------"
echo "- requires root access"

sudo rm -r bin/
echo "=== Beginning building binaries for emulation"
mkdir build
cd build
cmake ../
make
cd ..
mkdir bin
cp build/src/generator/Generator bin/Generator
cp build/src/stream_emulator/Framestream_emulator bin/Framestream_emulator
cp build/src/stream_emulator/Metastream_emulator bin/Metastream_emulator
cp build/src/stream_handler/StreamHandler bin/StreamHandler
sudo rm -r build/
cd bin

echo "=== Beginning to write streams to disk"
./Generator
echo "=== Writing to disk done"
ls -l1h



echo "=== Setting up streams. Give some time to load fully"
sudo rm -r /tmp/rvcfFrameStream/
sudo rm -r /tmp/rvcfMetaStream/
mkdir /tmp/rvcfFrameStream/
mkdir /tmp/rvcfMetaStream/
deepin-terminal -e ./Framestream_emulator -d -s -f /tmp/rvcfFrameStream/ &
deepin-terminal -e ./Metastream_emulator -d -s -f /tmp/rvcfMetaStream/ &

echo "=== Waiting 20s for FUSE based streams to load."

sleep 16

echo "Beginning to run stream handler"

sleep 4

echo "=== Running Stream Handler"
./StreamHandler

echo "=== Emulation ends.\n"