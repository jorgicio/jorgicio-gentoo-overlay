# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="YouTube addon for Kodi"
HOMEPAGE="https://github.com/jdf76/plugin.video.youtube"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/releases/download/${PV}/plugin.video.youtube-${PV}.zip"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/plugin.video.youtube"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="media-tv/kodi"
DEPEND="${RDEPEND}"

src_install() {
	kodi_home="/usr/$(get_libdir)/kodi/addons/plugin.video.youtube"
	insinto ${kodi_home}
	doins -r .
}
