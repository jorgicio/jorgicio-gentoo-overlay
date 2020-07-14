# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit ecm kde.org

DESCRIPTION="Qt-based application for WhatsApp Web"
HOMEPAGE="https://gitlab.com/scarpetta/qtwaw"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	COMMIT="18cba6c29432453817e6ea13b9858f530f4ad38a"
	SRC_URI="${HOMEPAGE}/-/archive/v${PV}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-v${PV}-${COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwebengine:5[widgets]
	dev-qt/qtwidgets:5
	kde-frameworks/kdbusaddons:5
	kde-frameworks/knotifications:5"
RDEPEND="${DEPEND}"
BDEPEND="dev-qt/linguist-tools:5"
