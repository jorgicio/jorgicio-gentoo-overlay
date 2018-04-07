# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A flat theme for Ubuntu and other GTK-based Linux systems"
HOMEPAGE="https://blog.anmoljagetia.me/flatabulous-ubuntu-theme"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/anmoljagetia/Flatabulous.git"
else
	SRC_URI="https://github.com/anmoljagetia/Flatabulous/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
	S="${WORKDIR}/Flatabulous-${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="x11-themes/gtk-engines-flat"
DEPEND="${RDEPEND}"

src_prepare(){
	rm -r debian || die
	default
}

src_install(){
	insinto "/usr/share/themes/Flatabulous"
	doins -r *
}
