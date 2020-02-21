# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#VIM_PLUGIN_VIM_VERSION="7.0"
inherit git-r3 vim-plugin

DESCRIPTION="vim plugin: Kotlin plugin for vim"
HOMEPAGE="https://github.com/udalov/kotlin-vim"
LICENSE="vim"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
EGIT_COMMIT="aea4336a1d66d91f1e87e8ebf2b33fd506bad74e"

IUSE=""

VIM_PLUGIN_HELPFILES="README.md"
VIM_PLUGIN_HELPTEXT="This plugin features Kotlin syntax highlighting, basic indentation and syntastic support"
