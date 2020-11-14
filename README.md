<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Jorgicio Custom Overlay](#jorgicio-custom-overlay)
  - [Branch renaming (Information for collaborators, MUST READ)](#branch-renaming-information-for-collaborators-must-read)
  - [Usage](#usage)
    - [Using Layman](#using-layman)
    - [Using eselect-repository](#using-eselect-repository)
  - [Note for all people who send pull requests (MUST READ)](#note-for-all-people-who-send-pull-requests-must-read)
  - [Note for all people who doesn't own a Github accound (MUST READ)](#note-for-all-people-who-doesnt-own-a-github-accound-must-read)
  - [Problem with media-tv/xawtv ? See here](#problem-with-media-tvxawtv--see-here)
  - [Want to contribute? Please, contact me](#want-to-contribute-please-contact-me)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Jorgicio Custom Overlay

Made with love by Jorge Pizarro Callejas, a.k.a. [Jorgicio](http://www.jorgicio.net).

## Branch renaming (Information for collaborators, MUST READ)

The default branch is now `main` instead of `master`, so if you want to send your PRs, you should do the following if not done before:

    git checkout master
    git branch -m master main
    git fetch
    git branch --unset-upstream
    git branch -u origin/main

And that's it.

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

[Eselect-repository](https://wiki.gentoo.org/wiki/Eselect/Repository) is a new Eselect module intended to manage repositories. It superseed the need for Layman to list, configure, and handle synchronizations of alternate repositories (except some ones like mercurial, bazaar, and g-sorcery). It can handle the repos list in [/etc/portage/repos.conf](https://wiki.gentoo.org/wiki//etc/portage/repos.conf)

First, install the `eselect-repository` package from Portage:

    emerge eselect-repository

Then, enable the repo:

    eselect repository enable jorgicio

After that, use `emaint` (already included in Portage) to sync the repo and its files:
    
    emaint sync -r jorgicio

Now you're ready to use this repo.
More information about this method, you can find it in the link above.

## Note for all people who send pull requests (MUST READ)

All pull requests are welcomed to this repo, but if you do it, please use the [Gentoo Git Commit Message Format](https://devmanual.gentoo.org/ebuild-maintenance/index.html#git-commit-message-format). Thank you!

## Note for all people who doesn't own a Github accound (MUST READ)

If you don't have a Github account, you can email me but ONLY with the tag \[Gentoo Overlay\] (as you can see it, with brackets and respecting capital letters). Any mail sent without that, can't be read, because is too annoying searching emails when one has a lot of them. With that tag, I can filter it easily, so I can read those emails.

Thanks in advance.

## Problem with media-tv/xawtv ? See here

If you have any issue related with mmx at compilation time, you should add this to your `/etc/portage/package.use`:
```
media-tv/xawtv -cpu_flags_x86_mmx
```

For some strange reason, despite being added in the package.use.mask file, it's still active, so you should disable it manually in the meantime.

## Want to contribute? Please, contact me

As you may notice, there are lots of packages here, so any help (PRs, adopting some of this packages, etc.) are welcome.
