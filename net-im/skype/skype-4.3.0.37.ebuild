# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-4.2.0.13.ebuild,v 1.1 2014/01/29 15:55:49 jlec Exp $

EAPI=5

inherit eutils gnome2-utils pax-utils

DESCRIPTION="P2P Internet Telephony (VoiceIP) client"
HOMEPAGE="http://www.skype.com/"
SRC_URI="http://download.${PN}.com/linux/${P}.tar.bz2"

LICENSE="${PN}-4.0.0.7-copyright ${PN}-4.0.0.7-third-party_attributions.txt"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pax_kernel selinux"

QA_PREBUILT=opt/bin/${PN}
RESTRICT="mirror strip" #299368

EMUL_X86_VER=20120520

RDEPEND="
	virtual/ttf-fonts
	amd64? (
		|| (
			(
				dev-qt/qtcore:4[abi_x86_32(-)]
				dev-qt/qtdbus:4[abi_x86_32(-)]
				dev-qt/qtgui:4[accessibility,abi_x86_32(-)]
				dev-qt/qtwebkit:4[abi_x86_32(-)]
			)
			>=app-emulation/emul-linux-x86-qtlibs-${EMUL_X86_VER}
		)
		|| (
			media-libs/alsa-lib[abi_x86_32(-)]
			>=app-emulation/emul-linux-x86-soundlibs-${EMUL_X86_VER}
		)
		|| (
			(
				x11-libs/libX11[abi_x86_32(-)]
				x11-libs/libXext[abi_x86_32(-)]
				x11-libs/libXScrnSaver[abi_x86_32(-)]
				x11-libs/libXv[abi_x86_32(-)]
			)
			>=app-emulation/emul-linux-x86-xlibs-${EMUL_X86_VER}
		)
	)
	x86? (
		media-libs/alsa-lib
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXScrnSaver
		x11-libs/libXv
		dev-qt/qtcore:4
		dev-qt/qtdbus:4
		dev-qt/qtgui:4[accessibility]
		dev-qt/qtwebkit:4
	)
	selinux? ( sec-policy/selinux-skype )"

src_compile() {
	if type -P lrelease >/dev/null; then
		lrelease lang/*.ts || die
	fi
	rm -f lang/*.ts || die
}

src_install() {
	into /opt
	dobin ${PN}
	fowners root:audio /opt/bin/${PN}

	insinto /etc/dbus-1/system.d
	doins ${PN}.conf

	insinto /usr/share/skype
	doins -r avatars lang sounds

	dodoc README

	local res
	for res in 16 32 48 64 96 128 256; do
		newicon -s ${res} icons/SkypeBlue_${res}x${res}.png ${PN}.png
	done

	domenu skype.desktop

	if use pax_kernel; then
		pax-mark Cm "${ED}"/opt/bin/${PN} || die
		eqawarn "You have set USE=pax_kernel meaning that you intend to run"
		eqawarn "${PN} under a PaX enabled kernel.  To do so, we must modify"
		eqawarn "the ${PN} binary itself and this *may* lead to breakage!  If"
		eqawarn "you suspect that ${PN} is being broken by this modification,"
		eqawarn "please open a bug."
	fi

	echo PRELINK_PATH_MASK=/opt/bin/${PN} > ${T}/99${PN}
	doenvd "${T}"/99${PN} #430142
}

pkg_preinst() {
	gnome2_icon_savelist

	rm -rf "${EROOT}"/usr/share/${PN} #421165
}

pkg_postinst() {
	gnome2_icon_cache_update

	# http://bugs.gentoo.org/360815
	elog "For webcam support, see \"LD_PRELOAD\" section of \"README.lib\" document provided by"
	elog "media-libs/libv4l package and \"README\" document of this package."
	if use amd64; then
		elog "You can install app-emulation/emul-linux-x86-medialibs package for the 32bit"
		elog "libraries from the media-libs/libv4l package."
	fi
}

pkg_postrm() {
	gnome2_icon_cache_update
}
