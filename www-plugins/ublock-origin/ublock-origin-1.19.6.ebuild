# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

MY_PN="uBlock"

DESCRIPTION="An efficient blocker for Chromium and Firefox. Fast and lean."
HOMEPAGE="https://github.com/gorhill/uBlock"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/gorhill/${MY_PN}.git"
else
	MY_PV="${PV/_pre/b}"
	MY_PV="${PV/_rc/rc}"
	MY_P="${MY_PN}-${MY_PV}"
	SRC_URI="https://github.com/gorhill/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="chromium firefox opera thunderbird"
REQUIRED_USE="|| ( chromium firefox opera thunderbird )"
RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="app-arch/zip"

DOCS=( MANIFESTO.md README.md )

src_unpack(){
	[[ ${PV} == 9999 ]] && git-r3_src_unpack || default_src_unpack
	EGIT_REPO_URI="https://github.com/uBlockOrigin/uAssets.git"
	EGIT_CHECKOUT_DIR="${WORKDIR}/uAssets"
	[[ ${PV} == 9999 ]] && EGIT_COMMIT_DATE=$(GIT_DIR="${S}/.git" git show -s --format=%ct || die)
	git-r3_src_unpack
}

src_prepare(){
	sed -r -i \
		-e 's/(git.+clone.+)https.+/\1\.\.\/uAssets/' \
		tools/make-assets.sh || die
	default_src_prepare
}

src_compile() {
	use chromium && ( tools/make-chromium.sh || die )
	if use firefox; then
		tools/make-firefox.sh || die
		cd dist/build/uBlock0.firefox
		zip -r uBlock0@raymondhill.net.xpi .
		cd -
	fi
	use opera && ( tools/make-opera.sh || die )
	if use thunderbird; then
		tools/make-thunderbird.sh || die
		cd dist/build/uBlock0.thunderbird
		zip -r uBlock0@raymondhill.net.xpi .
		cd -
	fi
	default_src_compile
}

src_install() {
	if use chromium; then
		insinto "/usr/share/chromium/extensions/${PN}"
		doins -r dist/build/uBlock0.chromium/.
	fi

	if use firefox; then
		insinto "/usr/$(get_libdir)/mozilla/firefox/browser/extensions"
		doins dist/build/uBlock0.firefox/uBlock0@raymondhill.net.xpi
	fi

	if use opera; then
		insinto "/usr/$(get_libdir)/opera/extensions/${PN}"
		doins -r dist/build/uBlock0.opera/.
	fi

	if use thunderbird; then
		insinto "/usr/$(get_libdir)/mozilla/thunderbird/extensions"
		doins dist/build/uBlock0.thunderbird/uBlock0@raymondhill.net.xpi
	fi
}
