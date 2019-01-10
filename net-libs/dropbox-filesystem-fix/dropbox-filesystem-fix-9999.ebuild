# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit git-r3 python-r1

DESCRIPTION="Fix the filesystem detection in the linux Dropbox client for non-ext4 partitions"
HOMEPAGE="https://github.com/dark/dropbox-filesystem-fix"
SRC_URI=""
EGIT_REPO_URI="https://github.com/dark/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-misc/dropbox-62.0.0"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}"

src_install(){
	local DB_INSTALL_DIR="/usr/$(get_libdir)/${PN}"
	exeinto "${DB_INSTALL_DIR}"
	doexe dropbox_start.py
	doexe libdropbox_fs_fix.so
}

pkg_postinst(){
	echo
	einfo "In order to run Dropbox with this library, run the"
	echo "/usr/$(get_libdir)/${PN}/dropbox_start.py script, or"
	echo "set the LD_PRELOAD variable to the libdropbox_fs_fix.so path"
	echo "and then, run 'dropbox start'. i.e."
	echo "LD_PRELOAD=/usr/$(get_libdir)/${PN}/libdropbox_fs_fix.so dropbox start"
	echo "You could also create a script to do that."
	echo
}
