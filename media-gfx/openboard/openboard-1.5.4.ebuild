# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils toolchain-funcs xdg

MY_PN="OpenBoard"
MY_P="${MY_PN}-${PV}"
OPEN_SANKORE_COMMIT="47927bda021b4f7f1540b794825fb0d601875e79"

DESCRIPTION="Interactive whiteboard software for schools and universities"
HOMEPAGE="https://openboard.ch/index.en.html"
SRC_URI="https://github.com/OpenBoard-org/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	open-sankore? ( https://github.com/OpenBoard-org/${MY_PN}-Importer/archive/${OPEN_SANKORE_COMMIT}.tar.gz -> ${PN}-importer-20161008.tar.gz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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

S="${WORKDIR}/${MY_P}"

DOCS=( README.md )

PATCHES=(
	"${FILESDIR}/qchar.patch"
	"${FILESDIR}/qwebkit.patch"
	"${FILESDIR}/quazip.diff"
	"${FILESDIR}/poppler.patch"
	"${FILESDIR}/drop_ThirdParty_repo.patch"
)

src_configure() {
	local CXX_FLAG
	tc-is-gcc && CXX_FLAG="linux-g++"
	tc-is-clang && CXX_FLAG="linux-clang-libc++"
	eqmake5 ${MY_PN}.pro -spec "${CXX_FLAG}"
	if use open-sankore; then
		cd "${WORKDIR}/${MY_PN}-Importer-${OPEN_SANKORE_COMMIT}"
		eqmake5 ${MY_PN}Importer.pro -spec "${CXX_FLAG}"
	fi
}

src_compile() {
	default
	if use open-sankore; then
		cd "${WORKDIR}/${MY_PN}-Importer-${OPEN_SANKORE_COMMIT}"
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
		cd "${WORKDIR}/${MY_PN}-Importer-${OPEN_SANKORE_COMMIT}"
		exeinto /usr/share/${PN}
		doexe ${MY_PN}Importer
		dosym "${ED%/}"/usr/share/${PN}/${MY_PN}Importer /usr/bin/${PN}importer
	fi
}
