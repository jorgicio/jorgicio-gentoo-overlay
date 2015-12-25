# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils user

DESCRIPTION="A tool for securing communications between a client and a DNS resolver"
HOMEPAGE="http://dnscrypt.org/"
SRC_URI="http://download.dnscrypt.org/${PN}/${P}.tar.bz2"

LICENSE="ISC"
SLOT="0"
KEYWORDS="*"
IUSE="+plugins ldns systemd"

DEPEND="dev-libs/libsodium
	ldns? ( net-libs/ldns )
	systemd? ( sys-apps/systemd )"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog COPYING NEWS README.markdown README-PLUGINS.markdown
	TECHNOTES THANKS )

pkg_setup() {
	enewgroup dnscrypt
	enewuser dnscrypt -1 -1 /var/empty dnscrypt
}

src_prepare(){
	use systemd && epatch ${FILESDIR}/${P}-remove-network-target.patch
}

src_configure() {
	econf \
		$(use_enable plugins) \
		$(use_with systemd)
}

src_install() {
	default
	if use !systemd; then
		newinitd "${FILESDIR}/${PN}.initd" ${PN}
		newconfd "${FILESDIR}/${PN}.confd" ${PN}
	fi
}
