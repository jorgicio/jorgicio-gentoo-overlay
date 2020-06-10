# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils java-utils-2

DESCRIPTION="Application Menu Module for Java Swing applications"
HOMEPAGE="https://gitlab.com/vala-panel-project/vala-panel-appmenu"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	KEYWORDS=""
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	S="${WORKDIR}/${P}/subprojects/${PN}"
else
	MY_PN="vala-panel-appmenu"
	MY_P="${MY_PN}-${PV}"
	SRC_URI="${HOMEPAGE}/uploads/-archive/${PV}/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}/subprojects/${PN}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+system-wide"

DEPEND="
	>=dev-libs/glib-2.40.0
	>=dev-libs/libdbusmenu-16.04.0
	>=x11-libs/libxkbcommon-0.5.0"

RDEPEND="${DEPEND}
	>=virtual/jre-1.8"

BDEPEND="
	>=virtual/jdk-1.8
	virtual/pkgconfig"

src_prepare() {
	sed -i -e "/JAVADIR/{s/java/${PN}\/lib/}" \
		lib/config.h.in
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_JAYATANA=ON
		-DSTANDALONE=OFF
		-DJAVA_HOME=$(java-config --jdk-home)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	rm -rf "${ED%/}"/usr/share/java || die
	java-pkg_dojar "${BUILD_DIR}"/java/${PN}.jar "${BUILD_DIR}"/java/${PN}ag.jar

	if use system-wide; then
		exeinto /etc/X11/xinit/xinitrc.d
		doexe "${FILESDIR}/90-${PN}"
		sed -i -e "s:JAVA_AGENT:${JAVA_PKG_JARDEST}/${PN}ag.jar:g" \
			"${ED%/}"/etc/X11/xinit/xinitrc.d/90-${PN}
	fi
}

pkg_postinst() {
	if ! use system-wide; then
		einfo
		elog "Enabling Jayatana"
		einfo
		elog "1. System-wide way (recommended only if you have many Java programs with menus):"
		einfo
		elog "   Set 'system-wide' USE flag."
		einfo
		elog "2. Application-specific ways (useful if you usually have one or 2 Java programs, like Android Studio) and if above does not work."
		einfo
		elog "2.1. Intellij programs (Idea, PhpStorm, CLion, Android Studio)"
		einfo
		elog "   Edit *.vmoptions file, and add -javaagent:${JAVA_PKG_JARDEST}/${PN}ag.jar to the end of file."
		elog "   Edit *.properties file, and add linux.native.menu=true to the end of it."
		einfo
		elog "2.2. Netbeans"
		einfo
		elog "   Edit netbeans.conf, and add -J-javaagent:${JAVA_PKG_JARDEST}/${PN}ag.jar to the end of it."
		einfo
		elog "3. Enable agent via desktop file (for any single application)"
		einfo
		elog "   Add -javaagent:${JAVA_PKG_JARDEST}/${PN}ag.jar after Exec or TryExec line of application's desktop file (if application executes JAR directly). If application executes JAR via wrapper, and this option to the end of JVM options for running actual JAR."
		einfo
	fi
}
