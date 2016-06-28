# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GH_URI='github/telegramdesktop/tdesktop'
GH_REF="v${PV}"

inherit flag-o-matic fdo-mime eutils qmake-utils git-hosting versionator

DESCRIPTION='Official cross-platorm desktop client for Telegram'
HOMEPAGE='https://desktop.telegram.org/'
LICENSE='GPL-3' # with OpenSSL exception

SLOT='0'

KEYWORDS='~amd64 ~arm ~x86'
IUSE='proxy'

CDEPEND=(
	'dev-libs/libappindicator:3'	# pspecific_linux.cpp
	'>=media-libs/openal-1.17.2'	# Telegram requires shiny new versions
	'sys-libs/zlib[minizip]'
	'virtual/ffmpeg[opus]'
)
RDEPEND=(
	'!net-im/telegram-bin'
	'!net-im/telegram-desktop'{,-bin}
)
DEPEND=( "${CDEPEND[@]}"
	">=dev-qt/qt-telegram-static-5.6.0_p20160510:5.6.0"	# 5.6.0 is required since 0.9.49
	'virtual/pkgconfig'
	'>=sys-apps/gawk-4.1'	# required for inplace support for .pro files formatter
)
DEPEND="${DEPEND[*]}"
RDEPEND="${RDEPEND[*]}"

RESTRICT+=' test'

PLOCALES=( de es it ko nl pt_BR )
inherit l10n

CHECKREQS_DISK_BUILD='1G'
inherit check-reqs

TG_DIR="${S}/Telegram"
TG_PRO="${TG_DIR}/Telegram.pro"

# override qt5 path for use with eqmake5
qt5_get_bindir() { echo "${QT5_PREFIX}/bin" ; }

src_prepare-locales() {
	local dir='Resources/langs' pre='lang_' post='.strings'
	l10n_find_plocales_changes "${dir}" "${pre}" "${post}"
	rm_loc() {
		rm -v -f "${dir}/${pre}${1}${post}" || die
		sed -e "\|${pre}${1}${post}|d" \
			-i -- "${TG_PRO}" 'Resources/telegram.qrc' || die
	}
	l10n_for_each_disabled_locale_do rm_loc
}

src_prepare-delete_and_modify() {
	local args

	## patch "${TG_PRO}"
	args=(
		# delete any references to local includes/libs
		-e 's|^(.*[^ ]*/usr/local/[^ \\]* *\\?)|# local includes/libs # \1|'
		# delete any hardcoded includes
		-e 's|^(.*INCLUDEPATH *\+= *"/usr.*)|# hardcoded includes # \1|'
		# delete any hardcoded libs
		-e 's|^(.*LIBS *\+= *-l.*)|# hardcoded libs # \1|'
		# delete refs to bundled Google Breakpad
		-e 's|^(.*breakpad/src.*)|# Google Breakpad # \1|'
		# delete refs to bundled minizip, Gentoo uses it's own patched version
		-e 's|^(.*minizip.*)|# minizip # \1|'
		# delete CUSTOM_API_ID defines, use default ID
		-e 's|^(.*CUSTOM_API_ID.*)|# CUSTOM_API_ID # \1|'
		# remove hardcoded flags
		-e 's|^(.*QMAKE_[A-Z]*FLAGS.*)|# hardcoded flags # \1|'
		# use release versions
		-e 's:(.*)Debug(Style|Lang)(.*):\1Release\2\3 # Debug -> Release Style/Lang:g'
		-e 's|(.*)/Debug(.*)|\1/Release\2 # Debug -> Release|g'
	)
	sed -r "${args[@]}" \
		-i -- "${TG_PRO}" || die

	## nuke libunity references
	args=(
		# ifs cannot be deleted, so replace them with 0
		-e 's|if *\( *_psUnityLauncherEntry *\)|if(0)|'
		# this is probably not needed, but anyway
		-e 's|noTryUnity *= *false,|noTryUnity = true,|'
		# delete various refs and includes
		-e 's:(.*(unity\.h|f_unity|ps_unity_|UnityLauncher).*):// \1:'
	)
	sed -r "${args[@]}" \
		-i -- 'SourceFiles/pspecific_linux.cpp' || die	
	PATCHES=( ${FILESDIR}/${P}_nounity.patch )
	epatch ${PATCHES[@]}

}

src_prepare-appends() {
	# make sure there is at least one empty line at the end before adding anything
	echo >> "${TG_PRO}"

	printf '%s\n\n' '# --- EBUILD APPENDS BELOW ---' >> "${TG_PRO}" || die

	## add corrected dependencies back
	local deps=( 'minizip' )
	local libs=( "${deps[@]}"
		'lib'{avcodec,avformat,avutil,swresample,swscale}
		'openal' 'openssl' 'zlib' )
	local includes=( "${deps[@]}" 'appindicator3-0.1' ) # TODO: dee-1.0

	my_do() {
		local x var="$1" flags="$2" transformer="$3" ; shift 3
		for x in "${@}" ; do
			printf '%s += ' "${var}" >>"${TG_PRO}" || die
			pkg-config "${flags}" "${x}" | tr '\n' ' ' | eval "${transformer}" >>"${TG_PRO}"
			assert
			echo " # ${x}" >>"${TG_PRO}" || die
		done
	}
	my_do INCLUDEPATH	--cflags-only-I	'sed "s|-I||g"'	"${includes[@]}"
	my_do LIBS			--libs			'cat'			"${libs[@]}"
}

src_prepare() {
	eapply_user

	cd "${TG_DIR}" || die

	rm -rf *.*proj*		|| die # delete Xcode/MSVS files
	rm -rf ThirdParty	|| die # prevent accidentically using something from there

	if [ -z "${QT_TELEGRAM_STATIC_SLOT}" ] ; then
		local qtstatic='dev-qt/qt-telegram-static'
		local qtstatic_PVR="$(best_version "${qtstatic}" | sed "s|.*${qtstatic}-||")"
		local qtstatic_PV="${qtstatic_PVR%%-*}" # strip revision
		declare -g QT_VER="${qtstatic_PV%%_p*}" QT_PATCH_DATE="${qtstatic_PV##*_p}"
		declare -g QT_TELEGRAM_STATIC_SLOT="${QT_VER}/${QT_PATCH_DATE}"
	else
		einfo "Using QT_TELEGRAM_STATIC_SLOT from environment - '${QT_TELEGRAM_STATIC_SLOT}'"
		declare -g QT_VER="${QT_TELEGRAM_STATIC_SLOT%%/*}" QT_PATCH_DATE="${QT_TELEGRAM_STATIC_SLOT##*/}"
	fi

	echo
	einfo "${P} is going to be linked against 'Qt ${QT_VER} (p${QT_PATCH_DATE})'"
	echo

	if [[ $(get_version_component_range 2 ${QT_VER}) < 6 ]] ; then
		ewarn "You've requested to link against Qt < 5.6.0, this will likely won't work"
	fi

	declare -g QT5_PREFIX="${EPREFIX}/opt/qt-telegram-static/${QT_TELEGRAM_STATIC_SLOT}"
	[ -d "${QT5_PREFIX}" ] || die "QT5_PREFIX dir doesn't exist: '${QT5_PREFIX}'"

	readonly QT_TELEGRAM_STATIC_SLOT QT_VER  QT_PATCH_DATE

	# This formatter converts multiline var defines to multiple lines.
	# Such .pro files are then easier to debug and modify in src_prepare-delete_and_modify().
	gawk -f "${FILESDIR}/format_pro.awk" -i inplace -- *.pro || die

	src_prepare-locales
	src_prepare-delete_and_modify
	src_prepare-appends
}

src_configure() {
	## add flags previously stripped from "${TG_PRO}"
	append-cxxflags '-fno-strict-aliasing' -std=c++14
	# `append-ldflags '-rdynamic'` was stripped because it's used probably only for GoogleBreakpad
	# which is not supported anyway

	# care a little less about the unholy mess
	append-cxxflags '-Wno-unused-'{function,parameter,variable,but-set-variable}
	append-cxxflags '-Wno-switch'

	# prefer patched qt
	export PATH="$(qt5_get_bindir):${PATH}"

	(	# disable updater
		echo 'DEFINES += TDESKTOP_DISABLE_AUTOUPDATE'

		# disable registering `tg://` scheme from within the app
		echo 'DEFINES += TDESKTOP_DISABLE_REGISTER_CUSTOM_SCHEME'

		# https://github.com/telegramdesktop/tdesktop/commit/0b2bcbc3e93a7fe62889abc66cc5726313170be7
		$(usex proxy 'DEFINES += TDESKTOP_DISABLE_NETWORK_PROXY' '')

		# disable google-breakpad support
		echo 'DEFINES += TDESKTOP_DISABLE_CRASH_REPORTS'

		# disable desktop file generation
		echo 'DEFINES += TDESKTOP_DISABLE_DESKTOP_FILE_GENERATION'
	) >>"${TG_PRO}" || die
}

my_eqmake5() {
	local args=(
		CONFIG+='release'
		QT_TDESKTOP_VERSION="${QT_VER}"
		QT_TDESKTOP_PATH="${QT5_PREFIX}"
	)
	eqmake5 "${args[@]}" "$@"
}

src_compile() {
	local d module

	for module in style numbers ; do	# order of modules matters
		d="${S}/Linux/obj/codegen_${module}/Release"
		mkdir -v -p "${d}" && cd "${d}" || die

		elog "Building: ${PWD/${S}\/}"
		my_eqmake5 "${TG_DIR}/build/qmake/codegen_${module}/codegen_${module}.pro"
		emake
	done

	for module in Lang ; do		# order of modules matters
		d="${S}/Linux/ReleaseIntermediate${module}"
		mkdir -v -p "${d}" && cd "${d}" || die

		elog "Building: ${PWD/${S}\/}"
		my_eqmake5 "${TG_DIR}/Meta${module}.pro"
		emake
	done

	d="${S}/Linux/ReleaseIntermediate"
	mkdir -v -p "${d}" && cd "${d}" || die

	elog "Preparing the main build ..."
	# this qmake will fail to find "${TG_DIR}/GeneratedFiles/*", but it's required for ...
	my_eqmake5 "${TG_PRO}"
	# ... this make, which will generate those files
	local targets=( $( awk '/^PRE_TARGETDEPS *\+=/ { $1=$2=""; print }' "${TG_PRO}" ) )
	[ ${#targets[@]} -eq 0 ] && die
	emake ${targets[@]}

	# now we have everything we need, so let's begin!
	elog "Building Telegram ..."
	my_eqmake5 "${TG_PRO}"
	emake
}

src_install() {
	newbin "${S}/Linux/Release/Telegram" "${PN}"

	local s
	for s in 16 32 48 64 128 256 512 ; do
		newicon -s ${s} "${TG_DIR}/Resources/art/icon${s}.png" "${PN}.png"
	done

	local make_desktop_entry_args
	make_desktop_entry_args=(
		"${EPREFIX}/usr/bin/${PN} %u"	# exec
		"${PN^}"	# name
		"${PN}"		# icon
		'Network;InstantMessaging;Chat'	# categories
	)
	make_desktop_entry_extras=(
		'MimeType=x-scheme-handler/tg;'
	)
	make_desktop_entry "${make_desktop_entry_args[@]}" \
		"$( printf '%s\n' "${make_desktop_entry_extras[@]}" )"

	einstalldocs
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}
