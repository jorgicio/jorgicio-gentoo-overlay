# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vala

DESCRIPTION="Advance file manager for Linux written in Vala"
HOMEPAGE="https://teejee2008.github.io/polo"
SRC_URI="https://github.com/teejee2008/polo/archive/v${PV/_/-}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(vala_depend)
	x11-libs/gtk+:3
	dev-libs/libgee:0.8
	net-libs/libsoup:2.4[vala]
	x11-libs/vte:2.91[vala]
	net-misc/rsync
	gnome-base/gvfs
	app-arch/p7zip
"
RDEPEND="${DEPEND}
	media-video/mediainfo
	app-shells/fish
	media-libs/exiftool
	sys-apps/pv
	virtual/ffmpeg
	net-misc/rclone
	sys-apps/gnome-disk-utility
	app-arch/lzop
"
S="${WORKDIR}/${P/_/-}"

src_prepare(){
	PATCHES=( "${FILESDIR}/0001-Re-add-support-for-vte291-0.52.patch" )
	sed -i -e "s/valac/\$\(VALAC\)/" src/makefile
	default_src_prepare
	export VALAC="$(type -P valac-$(vala_best_api_version))"
	vala_src_prepare
}

src_install(){
	default_src_install
	dosym "${EROOT}/usr/bin/polo-gtk" "${EROOT}/usr/bin/polo"
	rm "${EROOT}/usr/bin/polo-uninstall"
}

pkg_postinst(){
	echo
	einfo "If you want to support the project, consider"
	einfo "doing a donation by buying its donation"
	einfo "features. See https://github.com/teejee2008/polo/wiki/Donation-Features"
	einfo "for more info."
	echo
}
