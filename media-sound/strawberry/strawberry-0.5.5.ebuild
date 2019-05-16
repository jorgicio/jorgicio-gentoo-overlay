# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils flag-o-matic l10n virtualx xdg

#PLOCALES="af ar be bg bn br bs ca cs cy da de el en en_CA en_GB eo es et eu fa fi fr ga gl he he_IL hi hr hu hy ia id is it ja ka kk ko lt lv mk_MK mr ms my nb nl oc pa pl pt pt_BR ro ru si_LK sk sl sr sr@latin sv te tr tr_TR uk uz vi zh_CN zh_TW"
PLOCALES="es nb"

DESCRIPTION="Modern music player and library organizer based on Clementine and Qt"
HOMEPAGE="https://www.strawbs.org/"
if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/jonaski/strawberry.git"
	inherit git-r3
else
	SRC_URI="https://github.com/jonaski/strawberry/releases/download/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="cdda +dbus debug ipod mms mtp phonon pulseaudio system-taglib tidal +udisks vlc xine"

REQUIRED_USE="
	udisks? ( dbus )
"

BDEPEND="
	>=dev-cpp/gtest-1.8.0
	dev-qt/linguist-tools:5
	sys-devel/gettext
	virtual/pkgconfig
"
COMMON_DEPEND="
	app-crypt/qca:2[qt5(+)]
	dev-db/sqlite:=
	dev-libs/crypto++[asm]
	dev-libs/glib:2
	dev-libs/libxml2
	dev-libs/protobuf:=
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5[ssl]
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtwidgets:5
	media-libs/alsa-lib
	media-libs/chromaprint:=
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	>=media-libs/libmygpo-qt-1.0.9[qt5(+)]
	sys-libs/zlib
	virtual/glu
	x11-libs/libX11
	cdda? ( dev-libs/libcdio:= )
	dbus? ( dev-qt/qtdbus:5 )
	ipod? ( >=media-libs/libgpod-0.8.0 )
	mtp? ( >=media-libs/libmtp-1.0.0 )
	phonon? ( media-libs/phonon )
	system-taglib? ( >=media-libs/taglib-1.11.1_p20181028 )
	vlc? ( media-video/vlc )
	xine? ( media-libs/xine-lib )
"
# Note: sqlite driver of dev-qt/qtsql is bundled, so no sqlite use is required; check if this can be overcome someway;
RDEPEND="${COMMON_DEPEND}
	media-plugins/gst-plugins-meta:1.0
	media-plugins/gst-plugins-soup:1.0
	media-plugins/gst-plugins-taglib:1.0
	mms? ( media-plugins/gst-plugins-libmms:1.0 )
	mtp? ( gnome-base/gvfs[mtp] )
	udisks? ( sys-fs/udisks:2 )
"
DEPEND="${COMMON_DEPEND}
	dev-libs/boost:=
	dev-qt/qtopengl:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	pulseaudio? ( media-sound/pulseaudio )
"

DOCS=( Changelog README.md )

src_prepare() {
	l10n_find_plocales_changes "src/translations" "" ".po"

	cmake-utils_src_prepare
	use system-taglib && rm -r 3rdparty/taglib
}

src_configure() {
	# spotify is not in portage
	local mycmakeargs=(
		-DBUILD_WERROR=OFF
		# avoid automagically enabling of ccache (bug #611010)
		-DCCACHE_EXECUTABLE=OFF
		-DENABLE_DEVICEKIT=OFF
		-DENABLE_GIO=ON
		-DLINGUAS="$(l10n_get_locales)"
		-DENABLE_AUDIOCD="$(usex cdda)"
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5DBus=$(usex !dbus)
		-DENABLE_LIBGPOD="$(usex ipod)"
		-DENABLE_LIBMTP="$(usex mtp)"
		-DENABLE_LIBPULSE="$(usex pulseaudio)"
		-DENABLE_PHONON="$(usex phonon)"
		-DENABLE_TIDAL="$(usex tidal)"
		-DENABLE_UDISKS2="$(usex udisks)"
		-DENABLE_VLC="$(usex vlc)"
		-DENABLE_XINE="$(usex xine)"
		-DUSE_SYSTEM_TAGLIB="$(usex system-taglib)"
	)

	use !debug && append-cppflags -DQT_NO_DEBUG_OUTPUT

	cmake-utils_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "Note that list of supported formats is controlled by media-plugins/gst-plugins-meta "
	elog "USE flags. You may be interested in setting aac, flac, mp3, ogg or wavpack USE flags "
	elog "depending on your preferences"

	if use phonon; then
		ewarn "WARNING: You enabled the 'phonon' USE-flag."
		ewarn "Phonon support for Strawberry is currently unstable,"
		ewarn "it may lead to some failures and settings are user-wide"
		ewarn "rather than application-wide. So use it with caution."
	fi

}
