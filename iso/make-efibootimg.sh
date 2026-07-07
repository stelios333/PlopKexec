dd if=/dev/zero of=efiboot.img bs=1M count=32 &&
mkfs.fat -F 12 efiboot.img &&
mmd -i efiboot.img ::/EFI   &&
mmd -i efiboot.img ::/EFI/BOOT &&
mcopy -i efiboot.img ./iso/EFI/BOOT/BOOTx64.EFI ::/EFI/BOOT/BOOTx64.EFI &&
echo "efiboot.img created." &&
mv -v efiboot.img iso/EFI/efiboot.img &&
echo "efiboot.img moved to ISO directory structure." &&
echo "Done."
