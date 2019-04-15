# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="true"
inherit kde5

DESCRIPTION="Advanced audio player based on KDE frameworks"
HOMEPAGE="https://amarok.kde.org/"
SRC_URI="https://download.kde.org/stable/${PN}/${PV}/src/${P}.tar.xz"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
IUSE="ipod lastfm libav mtp ofa podcast wikipedia"

# ipod requires gdk enabled and also gtk compiled in libgpod
BDEPEND="virtual/pkgconfig"
DEPEND="
	$(add_frameworks_dep attica)
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep kdnssd)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kpackage)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	$(add_frameworks_dep threadweaver)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtscript 'scripttools')
	$(add_qt_dep qtsql)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
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
	wikipedia? ( $(add_qt_dep qtwebengine) )
"
RDEPEND="${DEPEND}
	!media-sound/amarok:4
	$(add_qt_dep qtquickcontrols2)
	!ofa? ( virtual/ffmpeg )
"

PATCHES=( "${FILESDIR}"/${PN}-2.8.90-mysqld-rpath.patch )

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

	kde5_src_configure
}

pkg_postinst() {
	kde5_pkg_postinst

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
