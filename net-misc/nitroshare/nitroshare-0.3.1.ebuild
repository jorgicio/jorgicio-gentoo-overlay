# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CMAKE_MIN_VERSION="3.2.0"

inherit cmake-utils eutils versionator ${GIT_ECLASS}

MY_BR=$(get_version_component_range 1-2)

DESCRIPTION="Network File Transfer Application"
HOMEPAGE="http://nitroshare.net"
if [[ ${PV} == *9999* ]];then
	GIT_ECLASS="git-r3"
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/${PN}/${PN}-desktop"
	KEYWORDS=""
else
	SRC_URI="https://launchpad.net/nitroshare/${MY_BR}/${PV}/+download/${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="appindicator"

DEPEND=">=dev-qt/qtcore-5.1:5
		>=dev-qt/qtsvg-5.1:5
		>=dev-qt/qtnetwork-5.1:5
		x11-libs/libnotify"

RDEPEND="${DEPEND}
		appindicator? (
			x11-libs/gtk+:2
			dev-libs/libappindicator:2
		)"


