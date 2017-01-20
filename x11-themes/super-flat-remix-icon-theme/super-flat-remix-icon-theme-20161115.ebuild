# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION=""
HOMEPAGE="http://gnome-look.org/content/show.php/Super+flat+remix+icon+theme?content=169073 https://github.com/daniruiz/Flat-Remix"
EGIT_REPO_URI="https://github.com/daniruiz/Flat-Remix.git"

if [[ ${PV} == *99999999* ]];then
	KEYWORDS=""
else
	KEYWORDS="~*"
	EGIT_COMMIT="f5268ff43febf5035b4b0fb997f7357b986bf9d0"
fi

LICENSE="CC-BY-SA-4.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install(){
	insinto /usr/share/icons
	doins -r *
	dodoc README.md
}
