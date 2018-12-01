# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: patches.eclass
# @MAINTAINER:
# mva
# @AUTHOR:
# mva
# @BLURB:
# @DESCRIPTION:
# Eclass that checks for patches directories existance and auto-add them into PATCHES=()

EXPORT_FUNCTIONS src_prepare

PATCHDIR="${FILESDIR}/patches/${PV}"
[[ -z ${PATCHES[@]} ]] && PATCHES=()

patches_src_prepare() {
	if [[ -d "${PATCHDIR}" ]]; then
		_patchdir_not_empty() {
			local has_files
			local LC_ALL=POSIX
			local prev_shopt=$(shopt -p nullglob)
			shopt -s nullglob
			local f
			for f in "${1:-${PATCHDIR}}"/*; do
				if [[ "${f}" == *.diff || "${f}" == *.patch ]] && [[ -f "${f}" || -L "${f}" ]]; then
					has_files=1
				elif [[ -d "${f}" ]]; then
					# recursion
					_patchdir_not_empty "${f}" && has_files=1
				fi
			done
			${prev_shopt}
			[[ -n "${has_files}" ]]; return $?
		}

		_patchdir_not_empty && PATCHES+=("${PATCHDIR}")

		if [[ -d "${PATCHDIR}/conditional" ]]; then
			pushd "${PATCHDIR}/conditional" &>/dev/null
			for d in *; do
				if [[ -d ${d} ]]; then
					if [[ "${d##no-}" == ${d} ]]; then
						(use "${d}" && _patchdir_not_empty "${d}") && PATCHES+=("${PATCHDIR}/conditional/${d}")
					else
						(use "${d##no-}" && _patchdir_not_empty "${d}") || PATCHES+=("${PATCHDIR}/conditional/${d}")
					fi
				fi
			done
			popd &>/dev/null
		fi
	fi
	if declare -f cmake-utils_src_prepare &>/dev/null; then
		# cmake-utils_src_prepare support (to decrease kludges in the ebuilds)
		cmake-utils_src_prepare
	else
		default_src_prepare
	fi
}
