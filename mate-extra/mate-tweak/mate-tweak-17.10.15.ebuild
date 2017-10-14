# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1 git-r3 gnome2-utils

DESCRIPTION="Tweak tool for MATE, a fork of MintDesktop"
HOMEPAGE="https://launchpad.net/ubuntu/+source/mate-tweak"
EGIT_REPO_URI="https://bitbucket.org/ubuntu-mate/mate-tweak"
IUSE="nls ubuntu"

if [[ ${PV} == *9999* ]];then
	KEYWORDS=""
	SRC_URI=""
else
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~x86 ~arm"
	SRC_URI="
		ubuntu? ( https://launchpad.net/ubuntu/+archive/primary/+files/ubuntu-mate-settings_${PV}.tar.xz )
	"
fi

LICENSE="GPL-2+"
SLOT="0"

DEPEND="
	${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]
	sys-devel/gettext
    dev-python/python-distutils-extra"
RDEPEND="dev-libs/glib:2
	dev-python/psutil
	dev-python/pygobject:3
	dev-python/setproctitle
	gnome-base/dconf
	mate-base/caja
	>=mate-base/mate-desktop-1.14
	mate-base/mate-panel
	mate-extra/mate-media
	sys-process/psmisc
	x11-misc/wmctrl
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	>=x11-libs/libnotify-0.7"

src_unpack(){
	git-r3_src_unpack
	unpack "${A}"
}

src_install(){
	distutils-r1_src_install
	if [[ ${PV} != *9999* ]] && use ubuntu; then
		insinto ${EPREFIX}/usr/share
		doins -r "${WORKDIR}/ubuntu-mate-settings/usr/share/mate-panel"
	fi
}

pkg_preinst(){
	gnome2_schemas_savelist
}

pkg_postinst(){
	gnome2_gconf_install
	gnome2_schemas_update
	echo
	elog "If you're using x11-misc/compton, you can create a local configuration file"
	elog "depending on the window manager you're using (metacity or marco)."
	elog "The configuration must be in ~/.config/wmname-compton.conf, begin 'wmname'"
	elog "the window manager."
	echo
}

pkg_postrm(){
	gnome2_gconf_uninstall
	gnome2_schemas_update
}
