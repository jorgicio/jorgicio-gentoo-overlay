# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit python-utils-r1 xdg-utils

DESCRIPTION="LightDM settings app to use it with the slick greeter"
HOMEPAGE="https://github.com/linuxmint/lightdm-settings"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	sys-devel/gettext
	dev-util/desktop-file-utils
"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	dev-python/setproctitle
	dev-python/pygobject
	sys-auth/polkit
	dev-python/xapp
	x11-themes/hicolor-icon-theme
	sys-apps/lsb-release
	x11-misc/lightdm-slick-greeter
"

DOCS=(
	COPYING
	README.md
)

src_prepare() {
	sed -i -e "s#/usr/lib#/usr/$(get_libdir)#" usr/bin/${PN} || die
	default
}

src_install() {
	mkdir -p "${ED%/}"/usr/$(get_libdir)
	cp -r usr/lib/* "${ED%/}"/usr/$(get_libdir)
	cp -r usr/share "${ED%/}"/usr/
	dobin usr/bin/${PN}
	einstalldocs
}

pkg_preinst() {
	xdg_environment_reset
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
