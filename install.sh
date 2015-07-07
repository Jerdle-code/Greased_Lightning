#! /bin/bash
start () {
	useradd yaourt
	whiptail --msgbox "This is the Greased Lightning Installer. It requires a working Arch system." 10 40
	if [[ $(id -u) -ne 0 ]]
	then whiptail --msgbox "Run this as root" 10 40
	exit 1
	fi
	whiptail --infobox "Replacing pacman.conf" 10 40
	grep '[archlinuxfr]' /etc/pacman.conf > /dev/null || echo '[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf
	whiptail --infobox "Enabling AUR" 10 40
	pacman -Syyu yaourt
} 
install_desktop() {
	whiptail --infobox "Installing lightweight desktop..." 10 40
	su yaourt -c 'bash -c "yaourt -Syu spacefm lxappearance cairo-compmgr wbar xfce4-panel mint-backgrounds-qiana conky openbox obconf lxappearance-obconf gmrun obkey sddm --insecure >/dev/null 2>/dev/null"'
	systemctl enable sddm
	whiptail --msgbox "Log into Openbox" 10 40
}
install_apps() {
	whiptail --infobox "Installing lightweight apps..." 10 40
	su yaourt -c 'bash -c "yaourt -Syu lxappearance abiword deadbeef midori evince gimp gnumeric grsync liferea lyx osmo pidgin vlc transmission-gtk sylpheed xfburn xfce4-taskmanager --insecure >/dev/null 2>/dev/null"'
}
start
whiptail --checklist --separate-output "Choose programs:" 10 40 2 \
        1 "Desktop" on \
        2 "App suite" on 2>/tmp/programs
sort -r /tmp/programs -o /tmp/programs
grep 2 /tmp/programs >/dev/null && install_apps
grep 1 /tmp/programs >/dev/null && install_desktop
rm /tmp/programs
userdel yaourt
