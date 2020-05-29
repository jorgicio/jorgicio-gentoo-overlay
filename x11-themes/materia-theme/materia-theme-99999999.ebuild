# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Material Design-like flat theme for GTK3, GTK2 and GNOME Shell"
HOMEPAGE="https://github.com/nana-4/materia-theme"

if [[ ${PV} == 99999999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="
	x11-libs/gtk+:2
	>=x11-libs/gtk+-3.18:3
	>=x11-themes/gnome-themes-standard-3.18
	x11-libs/gdk-pixbuf
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/sassc
	media-gfx/inkscape
	media-gfx/optipng"

src_install(){
	mkdir -p "${ED}/usr/share/themes"
	./install.sh --dest "${ED}/usr/share/themes" || die
}
