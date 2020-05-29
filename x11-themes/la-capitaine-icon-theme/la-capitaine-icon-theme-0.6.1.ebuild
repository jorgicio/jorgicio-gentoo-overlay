# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils

DESCRIPTION="Icon pack based in macOS and Google Material Design"
HOMEPAGE="https://github.com/keeferrourke/la-capitaine-icon-theme"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

DOCS=( README.md Thanks.md Credits.md COPYING )

src_prepare() {
	rm configure || die
	default
}

src_install(){
	default
	rm ${DOCS[@]} LICENSE || die
	insinto /usr/share/icons/La-Capitaine
	doins -r .
}

pkg_preinst(){
	gnome2_icon_savelist
}

pkg_postinst(){
	gnome2_icon_cache_update
}

pkg_postrm(){
	gnome2_icon_cache_update
}
