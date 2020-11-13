# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils xdg

DESCRIPTION="Cisco's packet tracer"
HOMEPAGE="https://www.netacad.com/about-networking-academy/packet-tracer"
SRC_URI="
	amd64? ( "${P}-amd64.tar.gz" )
"

LICENSE="Cisco"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libressl"
RESTRICT="fetch mirror strip"

DEPEND="
	app-arch/gzip
	dev-util/patchelf"
RDEPEND="${DEPEND}
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-libs/icu
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	media-libs/libpng-compat:1.2
"
S="${WORKDIR}"
QA_PREBUILT="opt/packettracer/*"

pkg_nofetch(){
	ewarn "To fetch sources, you need a Cisco account which is"
	ewarn "available if you're a web-learning student, instructor"
	ewarn "or you sale Cisco hardware, etc."
	ewarn "after that, go to https://www.netacad.com and login with"
	ewarn "your account, and after that, you should download a file"
	ewarn "named \"Packet Tracer ${PV} for Linux 64bit.tar.gz\""
	ewarn "then, rename it to \"${P}-amd64.tar.gz\" and move it to"
	ewarn "your DISTDIR directory (default: /usr/portage/distfiles)"
	ewarn "and then, you can proceed with the installation."
	ewarn "Renaming is necessary due to space naming conflicts."
}

src_prepare(){
	sed -i -e "s#/opt/pt#/opt/${PN}#" bin/Cisco-PacketTracer.desktop
	sed -i -e "s#Application;Network#Network#" bin/Cisco-PacketTracer.desktop
	default
}

src_install(){
	exeinto /opt/${PN}/bin
	doexe bin/linguist bin/meta bin/PacketTracer7
	rm bin/linguist bin/meta bin/PacketTracer7
	exeinto /opt/${PN}/bin/Linux
	doexe bin/Linux/*
	rm -r bin/Linux
	insinto /usr/share/mime/packages
	doins bin/Cisco-*.xml
	rm bin/Cisco-*.xml
	domenu bin/Cisco-PacketTracer.desktop
	rm bin/Cisco-PacketTracer.desktop
	insinto /opt/${PN}
	doins -r art backgrounds bin extensions help languages saves Sounds templates
	for icon in pka pkt pkz; do
		newicon -s 48x48 -c mimetypes art/${icon}.png application-x-${icon}.png
	done
	dodoc eula${PV//./}.txt
	dobin "${FILESDIR}/${PN}"
	exeinto /opt/${PN}
	doexe "${FILESDIR}/linguist"
	insinto /etc/profile.d
	doins "${FILESDIR}/${PN}.sh"
	#find "${ED%/}/opt/${PN}/bin" -iname "*.so*" -exec patchelf --set-rpath '$ORIGIN/' {} \;
	for b in PacketTracer7 meta linguist; do
		#patchelf --set-rpath '$ORIGIN/' "${ED%/}/opt/${PN}/bin/${b}"
		pax-mark -m "${ED%/}/opt/${PN}/bin/${b}"
	done
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/NetacadExamPlayer"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/QtWebEngineProcess"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/locallauncher.bat"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/locallauncher.sh"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/ptplayer-DEVELOPMENT-1.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/ptplayer-DEVELOPMENT-2.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/ptplayer-DEVELOPMENT-3.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/ptplayer-DEVELOPMENT-4.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/ptplayer-DEVELOPMENT-5.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/ptplayer-DEVELOPMENT-6.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/ptplayer-DEVELOPMENT-7.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/bin/ControlPanel"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/bin/java"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/bin/javaws"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/bin/jcontrol"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/bin/jjs"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/bin/keytool"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/bin/orbd"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/bin/pack200"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/bin/policytool"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/bin/rmid"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/bin/rmiregistry"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/bin/servertool"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/bin/tnameserv"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/bin/unpack200"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/charsets.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/deploy.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/javaws.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/jce.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/jfr.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/jfxswt.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/jsse.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/management-agent.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/plugin.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/resources.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/rt.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/ext/cldrdata.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/ext/dnsns.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/ext/jaccess.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/ext/jfxrt.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/ext/localedata.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/ext/nashorn.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/ext/sunec.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/ext/sunjce_provider.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/ext/sunpkcs11.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/ext/zipfs.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/jexec"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/ptaplayer/ptaplayer-12.009.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/security/policy/limited/local_policy.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/security/policy/limited/US_export_policy.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/security/policy/unlimited/local_policy.jar"
	fperms +x "${EPREFIX}/opt/${PN}/extensions/NetacadExamPlayer/ptplayer/java/lib/security/policy/unlimited/US_export_policy.jar"
}
