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
 * **gnome-base/gnome-core-apps:** A slightly modified version of [the package](https://packages.gentoo.org/package/gnome-base/gnome-core-apps), with optional use-flag "web", for optional installation of Epiphany (and its dependencies).
 * **gnome-base/gnome-extra-apps:** A slightly modified version of [the package](https://packages.gentoo.org/package/gnome-base/gnome-extra-apps), with optional use-flags "im" & "totem", for optional installation of Empathy and Totem (and their dependencies). 
 * **net-misc/hotot:** A slightly modified version of [the official package](https://packages.gentoo.org/package/net-misc/hotot) from the Gentoo Portage tree, but changed in its 9999 version.
 * **www-client/midori:** A lightweight web browser. Uses Vala and WebKit. Taken from the Elementary overlay.
 * **x11-libs/granite:** As a dependency for Midori browser.
