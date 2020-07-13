# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

MY_PN="${PN//-bin}"

DESCRIPTION="Cross-platform text expander written in Rust (binary version)"
HOMEPAGE="https://espanso.org"
SRC_URI="https://github.com/federico-terzi/${MY_PN}/releases/download/v${PV}/${MY_PN}-linux.tar.gz -> ${P}.tar.gz
	systemd? ( https://raw.githubusercontent.com/federico-terzi/${MY_PN}/v${PV}/src/res/linux/systemd.service -> ${MY_PN}-${PV}.service )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="systemd"

RDEPEND="
	!app-text/espanso
	x11-libs/libnotify
	x11-libs/libXtst
	x11-misc/xclip
	x11-misc/xdotool
	systemd? ( sys-apps/systemd )"

S="${WORKDIR}"

src_prepare() {
	if use systemd; then
		cp "${DISTDIR}/${MY_PN}-${PV}.service" ${MY_PN}.service
		sed -i -e "s|{{{espanso_path}}}|/usr/bin/espanso|g" \
			${MY_PN}.service
	fi

	default
}

src_install() {
	dobin ${MY_PN}

	use systemd && systemd_douserunit ${MY_PN}.service
}

pkg_postinst() {
	echo
	elog "Thanks for installing ${MY_PN}."
	elog "The service can be started as an user with:"
	echo
	elog "${MY_PN} start"
	echo
	elog "And stop it with:"
	echo
	elog "${MY_PN} stop"
	echo
	elog "Also you can do this:"
	echo
	elog "${MY_PN} status"
	echo
	elog "to see the status of the service."
	if use systemd; then
		echo
		elog "To start ${MY_PN} automatically when you log in,"
		elog "enable the systemd user service:"
		elog "${MY_PN} register"
	fi
	echo
}
