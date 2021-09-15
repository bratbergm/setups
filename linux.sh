#!/bin/bash


sudo apt update && sudo apt upgrade -y

sudo apt install zsh -y

sudo apt install powerline fonts-powerline -y

sudo apt install curl -y

sudo apt install git -y

# oh my zsh
# Go to https://ohmyz.sh/#install for latest version
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Firewall, Remote Desktop
sudo apt install ufw
#
sudo ufw allow ssh
# depends on network
sudo ufw allow from 192.168.1.0/24 to any port 3389
#
sudo ufw enable
#
sudo apt install xrdp
sudo systemctl status xrdp # just a check if active, ctrl+z/c to exit.
sudo adduser xrdp ssl-cert
sudo systemctl restart xrdp
# logout from console session befor rdp'ing in.
# might have to reboot host machine

# Remove Authentication popup
sudo -s

echo "
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes" > /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla

echo "
[Allow Package Management all Users]
Identity=unix-user:*
Action=org.freedesktop.packagekit.system-sources-refresh
ResultAny=yes
ResultInactive=yes
ResultActive=yes" > /etc/polkit-1/localauthority/50-local.d/46-allow-update-repo.pkla



