# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

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

DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}"
FONT_SUFFIX="ttf"

src_unpack(){
	default_src_unpack
	# Removing spaces from directory name
	local dirname
	use dotted-zero && dirname="Meslo LG DZ v${PV}" || dirname="Meslo LG v${PV}"
	mv "${WORKDIR}/${dirname}" "${WORKDIR}/${dirname// /-}" || die
}

pkg_setup(){
	use dotted-zero && S="${WORKDIR}/Meslo-LG-DZ-v${PV}" || S="${WORKDIR}/Meslo-LG-v${PV}"
	FONT_S="${S}"
}
