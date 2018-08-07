# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker

DESCRIPTION="A browser plugin designed for the viewing of premium video content"
HOMEPAGE="https://www.google.com/chrome"
SRC_URI="
	https://www.google.com/intl/en/chrome/browser/privacy/eula_text.html -> chrome-eula_text.html
	amd64? ( https://www.slimjet.com/chrome/download-chrome.php?file=lnx%2Fchrome64_${PV}.deb -> ${P}.deb )"

LICENSE="google-chrome"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror strip"

DEPEND="dev-qt/qtwebengine:5"
RDEPEND="${DEPEND}"
S="${WORKDIR}"

src_unpack(){
	unpack_deb "${P}.deb"
}

src_install(){
	insinto "/usr/$(get_libdir)/qt5/plugins/ppapi"
	doins opt/google/chrome/libwidevinecdm*.so
	insinto "/usr/share/licenses/${PN}"
	doins "${DISTDIR}/chrome-eula_text.html"
}
