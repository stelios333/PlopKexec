#!/bin/sh

BASE=$(pwd)
KERNEL=$(head kernel.txt -n 1)

cd src && make clean

cd $BASE
rm -rf kernel/$KERNEL

rm -rf kexec/kexec-tools-2.0.25
rm -rf kexec/kexec

rm -rf busybox/busybox-1.35.0

rm -rf build/*

echo "Done"
