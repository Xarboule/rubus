#/bin/bash
set -e
echo 
echo 
echo "Deployment of Raspberry Pi 4 with this hostname :"
cat /etc/hostname
echo 
echo "Copy iso to SD card..."
sudo dd if=/iso/image.iso of=/dev/mmcblk0 bs=10M
echo "done."
echo 
echo "Writing configuration on SD card :"
echo "-> Mount SD Card on /mnt..."
sudo mount /dev/mmcblk0p2 /mnt
sudo mount /dev/mmcblk0p1 /mnt/boot
echo "-> Add ssh on boot..."
sudo touch /mnt/boot/ssh
echo "-> Copy hostname from the temporary OS..."
sudo cp /etc/hostname /mnt/etc/hostname
echo "-> Update etc/hosts file..."
sudo sed -i /raspberrypi/d /mnt/etc/hosts
HOST=$(cat /etc/hostname)
sudo echo -e "127.0.1.1\t$HOST" >> /mnt/etc/hosts
echo "-> Enable hdmi-force in config.txt"
echo "hdmi_force_hotplug=1" | sudo tee -a /mnt/boot/config.txt
echo "-> Umount SD card..."
sudo umount -R /mnt
echo "Done."
echo 
echo "PXE Suicide..."
sudo mkdir -p /boot/disabled
sudo mv /boot/* /boot/disabled/ || echo "PXE disabled."
echo "Done."
echo 
echo "Reboot..."
echo 
echo 
sudo reboot
