# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

DESCRIPTION="vim plugin: An indent guides plugin displaying thin vertical lines."
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=4354"
LICENSE="MIT"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	KEYWORDS=""
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/Yggdroot/${PN}.git"
else
	KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
	SRC_URI="https://github.com/Yggdroot/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

IUSE=""

VIM_PLUGIN_HELPTEXT="This plugin helps to show indentations in a code"
