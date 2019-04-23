# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
inherit cmake-utils

DESCRIPTION="lightdm-qt5-greeter is a simple frontend for the lightdm displaymanager"
HOMEPAGE="https://github.com/surlykke/qt-lightdm-greeter"
SRC_URI="https://gitlab.com/Butthurt/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"

RDEPEND="dev-qt/qtwidgets:5
	x11-misc/lightdm[qt5]"

DEPEND="${RDEPEND}"

pkg_postinst() {
	elog	"Update or insert in(to) your /etc/lightdm/lightdm.conf, in the SeatDefaults section, this line:"
	elog	"greeter-session=lightdm-qt5-greeter"
	elog	"The file /etc/lightdm/lightdm-qt5-greeter.conf allows for a few configurations of lightdm-qt5-greeter"
	elog	"(background-image, positioning of loginform). The configuration options are documented in that file."
}