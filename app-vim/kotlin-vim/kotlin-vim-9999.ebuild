# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 vim-plugin

DESCRIPTION="vim plugin: Kotlin plugin for vim"
HOMEPAGE="https://github.com/udalov/kotlin-vim"
LICENSE="vim"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"
KEYWORDS=""

IUSE=""

VIM_PLUGIN_HELPFILES="README.md"
VIM_PLUGIN_HELPTEXT="This plugin features Kotlin syntax highlighting, basic indentation and syntastic support"
