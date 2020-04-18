# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

COMMIT="6191622d5806d4448fa2285047936bdcee57a098"

DESCRIPTION="vim plugin: Base16 schemes for Vim"
HOMEPAGE="https://github.com/chriskempson/base16-vim"
LICENSE="vim vim.org public-domain MIT"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE=""
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

VIM_PLUGIN_HELPTEXT="The base16 colorscheme collection has schemes using 16 colors."

S="${WORKDIR}/${PN}-${COMMIT}"
