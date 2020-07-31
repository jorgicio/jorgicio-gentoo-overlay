# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="X cursor theme inspired by Material Design"
HOMEPAGE="https://github.com/vinceliuice/vimix-cursors"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
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

BDEPEND="
	media-gfx/inkscape
	x11-apps/xcursorgen"

src_prepare() {
	# Remove prebuilt assets
	rm -rf {dist,dist-white}

	# Fix for inkscape 1.0
	sed -i 's|inkscape -z -e|inkscape -o|g' build.sh

	# Fix DESTDIR
	sed -i 's#/usr#\${DESTDIR}/usr#' install.sh

	# Fix sandbox issue
	addpredict "${BROOT}"/usr/share/inkscape/fonts/.uuid.TMP-XXXXXX

	default
}

src_compile() {
	./build.sh || die
}

src_install() {
	mkdir -p "${ED}"/usr/share/icons

	DESTDIR="${ED}" ./install.sh || die
}
