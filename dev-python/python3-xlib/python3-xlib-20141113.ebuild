# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_{3,4} )
EGIT_REPO_URI="https://github.com/LiuLang/python3-xlib.git"
EGIT_COMMIT="e68a323cc8e2441c488344cc2225fef0baa17526"

inherit git-r3 distutils-r1

DESCRIPTION="X11 interface for Python3"
HOMEPAGE="https://github.com/LiuLang/python3-xlib"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

python_prepare_all() {
	sed -e 's:make:$(MAKE):g' -i doc/Makefile || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		cd doc || die
		VARTEXFONTS="${T}"/fonts emake html
	fi
}

python_test() {
	cd test || die

	local t
	for t in *.py; do
		"${PYTHON}" "${t}" || die
	done
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/html/. )
	distutils-r1_python_install_all
}
