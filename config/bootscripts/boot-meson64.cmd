# DO NOT EDIT THIS FILE
#
# Please edit /boot/armbianEnv.txt to set supported parameters
#

setenv rootdev "/dev/mmcblk1p1"
setenv verbosity "1"
setenv console "both"
setenv rootfstype "ext4"


if test -e ${devtype} ${devnum} ${prefix}armbianEnv.txt; then
	load ${devtype} ${devnum} ${loadaddr} ${prefix}armbianEnv.txt
	env import -t ${loadaddr} ${filesize}
fi

if test "${logo}" = "disabled"; then setenv logo "logo.nologo"; fi

if test "${console}" = "display" || test "${console}" = "both"; then setenv consoleargs "console=tty1"; fi
if test "${console}" = "serial" || test "${console}" = "both"; then setenv consoleargs "${consoleargs} console=ttyAML0,115200n8"; fi

setenv bootargs "root=${rootdev} rootwait rootflags=data=writeback rw rootfstype=${rootfstype} ${consoleargs} no_console_suspend consoleblank=0 fsck.repair=yes loglevel=${verbosity} usb-storage.quirks=${usbstoragequirks} ${extraargs} ${extraboardargs}"

${bloader} ${initrd_start} ${prefix}uInitrd
${bloader} ${dtb_mem_addr} ${prefix}dtb/${fdtfile}
fdt addr ${dtb_mem_addr}
${bloader} ${loadaddr} ${prefix}uImage;
bootm ${loadaddr} ${initrd_start} ${dtb_mem_addr};

# Recompile with:
# mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr