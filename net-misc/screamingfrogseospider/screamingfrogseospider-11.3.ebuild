# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit unpacker xdg-utils

DESCRIPTION="A small desktop program you can install on your PC or Mac which spiders websites’ links, images, CSS, script and apps from an SEO perspective."
HOMEPAGE="http://www.screamingfrog.co.uk/seo-spider/"
SRC_URI="https://www.screamingfrog.co.uk/products/seo-spider/${P/-/_}_all.deb"

LICENSE="screamingfrogseospider-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="system-java"

RDEPEND="
	system-java? (
		|| (
			dev-java/oracle-jre-bin[javafx]
			dev-java/oracle-jdk-bin[javafx]
		)
	)
"

S="${WORKDIR}"

DOCS="usr/share/doc/${PN}/changelog.gz usr/share/doc/${PN}/copyright"

src_unpack(){
	unpack_deb "${A}"
}

src_prepare() {
	mv usr/share/${PN}/tmp jre || die
	default
}

src_install(){
	mkdir -p "${D}/usr/share"
	dobin usr/bin/${PN}
	cp -r usr/share/{applications,icons,mime,${PN}} "${D}/usr/share"
	if use !system-java; then
		local jrefile
		if use amd64; then
			jrefile="jre64"
		elif use x86; then
			jrefile="jre32"
		fi
		tar xf jre/${jrefile}.tar.gz -C "${D}"/usr/share/${PN}
	fi
	doman usr/share/man/man1/${PN}.1.gz
	default
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}
