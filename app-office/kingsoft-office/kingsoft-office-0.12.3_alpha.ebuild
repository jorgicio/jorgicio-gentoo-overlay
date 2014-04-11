# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

FN="kingsoft-office_9.1.0.4244~a12p3_x86"

DESCRIPTION="Kingstone Office Suite for Linux"
HOMEPAGE="http://wps-community.org"
SRC_URI="http://37.247.55.101/a12p3/${FN}.tar.xz"

LICENSE=""
SLOT="alpha"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="media-fonts/symbolfonts"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${FN}"

src_install() {
	local dir="/opt/kingsoft-office-${SLOT}"
	local wps_exe="wps"
	local wpp_exe="wpp"
	local et_exe="et"
	
	insinto "${dir}"
	doins -r *

	fperms 755 "${dir}/wps_error_check.sh" "${dir}/install_fonts"
	fperms 755 "${dir}/${wps_exe}" "${dir}/office6/${wps_exe}" 
	fperms 755 "${dir}/${wpp_exe}" "${dir}/office6/${wpp_exe}"
	fperms 755 "${dir}/${et_exe}" "${dir}/office6/${et_exe}"

	insinto "/usr/share/fonts/kingsoft-office/"
	doins -r fonts/*

	make_desktop_entry "${dir}/${wps_exe} %f" "Kingsoft Writer" "" "Office"
	make_desktop_entry "${dir}/${wpp_exe} %f" "Kingsoft Presentation" "" "Office"
	make_desktop_entry "${dir}/${et_exe} %f" "Kingsoft Spreadsheets" "" "Office"
}
