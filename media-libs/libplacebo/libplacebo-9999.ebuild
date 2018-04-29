# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/haasn/libplacebo"
	inherit git-r3
else
	KEYWORDS="~amd64 ~arm ~arm64"
	SRC_URI="https://github.com/haasn/libplacebo/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

inherit meson multilib-minimal

DESCRIPTION="Reusable library for GPU-accelerated image processing primitives"
HOMEPAGE="https://github.com/haasn/libplacebo"

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE="shaderc vulkan test bench"

RDEPEND="shaderc? ( dev-util/shaderc[${MULTILIB_USEDEP}] )
	vulkan? ( media-libs/vulkan-loader[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}"

#DOCS="README.md"

multilib_src_configure() {
	local emesonargs=(
		$(meson_use shaderc)
		$(meson_use vulkan)
		$(meson_use test tests)
		$(meson_use bench)
	)
	meson_src_configure
}

multilib_src_compile() {
	meson_src_compile
}

multilib_src_install() {
	meson_src_install
}
