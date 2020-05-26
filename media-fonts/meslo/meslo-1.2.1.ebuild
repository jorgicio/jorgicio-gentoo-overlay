# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Customized version of Apple's Menlo font."
HOMEPAGE="https://github.com/andreberg/Meslo-Font"
SRC_URI="
	dotted-zero? ( https://raw.githubusercontent.com/andreberg/Meslo-Font/master/dist/v${PV}/Meslo%20LG%20DZ%20v${PV}.zip -> ${P}-DZ.zip )
	!dotted-zero? ( https://raw.githubusercontent.com/andreberg/Meslo-Font/master/dist/v${PV}/Meslo%20LG%20v${PV}.zip -> ${P}.zip  )
"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="dotted-zero"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

BDEPEND="app-arch/unzip"
FONT_SUFFIX="ttf"

src_unpack(){
	default
	# Removing spaces from directory name
	local dirname
	use dotted-zero && dirname="Meslo LG DZ v${PV}" || dirname="Meslo LG v${PV}"
	mv "${WORKDIR}/${dirname}" "${WORKDIR}/${dirname// /-}" || die
}

pkg_setup(){
	use dotted-zero && S="${WORKDIR}/Meslo-LG-DZ-v${PV}" || S="${WORKDIR}/Meslo-LG-v${PV}"
	FONT_S="${S}"
}
