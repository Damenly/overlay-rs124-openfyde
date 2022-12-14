echo "Detected i2c4@62 charger circuit."
echo "It seems to be a rock pi."

setenv fdtfile rockchip/rk3399-radxa-keyz.dtb

# Detect bootdevice
if test "${devtype}${devnum}" = "mmc0"; then
  setenv bootdevice mmcblk1 # SDHCI
elif test "${devtype}${devnum}" = "mmc1"; then
  setenv bootdevice mmcblk0 # SD
else
  setenv bootdevice sda # USB?
fi

echo "FDT: ${fdtfile}"
echo "Bootdevice: ${bootdevice}"

if test -e ${devtype} ${devnum}:${distro_bootpart} ${prefix}/first-b.txt; then
  echo "Found ${prefix}/first-b.txt, trying ROOT-B first"
  setenv prefix /boot/
  setenv distro_bootpart 5
  setenv bootdevice_part 5
  run boot_extlinux
fi

# Scan ROOT-A
setenv prefix /boot/
setenv distro_bootpart 3
setenv bootdevice_part 3
run boot_extlinux

# Scan ROOT-B
setenv prefix /boot/
setenv distro_bootpart 5
setenv bootdevice_part 5
run boot_extlinux
