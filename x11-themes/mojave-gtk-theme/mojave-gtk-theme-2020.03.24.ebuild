# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A macOS-like theme for GTK+ "
HOMEPAGE="https://github.com/vinceliuice/Mojave-gtk-theme"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	SRC_URI=""
else
	MY_PV="${PV//./-}"
	MY_P="${PN^}-${MY_PV}"
	SRC_URI="${HOMEPAGE}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-3"
SLOT="0"
RESTRICT="strip"

DEPEND="
	x11-libs/gtk+:2
	x11-libs/gtk+:3
	x11-themes/gtk-engines
	x11-themes/gtk-engines-murrine"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/sassc
	<media-gfx/inkscape-1.0_rc1
	media-gfx/optipng"

src_install() {
	mkdir -p "${ED}/usr/share/themes"
	./install.sh \
		--dest "${ED}/usr/share/themes" \
		--icon normal
}
