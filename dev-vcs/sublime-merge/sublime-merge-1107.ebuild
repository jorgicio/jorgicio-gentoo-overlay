# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit desktop gnome2-utils xdg-utils

MY_PN=${PN/-/_}

DESCRIPTION="A new Git Client, from the creators of Sublime Text"
HOMEPAGE="https://www.sublimemerge.com"
SRC_URI="
	amd64? ( https://download.sublimetext.com/${MY_PN}_build_${PV}_x64.tar.xz )
"

LICENSE="Sublime"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dbus"
RESTRICT="bindist mirror strip"

RDEPEND="
	dev-vcs/git
	dev-libs/glib:2
	x11-libs/gtk+:3
	x11-libs/libX11
	dbus? ( sys-apps/dbus )
"

QA_PREBUILD="*"
S="${WORKDIR}/${MY_PN}"

src_prepare(){
	sed -i -e "s#/opt/sublime_merge#/opt/sublime-merge#" ${MY_PN}.desktop
	default_src_prepare
}

src_install(){
	insinto /opt/${PN}
	doins -r Icon Packages changelog.txt
	exeinto /opt/${PN}
	doexe crash_reporter git-credential-sublime ssh-askpass-sublime ${MY_PN}
	domenu ${MY_PN}.desktop
	local size
	for size in 16 32 48 128 256; do
		doicon --size "${size}" Icon/${size}x${size}/${PN}.png
	done
}

pkg_preinst(){
	gnome2_icon_savelist
}

pkg_postinst(){
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm(){
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
