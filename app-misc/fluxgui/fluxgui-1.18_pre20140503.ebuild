# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="f.lux indicator applet is an indicator applet to control xflux, an application that makes the color of your computer’s display adapt to the time of day, warm at nights and like sunlight during the day"
HOMEPAGE="http://justgetflux.com/ https://github.com/Kilian/f.lux-indicator-applet"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

EGIT_REPO_URI="https://github.com/Kilian/f.lux-indicator-applet.git"
EGIT_COMMIT="7fc8de35afd829ad1c8e477b7b8bc8c014ffa041"

DEPEND=""
RDEPEND="${DEPEND}
  dev-python/pexpect
  dev-libs/libappindicator:2
  dev-python/gconf-python
"

python_install(){
	distutils-r1_python_install
}
