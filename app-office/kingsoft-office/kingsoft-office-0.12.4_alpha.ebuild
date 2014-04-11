# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

FN="kingsoft-office_9.1.0.4280~a12p4_x86"

DESCRIPTION="Kingstone Office Suite for Linux"
HOMEPAGE="http://wps-community.org"
SRC_URI="http://37.247.55.101/a12p4/${FN}.tar.xz"

LICENSE=""
SLOT="alpha"
KEYWORDS="~x86 ~amd64"
IUSE=""

# TODO: Include list of needed libraries
DEPEND="media-fonts/symbolfonts"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${FN}"

dir="/opt/kingsoft-office-${SLOT}"
wps_exe="wps"
wpp_exe="wpp"
et_exe="et"

QA_PREBUILT="${dir}/office6/*.so*
${dir}/office6/${wps_exe}
${dir}/office6/${wpp_exe}
${dir}/office6/${et_exe}"

src_install() {
	insinto "${dir}"
	doins -r *

	fperms 755 "${dir}/wps_error_check.sh" "${dir}/install_fonts"
	fperms 755 "${dir}/${wps_exe}" "${dir}/office6/${wps_exe}" 
	fperms 755 "${dir}/${wpp_exe}" "${dir}/office6/${wpp_exe}"
	fperms 755 "${dir}/${et_exe}" "${dir}/office6/${et_exe}"

	make_wrapper "${wps_exe}" "${dir}/${wps_exe}"
	make_wrapper "${wpp_exe}" "${dir}/${wpp_exe}"
	make_wrapper "${et_exe}" "${dir}/${et_exe}"

	insinto "/usr/share/fonts/kingsoft-office/"
	doins -r fonts/*

	insinto "/usr/share/applications/"
	doins resource/applications/*

	insinto "/usr/share/icons/"
	doins -r resource/icons/*

	insinto "/usr/share/mime/"
	doins -r resource/mime/*

}
