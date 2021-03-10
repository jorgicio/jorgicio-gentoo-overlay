# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CHROMIUM_LANGS="
	am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk vi zh-CN zh-TW"

inherit chromium-2 pax-utils unpacker xdg

MY_PV="$(ver_cut 1-3)-$(ver_cut 4-5)"
MY_PV="${MY_PV/_beta}"

DESCRIPTION="Password manager and secure wallet (currently in beta)"
HOMEPAGE="https://1password.com"
SRC_URI="https://onepassword.s3.amazonaws.com/linux/debian/pool/main/${PN:0:1}/${PN}/${PN}-${MY_PV}.deb"

LICENSE="1password"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="
	dev-libs/nss
	sys-auth/polkit
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver"

S="${WORKDIR}"
ONEPASSWORD_HOME="opt/1Password"
QA_PREBUILT="*"

src_prepare() {
	rm _gpgorigin

	pushd "${ONEPASSWORD_HOME}/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	mv usr/share/doc/${PN} usr/share/doc/${PF} || die
	gzip -d usr/share/doc/${PF}/changelog.gz || die
	default
}

src_install() {
	cp -r . "${ED}"
	pax-mark m "${ED}/${ONEPASSWORD_HOME}/${PN}"

	dosym /"${ONEPASSWORD_HOME}/${PN}" /usr/bin/${PN}
}
