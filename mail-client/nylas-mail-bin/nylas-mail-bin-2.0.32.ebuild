# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit eutils unpacker python-r1

DESCRIPTION="A new cross-platform mail client, built on the modern web and designed to be extended. (official binary version)"
HOMEPAGE="http://nylas.com"
PKG_VER="fec7941"
SRC_URI="
	amd64? ( https://edgehill.s3-us-west-2.amazonaws.com/${PV}-${PKG_VER}/linux-deb/x64/NylasMail.deb -> ${P}-amd64.deb )
"

RESTRICT="mirror strip"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

QA_PRESTRIPPED="
	/usr/share/${PN//-bin}/nylas
	/usr/share/${PN//-bin}/libffmpeg.so
	/usr/share/${PN//-bin}/libnode.so
"

RDEPEND="
	x11-libs/gtk+:2
	gnome-base/libgnome-keyring
	gnome-base/gnome-keyring
	${PYTHON_DEPS}
	dev-util/desktop-file-utils
	gnome-base/gconf
	net-libs/nodejs[npm]
	x11-libs/libnotify
	x11-libs/libXtst
	dev-libs/nss
	media-libs/alsa-lib
	x11-libs/libXScrnSaver
	!mail-client/nylas-mail
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack(){
	unpack_deb "${A}"
}

src_prepare(){
	find -name '*.py' -exec sed -i 's|^#!/usr/bin/env python\s*$|#!/usr/bin/env python2|' {} \;
	find -name '*.py' -exec sed -i 's|^#!/usr/bin/python\s*$|#!/usr/bin/python2|' {} \;
	eapply_user
}

src_install(){
	insinto /
	doins -r *
	insinto /usr/share/licenses/${PN//-bin}
	doins usr/share/${PN//-bin}/LICENSE
	fperms +x /usr/share/${PN//-bin}/nylas
	fperms +x /usr/share/${PN//-bin}/libnode.so
	fperms +x /usr/share/${PN//-bin}/resources/apm/bin/{node,apm}
}

pkg_postinst(){
	einfo "Thanks for installing the new Nylas 2.0"
	einfo "In order to use it, first you must create a Nylas account in http://nylas.com"
	einfo "and then you can manage your e-mail accounts."
}
