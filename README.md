<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Jorgicio Custom Overlay](#jorgicio-custom-overlay)
  - [Made by Jorge Pizarro Callejas, aka Jorgicio (http://www.jorgicio.net).](#made-by-jorge-pizarro-callejas-aka-jorgicio-httpwwwjorgicionet)
  - [Usage](#usage)
  - [List of packages (at the moment):](#list-of-packages-at-the-moment)
  - [Note for all MATE lovers (READ IT!!!)](#note-for-all-mate-lovers-read-it)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Jorgicio Custom Overlay
=======================

Made by Jorge Pizarro Callejas, aka Jorgicio (http://www.jorgicio.net).
-----------------------------------------------------------------------

This is a Custom repository made by me.

Usage
-----

First, install Layman from the official Portage tree. Must use the use-flag USE="git" at the moment of installation.

    emerge layman

~~Then, in the section "overlays" in the /etc/layman/layman.cfg, add the following URL:
https://raw.github.com/jorgicio/jorgicio-gentoo/master/jorgicio-repo.xml~~

**That's not necessary!!! Now this overlay is official and added to the list.** Check it [here](http://gpo.zugaina.org/Overlays).

And then, run the following command:

    layman -f -a jorgicio

And you're done.

If you want to refresh the overlay (and all another overlays), just type:

    layman -S

That's all, folks!

Note for all MATE lovers (READ IT!!!)
-------------------------------------

~~For all [MATE](http://mate-desktop.org) lovers, there's another overlay to use latter versions of that desktop environment because Gentoo portage version is pretty old. You can check it [here](../../../mate-jorgicio), instructions included.
Thanks.~~
That information is not needed anymore. MATE packages are already available on the official Portage tree, so I won't maintain that repo anymore.
Thanks for the support!
