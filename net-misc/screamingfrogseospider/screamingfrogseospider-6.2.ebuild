# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils unpacker

DESCRIPTION="A small desktop program you can install on your PC or Mac which spiders websites’ links, images, CSS, script and apps from an SEO perspective."
HOMEPAGE="http://www.screamingfrog.co.uk/seo-spider/"
SRC_URI="https://www.screamingfrog.co.uk/products/seo-spider/${P/-/_}_all.deb"

LICENSE="custom"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	|| (
		dev-java/oracle-jre-bin[javafx]
		dev-java/oracle-jdk-bin[javafx]
	)
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack(){
	unpack_deb "${A}"
}

src_install(){
	insinto /usr
	doins -r usr/share
	dobin usr/bin/${PN}
}
