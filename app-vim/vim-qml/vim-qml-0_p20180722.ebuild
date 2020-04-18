# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

DESCRIPTION="vim plugin: highlighting syntax support for QML code"
HOMEPAGE="https://vimawesome.com/plugin/vim-qml"
LICENSE="vim"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/peterhoeg/${PN}.git"
else
	COMMIT="8af43da6950ce5483704bb97f5b24471d8ffda1a"
	SRC_URI="https://github.com/peterhoeg/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~x86-solaris"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi
IUSE=""

VIM_PLUGIN_HELPFILES="README.md"
VIM_PLUGIN_MESSAGES="This plugin enable highlighting syntax for QML code"
