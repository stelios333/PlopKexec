mkdir -p iso/EFI/BOOT/
dd if=/dev/zero of=efiboot.img bs=1M count=32 &&
mkfs.fat -F 12 efiboot.img &&
mkdir tmp_mnt &&
mount efiboot.img tmp_mnt -o loop &&
mkdir -p tmp_mnt/efi/boot &&
cp -v iso/EFI/BOOT/BOOTx64.EFI tmp_mnt/efi/boot/BOOTx64.EFI &&
cp -v iso/EFI/BOOT/BOOTIA32.EFI tmp_mnt/efi/boot/BOOTIA32.EFI &&
umount tmp_mnt &&
rmdir tmp_mnt &&
echo "efiboot.img created." &&
cp -v efiboot.img iso/EFI/efiboot.img &&
echo "efiboot.img copied to ISO directory structure." &&
rm efiboot.img &&
echo "Done."
