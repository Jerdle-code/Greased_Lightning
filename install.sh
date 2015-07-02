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
foo=0
yaourt -Syu pcmanfm lxappearance cairo-compmgr wbar xfce4-panel mint-backgrounds-qiana conky openbox obconf lxappearance-obconf gmrun obkey sddm --insecure
systemctl enable sddm
echo "Log into Openbox"
foo=1
}
install2() {
foo=0
yaourt -Syu lxappearance abiword deadbeef midori evince gimp gnumeric grsync liferea lyx osmo pidgin vlc transmission-gtk sylpheed xfburn xfce4-taskmanager --insecure
foo=1
}
foo=0
start
while [ foo -eq 0 ]
do echo "Choose version"
echo " 1 = Openbox-based desktop "
echo " 2 = light app suite "
echo " 3 = both "
read choice
case $choice in
1) install1;;
2) install2;;
3) install2 && install1;;
q) exit;;
*)	echo "Choose 1, 2, 3. or q to exit";;
esac
done
