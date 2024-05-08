#!/bin/bash
sudo apt install linuxptp

sudo timedatectl set-ntp 0 # disable ntp

sudo cp -v systemdUnits/ptp-slave.service /etc/systemd/system/ptp-slave.service
sudo cp -v systemdUnits/phc2sys-slave.service /etc/systemd/system/phc2sys-slave.service
sudo cp -v systemdUnits/ntp2ptp.service /etc/systemd/system/ntp2ptp.service
sudo cp -v systemdUnits/ntp2ptp.sh /usr/local/bin/ntp2ptp.sh

# Make the scripts executable
sudo chmod -v +x /usr/local/bin/ntp_to_ptp_switch.sh

# Starts ntp server at boot and then switches to ptp
sudo systemctl enable ntp2ptp.service
sudo systemctl enable phc2sys-slave.service
# Servce is not started by default rather started by ntp2ptp.sh
sudo systemctl disable ptp-slave.service
