# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MIN_VERSION="3.10"

inherit cmake-utils flag-o-matic toolchain-funcs xdg-utils

MY_PN="MellowPlayer"

DESCRIPTION="Cloud music integration for your desktop"
HOMEPAGE="https://colinduquesnoy.gitlab.io/MellowPlayer"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/colinduquesnoy/${MY_PN}"
else
	KEYWORDS="-* ~amd64"
	MY_P="${MY_PN}-${PV}"
	SRC_URI="https://gitlab.com/colinduquesnoy/${MY_PN}/-/archive/${PV}/${MY_P}.tar.bz2"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="
	>=dev-qt/qtquickcontrols2-5.9:5
	>=dev-qt/qtquickcontrols-5.9:5[widgets]
	>=dev-qt/qtwebengine-5.9:5[-bindist,widgets]
	>=dev-qt/qttranslations-5.9:5
	>=dev-qt/qtgraphicaleffects-5.9:5
	dev-libs/libevent
	media-libs/mesa
"

RDEPEND="
	${DEPEND}
	www-plugins/adobe-flash:*
	www-plugins/chrome-binary-plugins:*
	x11-libs/libnotify
"

PATCHES=( "${FILESDIR}/widevine-path.patch" )

src_configure() {
	if test-flags-CXX -std=c++17;then
		if tc-is-gcc; then
			[ $(gcc-major-version) -lt 6 ] && die "You need at least GCC 6.0 in order to build ${MY_PN}"
		fi
		if tc-is-clang; then
			[ $(clang-major-version) -lt 3.5 ] && die "You need at least Clang 3.5 in order to build ${MY_PN}"
		fi
	else
		die "You need a c++17 compatible compiler in order to build ${MY_PN}"
	fi
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	# Create a symlink in order to use the Widevine plugin
	dodir /usr/$(get_libdir)/qt5/plugins/ppapi
	dosym "${EROOT}"/usr/$(get_libdir)/chromium-browser/WidevineCdm/_platform_specific/linux_x64/libwidevinecdm.so \
		/usr/$(get_libdir)/qt5/plugins/ppapi/libwidevinecdm.so
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
