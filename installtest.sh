#! /bin/bash
start () {
echo "This is the Iced Balloon Installer. It requires a working Arch system."
echo ""
if [[ $(id -u) -ne 0 ]]
then echo "Run this as root"
exit 1
fi
echo "Replacing pacman.conf"
grep '[archlinuxfr]' pacman.conf > /dev/null || echo '[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf
echo "Enabling AUR"
pacman -Syyu yaourt
} 
install1() {
yaourt -Syu pcmanfm lxappearance cairo-compmgr wbar xfce4-panel mint-backgrounds-qiana conky openbox obconf lxappearance-obconf gmrun obkey sddm --insecure
systemctl enable sddm
echo "Log into Openbox"
}
install2() {
yaourt -Syu lxappearance abiword deadbeef midori evince gimp gnumeric grsync liferea lyx osmo pidgin vlc transmission-gtk sylpheed xfburn xfce4-taskmanager --insecure
}
start
choices=$(whiptail --checklist "Choose programs:" 10 40 2 \
        1 "Desktop" on \
        2 "App suite" on \
 3>&1 1>&2 2>&3)
echo $choices | grep 1 > /dev/null && install1
echo $choices | grep 2 > /dev/null && install1
