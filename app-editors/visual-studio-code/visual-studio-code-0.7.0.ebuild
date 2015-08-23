# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
SRC_URI="
	x86? ( https://az764295.vo.msecnd.net/public/${PV}/VSCode-linux-ia32.zip -> ${P}-x86.zip )
	amd64? ( https://az764295.vo.msecnd.net/public/${PV}/VSCode-linux-x64.zip -> ${P}-amd64.zip )
	"

LICENSE="Microsoft"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	>=media-libs/libpng-1.2.46
	>=x11-libs/gtk+-2.24.8-r1:2
	x11-libs/cairo
"
RDEPEND="${DEPEND}"


ARCH="$(uname -m)"

if [[ $ARCH == "x86_64" ]];then
	S="${WORKDIR}/VSCode-linux-x64"
else
	S="${WORKDIR}/VSCode-linux-ia32"
fi


src_install(){
	insinto "/opt/${PN}"
	doins -r *
	dosym "/opt/${PN}/Code" "/usr/bin/visual-studio-code"
	insinto "/usr/share/applications"
	doins ${FILESDIR}/${PN}.desktop
	insinto "/usr/share/pixmaps"
	doins ${FILESDIR}/${PN}.png
	fperms +x "/opt/${PN}/Code"
	fperms +x "/opt/${PN}/libffmpegsumo.so"
	fperms +x "/opt/${PN}/libgcrypt.so.11"
	fperms +x "/opt/${PN}/libnode.so"
	fperms +x "/opt/${PN}/libnotify.so.4"
}

pkg_postinst(){
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}
