# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

COMMIT="b9fa728701a0aa0b9a2ffe92f10880348fc27a8f"

DESCRIPTION="vim plugin: Kotlin plugin for vim"
HOMEPAGE="https://github.com/udalov/kotlin-vim"
LICENSE="vim"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"

IUSE=""

VIM_PLUGIN_HELPFILES="README.md"
VIM_PLUGIN_HELPTEXT="This plugin features Kotlin syntax highlighting, basic indentation and syntastic support"

S="${WORKDIR}/${PN}-${COMMIT}"
