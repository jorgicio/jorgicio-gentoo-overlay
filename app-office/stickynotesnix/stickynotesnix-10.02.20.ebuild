# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
PYTHON_DEPEND="2:2.5"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_USE_WITH_OPT="X"
PYTHON_ECLASS_API="1"

inherit python

DESCRIPTION="Place colourful sticky reminders all over your Linux desktop"
HOMEPAGE="http://sourceforge.net/projects/stickynotesnix/"
SRC_URI="https://www.dropbox.com/s/iiqwq7myeziks0w/stickynotes-10.02.20.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/libwnck-python
		dev-python/pygtk"
DEPEND="${RDEPEND}"

S="${WORKDIR}/stickynotes"

src_install(){
	insinto /usr/share/stickynotes
	doins stickynotes.py || die
	doins stickynotes.ui || die
	insinto /usr/share/stickynotes/icons
	doins icons/applet.png || die
	doins icons/overlay.png || die
	doins icons/trans.png || die
	exeinto /usr/bin
	newexe "${FILESDIR}"/stickynotes stickynotes || die
	insinto /usr/share/applications
	doins stickynotes-tray.desktop || die
}

pkg_postinst(){
	echo
	elog "Hi! Thanks for installing Sticky Notes Nix."
	elog "Happy noting!"
	echo
}

