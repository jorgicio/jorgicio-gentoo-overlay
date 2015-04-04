# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils perl-module

DESCRIPTION="A frontend for ClamAV using Gtk2-perl"
HOMEPAGE="http://clamtk.sourceforge.net/"
SRC_URI="https://bitbucket.org/dave_theunsub/clamtk/downloads/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

LANGS="af ar ast bg bs ca cs da de el_GR en_GB es eu fi fo fr gl he hr hu id it ja ko lt mr ms nb nl nn pl pt_BR pt ro ru sk sl sv te th tr ug uk uz zh_CN zh_TW"
IUSE="nls"
for i in ${LANGS}; do
	IUSE="${IUSE} linguas_${i}"
done

DEPEND=""
RDEPEND=">=dev-perl/gtk2-perl-1.140
	dev-perl/libwww-perl
	dev-perl/Date-Calc
	dev-util/desktop-file-utils
	>=app-antivirus/clamav-0.95
	dev-perl/Text-CSV
	nls? ( dev-perl/Locale-gettext )
	virtual/udev"

src_unpack() {
	unpack ${A}
	cd "${S}"
	gunzip ${PN}.1.gz || die "gunzip failed"
}

src_install() {
	dobin ${PN}

	doicon images/* || die "doicon failed"
	domenu ${PN}.desktop || die "domenu failed"

	dodoc CHANGES README
	doman ${PN}.1

	# The custom Perl modules
	perlinfo
	insinto ${VENDOR_LIB}/ClamTk
	doins lib/*.pm

	if use nls; then
		local l
		for l in $LANGS; do
			use "linguas_${l}" && domo "po/${l}.mo"
		done
	fi
}
