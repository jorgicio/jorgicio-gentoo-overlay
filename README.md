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

 * **app-laptop/laptop-detect**: Application for detecting laptops. Used by app-laptop/prey, a best known tool for recovering stolen laptops.
 * **app-office/stickynotesnix**: Simple stickynotes. Made in Python.
 * **gnome-extra/gpaste**: The Gpaste daemon and gnome-shell extension. This is the clipboard for GNOME Shell.
