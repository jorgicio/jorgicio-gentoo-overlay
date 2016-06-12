# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5} )

inherit distutils-r1 versionator ${GIT_ECLASS}

DESCRIPTION="A cli-based client to watch football soccer statistics"
HOMEPAGE="https://github.com/architv/soccer-cli"

if [[ ${PV} == *9999* ]];then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	RELEASE="$(get_version_component_range 1-3)"
	SRC_URI="${HOMEPAGE}/releases/download/${RELEASE}/${P}.tar.gz"
	KEYWORDS="x86 amd64"
	RESTRICT="mirror"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPEND}"
RDEPEND="${DEPEND}"

pkg_postinst(){
	einfo "To use this package, first you must create an API key (for free)"
	einfo "from http://api.football-data.org/register, then you must add it"
	einfo "to your ~/.bashrc or ~/.zshrc to set it:"
	einfo "export SOCCER_CLI_API_TOKEN=\"<YOUR_API_TOKEN>\""
}
