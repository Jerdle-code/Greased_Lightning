#! /bin/bash
start () {
	whiptail --msgbox "This is the Iced Balloon Installer. It requires a working Arch system." 10 40
	if [[ $(id -u) -ne 0 ]]
	then whiptail --msgbox "Run this as root" 10 40
	exit 1
	fi
	whiptail --infobox "Replacing pacman.conf" 10 40
	grep '[archlinuxfr]' pacman.conf > /dev/null || echo '[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf
	whiptail --infobox "Enabling AUR" 10 40
	pacman -Syyu yaourt
} 
install_desktop() {
	whiptail --infobox "Installing lightweight desktop..." 10 40
	yaourt -Syu spacefm lxappearance cairo-compmgr wbar xfce4-panel mint-backgrounds-qiana conky openbox obconf lxappearance-obconf gmrun obkey sddm --insecure >/dev/null 2>/dev/null
	systemctl enable sddm
	whiptail --msgbox "Log into Openbox" 10 40
}
install_apps() {
	whiptail --infobox "Installing lightweight apps..." 10 40
	yaourt -Syu lxappearance abiword deadbeef midori evince gimp gnumeric grsync liferea lyx osmo pidgin vlc transmission-gtk sylpheed xfburn xfce4-taskmanager --insecure >/dev/null 2>/dev/null
}
start
choices=$(whiptail --checklist "Choose programs:" 10 40 2 \
        1 "Desktop" on \
        2 "App suite" on
3>&1 1>&2 2>&3)
echo $choices | grep 1 > /dev/null && install_desktop
echo $choices | grep 2 > /dev/null && install_apps
