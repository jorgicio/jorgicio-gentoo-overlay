# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_HANDBOOK="true"
inherit ecm kde.org

DESCRIPTION="Advanced audio player based on KDE frameworks"
HOMEPAGE="https://amarok.kde.org/"
COMMIT="854844c1dc2c5eedf1d9b1a383536e9d9f2e539e"
SRC_URI="https://github.com/KDE/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2"
IUSE="ipod lastfm libav mtp ofa podcast wikipedia"
SLOT="5"

# ipod requires gdk enabled and also gtk compiled in libgpod
BDEPEND="virtual/pkgconfig"
DEPEND="
	kde-frameworks/attica:5
	kde-frameworks/karchive:5
	kde-frameworks/kcmutils:5
	kde-frameworks/kcodecs:5
	kde-frameworks/kcompletion:5
	kde-frameworks/kconfig:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kcrash:5
	kde-frameworks/kdbusaddons:5
	kde-frameworks/kdeclarative:5
	kde-frameworks/kdnssd:5
	kde-frameworks/kglobalaccel:5
	kde-frameworks/kguiaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kiconthemes:5
	kde-frameworks/kio:5
	kde-frameworks/kitemviews:5
	kde-frameworks/knewstuff:5
	kde-frameworks/knotifications:5
	kde-frameworks/kpackage:5
	kde-frameworks/kservice:5
	kde-frameworks/ktexteditor:5
	kde-frameworks/ktextwidgets:5
	kde-frameworks/kwidgetsaddons:5
	kde-frameworks/kwindowsystem:5
	kde-frameworks/kxmlgui:5
	kde-frameworks/solid:5
	kde-frameworks/threadweaver:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtscript:5[scripttools]
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	app-crypt/qca:2[qt5(+)]
	dev-db/mysql-connector-c:=
	media-libs/phonon[qt5(+)]
	media-libs/taglib
	media-libs/taglib-extras
	sci-libs/fftw:3.0
	sys-libs/zlib
	virtual/opengl
	ipod? (
		dev-libs/glib:2
		media-libs/libgpod[gtk]
	)
	ofa? (
		media-libs/libofa
		!libav? ( media-video/ffmpeg:= )
		libav? ( media-video/libav:= )
	)
	lastfm? ( >=media-libs/liblastfm-1.1.0_pre20150206 )
	mtp? ( media-libs/libmtp )
	podcast? ( >=media-libs/libmygpo-qt-1.0.9_p20180307 )
	wikipedia? ( dev-qt/qtwebengine:5 )
"
RDEPEND="${DEPEND}
	!media-sound/amarok:4
	dev-qt/qtquickcontrols2:5
	!ofa? ( virtual/ffmpeg )
"

PATCHES=(
	"${FILESDIR}/${PN}-2.8.90-mysqld-rpath.patch"
	"${FILESDIR}/${PN}_mariadb.patch"
)

src_configure() {
	local mycmakeargs=(
		-DWITH_MP3Tunes=OFF
		-DWITH_PLAYER=ON
		-DWITH_UTILITIES=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Googlemock=ON
		-DWITH_MYSQL_EMBEDDED=OFF
		-DWITH_IPOD=$(usex ipod)
		$(cmake-utils_use_find_package lastfm LibLastFm)
		$(cmake-utils_use_find_package mtp Mtp)
		$(cmake-utils_use_find_package ofa LibOFA)
		$(cmake-utils_use_find_package podcast Mygpo-qt5)
		$(cmake-utils_use_find_package wikipedia Qt5WebEngine)
	)

	use ipod && mycmakeargs+=( DWITH_GDKPixBuf=ON )

	ecm_src_configure
}

pkg_postinst() {
	ecm_pkg_postinst

	pkg_is_installed() {
		echo "${1} ($(has_version ${1} || echo "not ")installed)"
	}

	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "You'll have to configure amarok to use an external db server, one of:"
		elog "    $(pkg_is_installed dev-db/mariadb)"
		elog "    $(pkg_is_installed dev-db/mysql)"
		elog "Please read https://community.kde.org/Amarok/Community/MySQL for details on how"
		elog "to configure the external db and migrate your data from the embedded database."
	fi
}
