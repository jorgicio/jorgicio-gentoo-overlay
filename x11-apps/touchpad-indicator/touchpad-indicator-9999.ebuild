# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-any-r1 systemd xdg

DESCRIPTION="A simple indicator for controlling a synaptics touchpad"
HOMEPAGE="https://github.com/atareao/Touchpad-Indicator"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	COMMIT="8fc5078da2200caccd599d48fe8a13ccb286df6c"
	SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/Touchpad-Indicator-${COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="systemd"

DEPEND="
	gnome-base/librsvg
	dev-libs/libappindicator:3
	$(python_gen_any_dep 'dev-python/dbus-python[${PYTHON_USEDEP}]' )
	$(python_gen_any_dep 'dev-python/python-evdev[${PYTHON_USEDEP}]' )
	$(python_gen_any_dep 'dev-python/python-xlib[${PYTHON_USEDEP}]' )
	$(python_gen_any_dep 'dev-python/pyudev[${PYTHON_USEDEP}]' )
	sys-apps/lsb-release
	x11-apps/xinput
	x11-libs/libnotify
	x11-libs/gdk-pixbuf
	systemd? ( sys-apps/systemd )"

RDEPEND="${DEPEND}"

BDEPEND="sys-devel/gettext"

src_prepare(){
	find . -type f -exec \
		sed -i -e 's:locale-langpack:locale:g' '{}' \;
	# Create a script to install the translations from the debian rules file
	echo "#!/bin/bash" > make_translations.sh
	grep -A 1000 "Create languages directories" debian/rules | \
		grep -B 1000 "End comile languages" | \
		sed "s:\${CURDIR}/debian/touchpad-indicator:\"${ED%/}\":g" >> make_translations.sh
	chmod +x make_translations.sh
	use !systemd && sed -i -e "/systemd/d" debian/install
	default
}

src_install() {
	while read _in _out; do
		mkdir -p "${ED%/}/${_out}"
		cp -r ${_in} "${ED%/}/${_out}" || die
	done < debian/install
	chmod 755 "${ED%/}"/usr/bin/${PN} || die
	chmod -R 755 \
		"${ED%/}"/{usr/share/${PN},etc/pm/sleep.d} || die
	use systemd && chmod -R 755 "${ED%/}"/usr/lib/systemd/system-sleep
	./make_translations.sh || die
}
