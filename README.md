Jorgicio Custom Overlay
=======================

Made by Jorge Pizarro Callejas, aka Jorgicio (http://www.jorgicio.net).
-----------------------------------------------------------------------

This is a Custom repository made by me.

Usage
-----

First, install Layman from the official Portage tree. Must use the use-flag USE="git" at the moment of installation.

emerge layman

~Then, in the section "overlays" in the /etc/layman/layman.cfg, add the following URL:
https://raw.github.com/jorgicio/jorgicio-gentoo/master/jorgicio-repo.xml~

That's not necessary!!! Now this overlay is official and added to the list. Check it [here](http://gpo.zugaina.org/Overlays).

And then, run the following command:

~layman -f -a jorgicio-gentoo~
layman -f -a jorgicio

And you're done.

If you want to refresh the overlay (and all another overlays), just type:

layman -S

That's all, folks!

List of packages (at the moment):
---------------------------------

 * **[app-laptop/laptop-detect](/app-laptop/laptop-detect):** Application for detecting laptops. Used by [Prey](http://preyproject.com) ([app-laptop/prey](https://packages.gentoo.org/package/app-laptop/prey)), a best known tool for recovering stolen laptops.
 * **[app-office/stickynotesnix](/app-office/stickynotesnix):** Simple stickynotes. Made in Python.
 * **[gnome-extra/gpaste](/gnome-extra/gpaste)**: The [Gpaste](http://www.imagination-land.org/posts/2013-10-22-gpaste-3.2.2-released.html) daemon and gnome-shell extension. This is the clipboard for GNOME Shell.
 * **[x11-drivers/wizardpen](/x11-drivers/wizardpen):** Drivers for several Genius tablet models.
 * **[app-admin/cpu-g](/app-admin/cpu-g):** The Linux alternative for CPU-Z. Useful for watching all information about your PC/Laptop's hardware.
 * **[net-misc/telegram-cli](/net-misc/telegram-cli):** A command-line [Telegram](http://telegram.org) client. Thanks to Vysheng and [his Github Repository](https://github.com/vysheng/tg), specially for the ebuild.
 * **[app-office/wps-office](/app-office/wps-office):** A Qt-Based Office. Thanks to [Tim Roes](http://github.com/timroes/) for the [ebuilds](http://github.com/timroes/local-portage). **UPDATE**: Now it's called WPS Office.
 * **[media-fonts/symbolfonts](/media-fonts/symbolfonts):** Some font used as a dependendency for Kingsoft Office. Also from Tim Roes.
 * **[kde-misc/plasmoid-capslockinfo](/kde-misc/plasmoid-capslockinfo):** Capslock and Numlock information shown in a plasmoid.  
 * **[net-wireless/create_ap](/net-wireless/create_ap):** An app to create a wireless access point. Thanks to [its author](https://github.com/oblique).
 * **[net-misc/copy](/net-misc/copy):** (Not) Yet another cloud storage service.
 * **[media-plugins/srpos-vlc](/media-plugins/srpos-vlc):** A plugin for VLC for restarting from last played.
 * **[media-tv/popcorntime-bin](/media-tv/popcorntime-bin):** A good app for watching online movies from torrents. An alternative to Neflix.
 * **[dev-util/eclipse-sdk-bin](/dev-util/eclipse-sdk-bin):** The latest version of this IDE: 4.4 Luna.
 * **[sys-apps/inxi](/sys-apps/inxi):** A very detailed hardware view.
 * **[net-dns/dnscrypt-proxy](/net-dns/dnscrypt-proxy):** A DNS proxy for surfing the web securely.
 * **[net-misc/megasync](net-misc/megasync):** The Official Qt-based app for syncing your [MEGA](http://mega.co.nz) account. It's very well integrated with Dolphin manager. There's also a Nautilus plugin, but I don't support it because I don't use GNOME, so if you want it, create the ebuild yourself (or ask another but me) :P
