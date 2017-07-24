# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: A plugin for Meson build system"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=5378"
LICENSE="vim GPL-1"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=24206 -> ${P}.tar.gz"

VIM_PLUGIN_HELPFILES="README.md"
