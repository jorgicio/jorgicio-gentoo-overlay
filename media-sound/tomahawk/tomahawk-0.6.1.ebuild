# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tomahawk/tomahawk-0.6.1.ebuild,v 1.8 2014/07/19 11:40:34 johu Exp $

EAPI=5

QT_MINIMAL="4.7.0"

CMAKE_MIN_VERSION="2.8.6"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="http://download.tomahawk-player.org/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	GIT_ECLASS="git-2"
	EGIT_REPO_URI="git://github.com/tomahawk-player/${PN}.git"
	KEYWORDS=""
fi

inherit cmake-utils qt4-r2 ${GIT_ECLASS}

DESCRIPTION="Multi-source social music player"
HOMEPAGE="http://tomahawk-player.org/"

LICENSE="GPL-3 BSD"
SLOT="0"
IUSE="debug jabber twitter"

DEPEND="
	app-crypt/qca:2
	>=dev-cpp/clucene-2.3.3.4
	>=dev-libs/boost-1.41
	>=dev-libs/libattica-0.4.0
	dev-libs/qjson
	dev-libs/quazip
	>=dev-qt/qtcore-${QT_MINIMAL}:4
	>=dev-qt/qtdbus-${QT_MINIMAL}:4
	|| ( ( >=dev-qt/qtgui-4.8.5:4 dev-qt/designer:4 ) <dev-qt/qtgui-4.8.5:4 )
	>=dev-qt/qtsql-${QT_MINIMAL}:4[sqlite]
	>=dev-qt/qtsvg-${QT_MINIMAL}:4
	>=dev-qt/qtwebkit-${QT_MINIMAL}:4
	>=media-libs/liblastfm-1.0.1
	>=media-libs/libechonest-2.0.1
	>=media-libs/phonon-4.5.0
	>=media-libs/taglib-1.6.0
	x11-libs/libX11
	jabber? ( >=net-libs/jreen-1.1.1 )
	twitter? ( net-libs/qtweetlib )
"
RDEPEND="${DEPEND}
	app-crypt/qca-ossl
"
DOCS=( AUTHORS ChangeLog README.md )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with jabber Jreen)
		$(cmake-utils_use_with twitter QTweetLib)
	)

	if [[ ${PV} != *9999* ]]; then
		mycmakeargs+=( -DBUILD_RELEASE=ON )
	fi

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
