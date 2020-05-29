# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A semi-flat fork of the Ubuntu Ambiance theme"
HOMEPAGE="https://github.com/IonicaBizau/Flattiance"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN^}-${PV}"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="
	x11-libs/gtk+:2
	x11-libs/gtk+:3
	x11-libs/gdk-pixbuf
"
RDEPEND="${DEPEND}
	x11-themes/gtk-engines-flat
"

src_install(){
	insinto /usr/share/themes
	doins -r ${PN^}
}
