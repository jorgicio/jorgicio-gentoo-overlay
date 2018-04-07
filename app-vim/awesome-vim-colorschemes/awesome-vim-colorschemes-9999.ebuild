# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin git-r3

DESCRIPTION="vim plugin: Collection of awesome color schemes for Vim, merged for quick use"
HOMEPAGE="https://github.com/rafi/awesome-vim-colorschemes"
LICENSE="MIT public-domain vim.org vim"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE=""
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}.git"

VIM_PLUGIN_HELPTEXT="This plugin is a collection of awesome color schemes for Neo/vim, merged for quick use."
RDEPEND="app-vim/airline"
