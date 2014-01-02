# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2"
inherit eutils python

DESCRIPTION="Displays information about your CPU, RAM, Motherboard and more"
HOMEPAGE="http://cpug.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN/-/}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-python/pygobject:2
	dev-python/pygtk:2"

src_prepare() {
	sed -i -e "s:data/logos/:${EPREFIX}/usr/share/${PN}/data/logos/:" \
		-e "s:${PN}.glade:${EPREFIX}/usr/share/${PN}/${PN}.glade:" \
		${PN} || die
	python_convert_shebangs 2 ${PN}
}

src_install() {
	dobin ${PN}
	domenu data/${PN}.desktop
	doicon data/${PN}.png
	doman doc/${PN}.1
	insinto /usr/share/${PN}
	doins ${PN}.glade
	rm data/${PN}.desktop || die
	doins -r data
}
