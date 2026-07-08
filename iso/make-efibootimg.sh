#!/bin/sh

EFIBOOT_SIZE=$(($(stat -c%s iso/EFI/BOOT/BOOTx64.EFI) + 100000)) # Size of kernel + 100Kb

truncate -s $EFIBOOT_SIZE efiboot.img&&
mkfs.fat -F 12 efiboot.img &&
mmd -i efiboot.img ::/EFI   &&
mmd -i efiboot.img ::/EFI/BOOT &&
mcopy -i efiboot.img ./iso/EFI/BOOT/BOOTx64.EFI ::/EFI/BOOT/BOOTx64.EFI &&
echo "efiboot.img created." &&
mv -v efiboot.img iso/EFI/efiboot.img &&
exit 0
