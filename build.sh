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
    if [ ! -f $KERNEL.tar.xz ]
    then
	echo "Downloading the Linux kernel source code" &&
	wget https://cdn.kernel.org/pub/linux/kernel/v6.x/$KERNEL.tar.xz
    fi
} &&
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
# cp -av build/plopkexec64 build/BOOTx64.EFI &&
if [ "$1" == "iso" ]
then
    mkdir -p iso/iso/EFI/BOOT/ &&
    cp -av build/plopkexec64 iso/iso/EFI/BOOT/BOOTx64.EFI &&
    cd iso 			 &&
    sh make-iso.sh 		 &&
    mv -v plopkexec.iso ../build/plopkexec64.iso	 &&
    echo && 
    echo "Successfully built plopkexec64 and plopkexec64.iso" &&
    echo "Find them in the 'build/' directory."
else
    echo "Successfully built plopkexec64" &&
    echo "Find it in the 'build/' directory."
fi


