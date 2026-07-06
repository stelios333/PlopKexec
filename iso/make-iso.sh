
sh make-efibootimg.sh
mkisofs -J -r -V PlopKexec \
	-UDF \
	-hide-joliet-trans-tbl -hide-rr-moved  \
	-allow-leading-dots \
        -o plopkexec.iso -no-emul-boot -boot-load-size 4 \
	-c boot.catalog -b isolinux.bin -boot-info-table -l \
        -eltorito-alt-boot \
        -eltorito-platform 0xEF -eltorito-boot EFI/efiboot.img -no-emul-boot \
        iso		&&
echo Creating hybrid ISO &&
isohybrid -u plopkexec.iso

