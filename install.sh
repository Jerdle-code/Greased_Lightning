#! /bin/bash
echo "This is the Greased Lightning Installer. It requires a working Arch system."
echo ""
if [[ $(id -u) -ne 0 ]]
then echo "Run this as root"
exit 1
fi
echo "Replacing pacman.conf"
cat '[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf
echo "Enabling AUR"
pacman -Syyu yaourt
echo "Choose version"
echo " 1 = Openbox-based desktop "
echo " 2 = light app suite "
echo " 3 = both "
read choice
case $choice in
1) yaourt -Syu pcmanfm lxappearance cairo-compmgr wbar xfce4-panel mint-backgrounds-qiana conky openbox obconf lxappearance-obconf lxdm oxygen-gtk2 oxygen-gtk3 oxygen-icons gmrun obkey --insecure
systemctl enable lxdm
echo "Log into Openbox";;
2) yaourt -Syu lxappearance abiword audacious midori evince gimp  gnumeric grsync liferea lyx osmo pidgin vlc kdegames transmission-gtk sylpheed xfburn xfce4-taskmanager --insecure ;;
3) yaourt -Syu lxappearance abiword audacious midori evince gimp  gnumeric grsync liferea lyx osmo pidgin vlc kdegames transmission-gtk sylpheed xfburn xfce4-taskmanager pcmanfm gmrun obkey cairo-compmgr wbar xfce4-panel mint-backgrounds-qiana conky openbox obconf lxdm oxygen-gtk2 oxygen-gtk3 oxygen-icons --insecure
systemctl enable lxdm
echo "Log into Openbox" ;;
*) exit 2
esac
