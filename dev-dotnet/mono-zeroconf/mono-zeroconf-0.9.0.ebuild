# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit base mono

DESCRIPTION="a cross platform Zero Configuration Networking library for Mono and .NET"
HOMEPAGE="http://www.mono-project.com/Mono.Zeroconf"
SRC_URI="https://github.com/arfbtwn/Mono.Zeroconf/archive/Mono.Zeroconf-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
S="${WORKDIR}/Mono.Zeroconf-Mono.Zeroconf-${PV}"

RDEPEND=">=dev-lang/mono-2.0
	>=net-dns/avahi-0.6[mono]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -e 's:mono/2.0:mono/2.0-api:g' \
		-i configure || die
}

src_configure() {
	econf $(use_enable doc docs) --enable-avahi
}

src_compile() {
	emake -j1 || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README || die "docs failed"
	mono_multilib_comply
}
