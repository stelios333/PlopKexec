#!/bin/sh

KERNEL=$(head kernel.txt -n 1)
MAKE_JOBS=$(($(nproc) + 1))

if [ $(id -u) -ne 0 ]
then

    echo Building PlopKexec needs root permissions or fakeroot!
    exit 0
    
fi

BASE=$(pwd)

mkdir -p build		&&
cd src 			&&
make -j $MAKE_JOBS &&
cd $BASE/kernel 	&&
{
    if [ ! -d $KERNEL ]
    then
	echo "Extracting the Linux kernel source code" &&
	tar xfJ $KERNEL.tar.xz
    fi
}			&&
cd $KERNEL		&&

cp -avr ../.config .config &&

tar xfvz ../initramfs.tar.gz &&
cp -av $BASE/src/init initramfs   &&
cd $BASE/busybox/ &&
sh build_busybox &&
cp -av $BASE/busybox/busybox/_install/* $BASE/kernel/$KERNEL/initramfs &&
cd $BASE/kexec 		 &&
sh build_kexec &&
cp -av kexec $BASE/kernel/$KERNEL/initramfs &&
cd $BASE/kernel/$KERNEL &&
make -j $MAKE_JOBS bzImage 			  &&
cp -av arch/x86/boot/bzImage $BASE/build/plopkexec64 &&
cd $BASE 		 &&
cp -av build/plopkexec64 build/BOOTX64.EFI &&
cp -av build/plopkexec64 iso/iso/plopkexec &&
cp -av build/plopkexec64 iso/iso/EFI/BOOT/BOOTX64.EFI &&
cd iso 			 &&
sh make-iso.sh 		 &&
cp -av plopkexec.iso ../build/plopkexec64.iso	 &&
echo && 
echo "Built successfully plopkexec64 and plopkexec64.iso" &&
echo "Find them in the 'build/' directory."



