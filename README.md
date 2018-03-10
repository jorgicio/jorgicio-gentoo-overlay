<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Jorgicio Custom Overlay](#jorgicio-custom-overlay)
  - [Usage](#usage)
    - [Using Layman](#using-layman)
    - [Using eselect-repository](#using-eselect-repository)
  - [Note for all people who send pull requests (MUST READ)](#note-for-all-people-who-send-pull-requests-must-read)
  - [Note for all MATE lovers (READ IT!!!)](#note-for-all-mate-lovers-read-it)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Jorgicio Custom Overlay

Made with love by Jorge Pizarro Callejas, a.k.a. [Jorgicio](http://www.jorgicio.net).

## Usage

### Using Layman

First, install Layman from the official Portage tree. Must use the use-flag USE="git" at the moment of installation.

    emerge layman

~~Then, in the section "overlays" in the /etc/layman/layman.cfg, add the following URL:
https://raw.github.com/jorgicio/jorgicio-gentoo/master/jorgicio-repo.xml~~

**That's not needed anymore!!! Now this overlay is added to the official list.** Check it [here](http://gpo.zugaina.org/Overlays).

And then, run the following command:

    layman -f -a jorgicio

And you're done.

If you want to refresh the overlay (and all another overlays), just type:

    layman -S

That's all, folks!

### Using eselect-repository

__Note:__ If needed, you must resync first the repos list. You can do it with `emaint sync -A`, which comes with Portage.

[Eselect-repository](https://wiki.gentoo.org/wiki/Eselect/Repository) is a new Eselect module intended to manage repositories. It superseed the need for Layman to list, configure, and handle synchronizations of alternate repositories (except some ones like mercurial, bazaar, and g-sorcery). It can handles the repos list in [/etc/portage/repos.conf](https://wiki.gentoo.org/wiki//etc/portage/repos.conf)

First install eselect-repository from Portage:

    emerge eselect-repository

Then, enable the repo:

    eselect repository enable jorgicio

Now you're ready to use this repo.
More information about this method, you can find it in the link above.

## Note for all people who send pull requests (MUST READ)

All pull requests are welcomed to this repo, but if you do it, please use the [Gentoo Git Commit Message Format](https://devmanual.gentoo.org/ebuild-maintenance/index.html#git-commit-message-format). Thank you!

## Note for all MATE lovers (READ IT!!!)

~~For all [MATE](http://mate-desktop.org) lovers, there's another overlay to use latter versions of that desktop environment because Gentoo portage version is pretty old. You can check it [here](../../../mate-jorgicio), instructions included.
Thanks.~~
That information is not needed anymore. MATE packages are already available on the official Portage tree, so I won't maintain that repo anymore.
Thanks for the support!
