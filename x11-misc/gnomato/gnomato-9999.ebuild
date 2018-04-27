# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit autotools flag-o-matic python-r1

DESCRIPTION="A timer for Pomodoro Technique"
HOMEPAGE="https://github.com/diegorubin/gnomato"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/releases/download/${PV}/${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	dev-libs/boost
	dev-libs/boost-build
	dev-cpp/gtkmm:3.0
	>=x11-libs/libnotify-0.7.3
	dev-util/intltool
	sys-devel/gettext[cxx]
	dev-db/sqlite:3
"
RDEPEND="${DEPEND}"

pkg_pretend(){
	if ! test-flag-CXX -std=c++11; then
		die "Your compiler doesn't support the c++11 standard, so it won't compile"
	fi
}

src_prepare(){
	sed -i "s/python2/python-2\.7/" configure.ac
	eautoreconf -vi
	default
}

src_compile(){
	append-cxxflags -std=c++11
	default
}
