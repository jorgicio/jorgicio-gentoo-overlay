# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop git-r3 qmake-utils toolchain-funcs xdg

MY_PN="OpenBoard"

DESCRIPTION="Interactive whiteboard software for schools and universities"
HOMEPAGE="https://openboard.ch/index.en.html"
EGIT_REPO_URI="https://github.com/OpenBoard-org/${MY_PN}"

LICENSE="GPL-3"
SLOT="0"
IUSE="open-sankore"

DEPEND="
	app-arch/bzip2:0=
	app-text/libpaper
	app-text/poppler:0=[cxx,qt5,utils]
	dev-libs/quazip
	dev-libs/openssl:0/1.1
	dev-qt/qtcore:5
	dev-qt/qtmultimedia:5
	dev-qt/qtscript:5[scripttools]
	dev-qt/qtsvg:5
	dev-qt/qtwebkit:5
	dev-qt/qtxmlpatterns:5
	media-libs/fdk-aac:0=
	media-libs/libass:0=
	media-libs/libsdl
	media-libs/opus
	media-video/ffmpeg
	x11-libs/libva:0="
RDEPEND="${DEPEND}"

DOCS=( README.md )

PATCHES=(
	"${FILESDIR}/qchar.patch"
	"${FILESDIR}/qwebkit.patch"
	"${FILESDIR}/quazip.diff"
	"${FILESDIR}/poppler.patch"
	"${FILESDIR}/drop_ThirdParty_repo.patch"
	"${FILESDIR}/30fps.patch"
)

src_unpack() {
	git-r3_src_unpack
	if use open-sankore; then
		EGIT_REPO_URI="https://github.com/OpenBoard-org/${MY_PN}-Importer"
		EGIT_CHECKOUT_DIR="${WORKDIR}/${MY_PN}-Importer"
		git-r3_src_unpack
	fi
}

src_configure() {
	local CXX_FLAG
	tc-is-gcc && CXX_FLAG="linux-g++"
	tc-is-clang && CXX_FLAG="linux-clang-libc++"
	eqmake5 ${MY_PN}.pro -spec "${CXX_FLAG}"
	if use open-sankore; then
		cd "${WORKDIR}/${MY_PN}-Importer"
		eqmake5 ${MY_PN}Importer.pro -spec "${CXX_FLAG}"
	fi
}

src_compile() {
	default
	if use open-sankore; then
		cd "${WORKDIR}/${MY_PN}-Importer"
		emake
	fi
}

src_install() {
	exeinto /usr/share/${PN}
	doexe build/linux/release/product/${MY_PN}
	insinto /usr/share/${PN}
	doins -r resources/{customizations,etc,i18n,library}
	domenu "${FILESDIR}/${PN}.desktop"
	doicon resources/images/${MY_PN}.png
	dodir /usr/bin
	dosym "${ED%/}"/usr/share/${PN}/${MY_PN} /usr/bin/${PN}
	einstalldocs
	if use open-sankore; then
		cd "${WORKDIR}/${MY_PN}-Importer"
		exeinto /usr/share/${PN}
		doexe ${MY_PN}Importer
		dosym "${ED%/}"/usr/share/${PN}/${MY_PN}Importer /usr/bin/${PN}importer
	fi
}
