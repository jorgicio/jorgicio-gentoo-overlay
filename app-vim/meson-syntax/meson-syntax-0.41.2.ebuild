# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: Meson configuration syntax"
HOMEPAGE="http://mesonbuild.com"
LICENSE="Apache-2.0"
if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/mesonbuild/meson"
	KEYWORDS=""
else
	SRC_URI="https://github.com/mesonbuild/meson/releases/download/${PV}/meson-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

S="${WORKDIR}/meson-${PV}/syntax-highlighting/vim"
