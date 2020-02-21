# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit rpm gnome2-utils xdg-utils

DESCRIPTION="Desktop chat client for Google Hangouts"
HOMEPAGE="https://github.com/yakyak/yakyak"
SRC_URI="
	amd64? ( https://github.com/yakyak/${PN//-bin}/releases/download/v${PV}/${PN//-bin}-${PV}-linux-x86_64.rpm )
	x86? ( https://github.com/yakyak/${PN//-bin}/releases/download/v${PV}/${PN//-bin}-${PV}-linux-i386.rpm )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

DEPEND=""
RDEPEND="${DEPEND}"
RESTRICT="strip"

QA_PRESTRIPPED="
	/opt/yakyak/libnode.so
	/opt/yakyak/libffmpeg.so
	/opt/yakyak/yakyak
"


S="${WORKDIR}"

src_prepare() {
	default_src_prepare
	use gnome && xdg_environment_reset
}

src_unpack() {
	use amd64 && rpm_unpack ${PN//-bin}-${PV}-linux-x86_64.rpm
	use x86 && rpm_unpack ${PN//-bin}-${PV}-linux-i386.rpm
}

src_install() {
	cp -r "${S}/usr" "${D}/" || die "Install failed!"
	cp -r "${S}/opt" "${D}/" || die "Install failed!"
}

pkg_preinst() {
	use gnome && gnome2_icon_savelist
}

pkg_postinst() {
	use gnome && gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	use gnome && gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
