# Copyright 1999-2015 Gentoo Foundation
# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: l10n.eclass
# @MAINTAINER:
#   Jan Chren <dev.rindeal+gentoo@gmail.com>
# @BLURB: convenience functions to handle localizations
# @DESCRIPTION:
# The l10n (localization) eclass offers a number of functions to more
# conveniently handle localizations (translations) offered by packages.
# These are meant to prevent code duplication for such boring tasks as
# determining the cross-section between the user's set LINGUAS and what
# is offered by the package; and generating the right list of linguas_*
# USE flags.

if [ -z "${_L10N_ECLASS}" ] ; then

case "${EAPI:-0}" in
	5|6) ;;
	*) die "Unsupported EAPI='${EAPI}' (unknown) for '${ECLASS}'" ;;
esac

# @ECLASS-VARIABLE: PLOCALES
# @DEFAULT_UNSET
# @DESCRIPTION:
# Variable listing the locales for which localizations are offered by
# the package. Check profiles/desc/linguas.desc to see if the locales
# are listed there. Add any missing ones there.
#
# Example: PLOCALES=( cy de el_GR en_US pt_BR vi zh_CN )
declare -g -a _PLOCALES
if [[ "$(declare -p PLOCALES)" == 'declare -a'* ]] ; then
	_PLOCALES=( "${PLOCALES[@]}" )
else
	eqawarn "Declaring PLOCALES as a variable is deprecated. Please use an array instead."
	_PLOCALES=( ${PLOCALES} )
fi

# Add linguas useflags
IUSE+=" ${_PLOCALES[@]/#/linguas_}"

# @ECLASS-VARIABLE: PLOCALE_BACKUP
# @DEFAULT_UNSET
# @DESCRIPTION:
# In some cases the package fails when none of the offered PLOCALES are
# selected by the user. In that case this variable should be set to a
# default locale (usually 'en' or 'en_US') as backup.
#
# Example: PLOCALE_BACKUP='en_US'

# @ECLASS-VARIABLE: PLOCALES_MAP
# @DEFAULT: Default PLOCALES_MAP has values same as keys
# @DESCRIPTION:
#
# Example:
# @CODE
# PLOCALES_MAP+=( ['en']='eng' ['de']='ger german' )
# @CODE
[ -v PLOCALES_MAP ] || declare -g -A PLOCALES_MAP
for _l10n_l in "${_PLOCALES[@]}" ; do
	# overwrite only if not already set
	[ -z "${PLOCALES_MAP["${_l10n_l}"]}" ] && \
		PLOCALES_MAP+=( ["${_l10n_l}"]="${_l10n_l}" )
done
unset _l10n_l

# @ECLASS-VARIABLE: PLOCALES_MASK
# @DEFAULT_UNSET
# @DESCRIPTION:
# Array of locales which will be ignored
declare -g -A _PLOCALES_MASK=()
for _l10n_l in "${PLOCALES_MASK[@]}" ; do
	_PLOCALES_MASK+=( ["${_l10n_l}"]= )
done
unset _l10n_l


# @FUNCTION: l10n_get_locales
# @USAGE: [disabled]
# @DESCRIPTION:
# Determine which LINGUAS USE flags the user has enabled that are offered
# by the package, as listed in PLOCALES, and return them. In case no locales
# are selected, fall back on PLOCALE_BACKUP. When the disabled argument is
# given, return the disabled useflags instead of the enabled ones.
l10n_get_locales() {
	local flag="${1}"

	if [ ! -v _l10n_on_locs ] ; then
		declare -g _l10n_on_locs= _l10n_off_locs=
		local l on_locs=() off_locs=()

		for l in "${_PLOCALES[@]}" ; do
			if use "linguas_${l}" ; then
				on_locs+=( "${l}" )
			else
				off_locs+=( "${l}" )
			fi
		done

		# cache the results in global variables
		_l10n_on_locs="${on_locs[*]}"
		_l10n_off_locs="${off_locs[*]}"
	fi

	local locs
	if [ "${flag}" = 'disabled' ] ; then
		locs="${_l10n_off_locs}"
	else
		locs="${_l10n_on_locs:-"${PLOCALE_BACKUP}"}"
	fi

	echo "${locs}"
}

_l10n_for_each_locale_do() {
	local l ll
	for l in "${_locales[@]}" ; do
		for ll in ${PLOCALES_MAP["${l}"]} ; do
			"${@}" ${ll}
		done
	done
}

# @FUNCTION: l10n_for_each_locale_do
# @USAGE: <function>
# @DESCRIPTION:
# Convenience function for processing localizations. The parameter should
# be a function (defined in the consuming eclass or ebuild) which takes
# an individual localization as (last) parameter.
#
# Example: l10n_for_each_locale_do install_locale
l10n_for_each_locale_do() {
	local _locales=( $(l10n_get_locales) )
	_l10n_for_each_locale_do "$@"
}

# @FUNCTION: l10n_for_each_disabled_locale_do
# @USAGE: <function>
# @DESCRIPTION:
# Complementary to l10n_for_each_locale_do, this function will process
# locales that are disabled. This could be used for example to remove
# locales from a Makefile, to prevent them from being built needlessly.
l10n_for_each_disabled_locale_do() {
	local _locales=( $(l10n_get_locales disabled) )
	_l10n_for_each_locale_do "$@"
}

# @FUNCTION: l10n_find_plocales_changes
# @USAGE: <translations dir> <filename pre pattern> <filename post pattern>
# @DESCRIPTION:
# Ebuild maintenance helper function to find changes in package offered
# locales when doing a version bump. This could be added for example to
# src_prepare
#
# Example: l10n_find_plocales_changes "${S}/src/translations" "${PN}_" '.ts'
l10n_find_plocales_changes() {
	debug-print-function ${FUNCNAME} "$@"
	[[ ${#} != 3 ]] && die "Exactly 3 arguments are needed!"
	local l dir="${1}" pre="${2}" post="${3}"

	# using assoc array to allow instant lookup
	declare -A found known

	einfo "Looking in '${dir}' for changes in locales ..."
	pushd "${dir}" >/dev/null || die "Cannot access '${dir}'"
	for l in "${pre}"*"${post}" ; do
		l="${l#"${pre}"}"
		l="${l%"${post}"}"
		[ -v _PLOCALES_MASK["${l}"] ] && continue
		found+=( ["${l}"]= )
	done
	popd >/dev/null || die

	_l10n_add_to_known(){ known+=( ["${1}"]= ); }
	local _locales=( "${_PLOCALES[@]}" )
	_l10n_for_each_locale_do _l10n_add_to_known
	unset -f _l10n_add_to_known

	local added=() removed=()
	for l in "${!known[@]}" ; do
		[[ -v found["${l}"] ]] || removed+=( "${l}" )
	done
	for l in "${!found[@]}" ; do
		[[ -v known["${l}"] ]] || added+=( "${l}" )
	done

	if [[ $(( ${#added[@]} + ${#removed[@]} )) > 0 ]] ; then
		einfo "There are changes in locales!"
		if [[ ${#added[@]} > 0 ]] ; then
			einfo "Locales added: '${added[*]}'"
		fi
		if [[ ${#removed[@]} > 0 ]] ; then
			einfo "Locales removed: '${removed[*]}'"
		fi
	else
		einfo "No changes found"
	fi
}

_L10N_ECLASS=1
fi
