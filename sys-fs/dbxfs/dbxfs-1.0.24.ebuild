# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="User-space filesystem for Dropbox"
HOMEPAGE="https://github.com/rianhunter/dbxfs"
if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~amd64-linux ~arm ~arm-linux ~arm64 ~arm64-linux ~x86 ~x86-linux"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="kernel_linux"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/block_tracing[${PYTHON_USEDEP}]
	dev-python/dropbox-sdk-python[${PYTHON_USEDEP}]
	>=dev-python/keyring-15.1.0[${PYTHON_USEDEP}]
	<dev-python/keyring-16.0.0[${PYTHON_USEDEP}]
	dev-python/privy[${PYTHON_USEDEP}]
	dev-python/sentry-sdk[${PYTHON_USEDEP}]
	dev-python/userspacefs[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	kernel_linux? ( sys-fs/fuse:0 )
"
BDEPEND="${PYTHON_DEPS}"

PATCHES=( "${FILESDIR}/python-${PN}.patch" )

pkg_postinst(){
	echo
	einfo "In order to use the dbxfs system file, you need"
	einfo "first to generate a token access when running the"
	einfo "dbxfs command for the first time."
	einfo "Then, you create a mount point to mount your dropbox"
	einfo "folder in your local file system."
	echo
}
