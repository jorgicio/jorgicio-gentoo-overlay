Jorgicio Custom Overlay
=======================

Made by Jorge Pizarro Callejas, aka Jorgicio (http://www.jorgicio.net).
-----------------------------------------------------------------------

This is a Custom repository made by me.

Usage
-----

First, install Layman from the official Portage tree. Must use the use-flag USE="git" at the moment of installation.

emerge layman

Then, in the section "overlays" in the /etc/layman/layman.cfg, add the following URL:
https://raw.github.com/jorgicio/jorgicio-gentoo/master/jorgicio-repo.xml

And then, run the following command:

layman -f -a jorgicio-gentoo

And you're done.

If you want to refresh the overlay (and all another overlays), just type:

layman -S

That's all, folks!

List of packages (at the moment):
---------------------------------

 * **app-laptop/laptop-detect:** Application for detecting laptops. Used by [Prey](http://preyproject.com) ([app-laptop/prey](https://packages.gentoo.org/package/app-laptop/prey)), a best known tool for recovering stolen laptops.
 * **app-office/stickynotesnix:** Simple stickynotes. Made in Python.
 * **gnome-extra/gpaste**: The [Gpaste](http://www.imagination-land.org/posts/2013-10-22-gpaste-3.2.2-released.html) daemon and gnome-shell extension. This is the clipboard for GNOME Shell.
 * **x11-drivers/wizardpen:** Drivers for several Genius tablet models.
 * **app-admin/cpu-g:** The Linux alternative for CPU-Z. Useful for watching all information about your PC/Laptop's hardware.
 * **net-misc/telegram-cli:** A command-line [Telegram](http://telegram.org) client. Thanks to Vysheng and [his Github Repository](https://github.com/vysheng/tg), specially for the ebuild.
 * **app-office/kingsoft-office:** A Qt-Based Office. Thanks to [Tim Roes](http://github.com/timroes/) for the [ebuilds](http://github.com/timroes/local-portage).
 * **media-fonts/symbolfonts:** Some font used as a dependendency for Kingsoft Office. Also from Tim Roes.
 * **kde-misc/plasmoid-capslockinfo:** Capslock and Numlock information shown in a plasmoid.
