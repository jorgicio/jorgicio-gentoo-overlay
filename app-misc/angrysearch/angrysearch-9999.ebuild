# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_REQ_USE="sqlite"
PYTHON_COMPAT=( python3_{5,6,7,8} )

inherit eutils python-single-r1

DESCRIPTION="Linux file search, instant results as you type"
HOMEPAGE="https://github.com/DoTheEvo/ANGRYsearch"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="https://github.com/DoTheEvo/ANGRYsearch/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/ANGRYsearch-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="notification fm_integration"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
DEPEND="
	>=dev-python/PyQt5-5.4.1[${PYTHON_USEDEP},gui]
	>=app-admin/sudo-1.8.12
	>=x11-libs/libxkbcommon-0.5.0
	>=x11-misc/xdg-utils-1.1.0_rc2"
RDEPEND="${DEPEND}
	notification? ( dev-python/pygobject[${PYTHON_USEDEP}] )
	fm_integration? ( x11-misc/xdotool )"
BDEPEND="${PYTHON_DEPS}"

DOCS=( README.md )

src_prepare() {
	sed -i angrysearch.desktop \
		-e "s:Exec=python3 /usr/share/angrysearch/angrysearch.py:Exec=angrysearch:" \
		|| die
	default_src_prepare
}

src_install() {
	insinto /usr/share/${PN}
	doins -r "${S}"/*
	python_fix_shebang "${ED}"/usr/share/${PN}/angrysearch*.py
	fperms 0755 /usr/share/${PN}/angrysearch.py
	fperms 0755 /usr/share/${PN}/angrysearch_update_database.py
	dosym /usr/share/${PN}/angrysearch.py /usr/bin/angrysearch
	insinto /usr/share/applications/
	doins angrysearch.desktop
	insinto /usr/share/pixmaps/
	doins angrysearch.svg
}
