# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A flat Material Design theme for GTK"
HOMEPAGE="https://github.com/vinceliuice/vimix-gtk-themes"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	MY_PV="${PV//./-}"
	MY_P="${PN}-${MY_PV}"
	SRC_URI="${HOMEPAGE}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	x11-libs/gtk+:3
	x11-themes/gtk-engines
	x11-themes/gtk-engines-murrine"
RDEPEND="${DEPEND}"

src_install() {
	mkdir -p "${ED}"/usr/share/themes
	./install.sh -d "${ED}"/usr/share/themes || die
}
