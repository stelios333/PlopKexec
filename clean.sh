#!/bin/sh

BASE=$(pwd)
KERNEL=$(head kernel.txt -n 1)

cd src && make clean

cd $BASE
rm -rf kernel/$KERNEL

rm -rf kexec/kexec-tools-*/
rm -rf kexec/kexec

rm -rf busybox/busybox-*/

rm -rf build/*
rm -rf iso/iso/EFI

echo "Done"
