# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 vim-plugin

DESCRIPTION="vim plugin: Collection of awesome color schemes for Vim, merged for quick use"
HOMEPAGE="https://github.com/rafi/awesome-vim-colorschemes"
LICENSE="MIT public-domain vim.org vim"
KEYWORDS=""
IUSE=""
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}.git"

VIM_PLUGIN_HELPTEXT="This plugin is a collection of awesome color schemes for Neo/vim, merged for quick use."
RDEPEND="
	app-vim/airline
	!app-vim/colorschemes
"
