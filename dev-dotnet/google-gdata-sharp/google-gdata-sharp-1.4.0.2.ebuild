# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit mono eutils

MY_PN="libgoogle-data-mono"

DESCRIPTION="C# bindings for the Google GData API"
HOMEPAGE="https://code.google.com/p/google-gdata/"
#SRC_URI="https://google-gdata.googlecode.com/files/${MY_PN}-${PV}.tar.gz"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/google-gdata/${MY_PN}-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# tests are completely broken (bug #310101), revisit in future bumps.
RESTRICT="test"

DEPEND=">=dev-lang/mono-2.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/pkgconfig-typo-fix.patch
	eapply_user
}

src_compile() {
	emake PREFIX=/usr || die "compilation failed"
}

src_install() {
	# The Makefile has prefix=/usr/local by default :|
	emake PREFIX=/usr DESTDIR="${ED}" install || die "installation failed"
}
