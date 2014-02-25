# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hotot/hotot-9999.ebuild,v 1.8 2013/06/12 20:16:30 xmw Exp $

EAPI=5

PYTHON_DEPEND="gtk? 2 3"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit cmake-utils git-2 python-single-r1

DESCRIPTION="lightweight & open source microblogging client"
HOMEPAGE="http://hotot.org"
EGIT_REPO_URI="git://github.com/lyricat/Hotot.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="chrome gtk gtk2 gtk3 kde qt4"

REQUIRED_USE="|| ( chrome gtk2 gtk3 qt4 )"

RDEPEND="${PYTHON_DEPS}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	gtk2? ( dev-python/pywebkitgtk )
	gtk3? ( dev-python/pygobject )
	qt4? ( dev-qt/qtwebkit:4
		kde? ( kde-base/kdelibs ) )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	qt4? ( dev-qt/qtsql:4 )"

pkg_setup() {
	if ! use gtk ; then
		if ! use qt4 ; then
			ewarn "neither gtk not qt4 binaries will be build"
		fi
	fi
	python-single-r1_pkg_setup
}

src_configure() {
	mycmakeargs=(
		${mycmakeargs}
		$(cmake-utils_use_with chrome CHROME)
		$(cmake-utils_use_with gtk GTK)
		$(cmake-utils_use_with gtk2 GTK2)
		$(cmake-utils_use_with gtk3 GTK3)
		$(cmake-utils_use_with gtk3 GIR)
		$(cmake-utils_use_with kde KDE)
		$(cmake-utils_use_with qt4 QT)
		-DPYTHON_EXECUTABLE=${PYTHON} )

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	find "${D}" -name "*.pyc" -delete
}

pkg_postinst() {
	if use chrome; then
		elog "TO install hotot for chrome, open chromium/google-chrome,"
		elog "vist chrome://chrome/extensions/ and load /usr/share/hotot"
		elog "as unpacked extension."
	fi
}
