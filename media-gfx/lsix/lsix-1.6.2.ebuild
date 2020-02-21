# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Image viewer for terminal that use sixel graphics"
HOMEPAGE="https://github.com/hackerb9/lsix"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/hackerb9/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/hackerb9/${PN}/archive/${PV}.tar.gz ->  ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="djvu jpeg jpeg2k png svg tiff webp"

RDEPEND="media-gfx/imagemagick[truetype,djvu?,jpeg?,jpeg2k?,png?,svg?,tiff?,webp?]"

src_install() {
	einstalldocs
	dobin lsix
}
