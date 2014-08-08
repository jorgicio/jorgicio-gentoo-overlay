# Copyleft Calculate Linux 2007 - 2011
# Автор: Росен Александров - sandikata@yandex.ru - roko@jabber.calculate-linux.org - Freenode - ROKO__
# $Header: $
EAPI=3
inherit eutils subversion
DESCRIPTION="Програма за извличане на подробна информация за системата."
HOMEPAGE="http://code.google.com/p/inxi/"
ESVN_REPO_URI="http://inxi.googlecode.com/svn"
ESVN_PROJECT="inxi"

LICENSE="GPL-3"
SLOT="current"
KEYWORDS=""

DEPEND="
	x11-apps/mesa-progs
	x11-apps/xrandr
	x11-apps/xdpyinfo
	sys-apps/gawk
	sys-apps/pciutils
"
RDEPEND="${DEPEND}"

src_install() {
	dobin "${WORKDIR}"/"${PN}"-"${PV}"/trunk/inxi
	doman "${WORKDIR}"/"${PN}"-"${PV}"/trunk/inxi.1
        elog "За да видите кратка или пълна информация за системата."
        elog "inxi -b за кратка и inxi -F за пълна информация."
        elog "inxi -h за да видите допълнителните опции."
        echo
}
