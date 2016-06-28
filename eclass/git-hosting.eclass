# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: git-hosting.eclass
# @MAINTAINER:
# Jan Chren (rindeal) <dev.rindeal+gentoo@gmail.com>
# @BLURB: Support eclass for packages hosted on online git hosting services like Github

if [ -z "${_GH_ECLASS}" ] ; then

case "${EAPI:-0}" in
	5|6) ;;
	*) die "Unsupported EAPI='${EAPI}' for '${ECLASS}'" ;;
esac


# @ECLASS-VARIABLE: GH_URI
# @DESCRIPTION:
# String in the format:
#
#      <provider>[/<user_name>[/<repository_name>]]
#
# Default <user_name> and <repository_name> is ${PN}
[ -z "${GH_URI}" ] && die "GH_URI must be set"
_GH_URI_A=( ${GH_URI//\// } )
_GH_PROVIDER="${_GH_URI_A[0]}"
_GH_USER="${_GH_URI_A[1]:-"${PN}"}"
_GH_REPO="${_GH_URI_A[2]:-"${PN}"}"
unset _GH_URI_A

# @ECLASS-VARIABLE: GH_FETCH_TYPE
# @DESCRIPTION:
# Defines if fetched from git ("live") or archive ("snapshot")
if [ -z "${GH_FETCH_TYPE}" ] ; then
	if [[ "${PV}" == *9999* ]] ; then
		GH_FETCH_TYPE='live'
	else
		GH_FETCH_TYPE='snapshot'
	fi
fi

# @ECLASS-VARIABLE: GH_REF
# @DEFAULT: ${PV}
# @DESCRIPTION:
# Tag/commit/git_ref (except branches) that is fetched from Github.
if [ -z "${GH_REF}" ] ; then
	case "${GH_FETCH_TYPE}" in
		'live')
			GH_REF="master" ;;
		'snapshot')
			# a research conducted on April 2016 among the first 700 repos with >10000 stars shows:
			# - no tags: 158
			# - `v` prefix: 350
			# - no prefix: 192
			GH_REF="${PV}" ;;
		*) die "Unsupported fetch type: '${GH_FETCH_TYPE}'" ;;
	esac
fi


case "${_GH_PROVIDER}" in
	'bitbucket')
		_GH_DOMAIN='bitbucket.org' ;;
	'github')
		_GH_DOMAIN='github.com' ;;
	'gitlab')
		_GH_DOMAIN='gitlab.com' ;;
	*) die "Unsupported provider '${_GH_PROVIDER}'" ;;
esac

_GH_BASE_URI="https://${_GH_DOMAIN}/${_GH_USER}/${_GH_REPO}"

if [ -z "${SRC_URI}" ] && [ "${GH_FETCH_TYPE}" == 'snapshot' ] ; then
	case "${_GH_PROVIDER}" in
		'bitbucket')
			SRC_URI="${_GH_BASE_URI}/get/${GH_REF}.tar.bz2 -> ${P}.tar.bz2" ;;
		'github')
			SRC_URI="${_GH_BASE_URI}/archive/${GH_REF}.tar.gz -> ${P}.tar.gz" ;;
		'gitlab')
			SRC_URI="${_GH_BASE_URI}/repository/archive.tar.gz?ref=${GH_REF} -> ${P}.tar.gz" ;;
		*) die "Unsupported provider '${_GH_PROVIDER}'" ;;
	esac
fi

if [ -z "${EGIT_REPO_URI}" ] ; then
	EGIT_REPO_URI="
		${_GH_BASE_URI}.git
		git@${_GH_DOMAIN}:${_GH_USER}/${_GH_REPO}.git"
fi


case "${GH_FETCH_TYPE}" in
	'live')
		if [ -n "${GH_REF}" ] && [ -z "${EGIT_COMMIT}" ] ; then
			EGIT_COMMIT="${GH_REF}"
		fi

		inherit git-r3
		;;
	'snapshot')
		inherit vcs-snapshot
		;;
	*) die "Unsupported fetch type: '${GH_FETCH_TYPE}'" ;;
esac

: ${HOMEPAGE:="${_GH_BASE_URI}"}

# prefer their CDN over Gentoo mirrors
RESTRICT="${RESTRICT} primaryuri"


EXPORT_FUNCTIONS src_unpack


# @FUNCTION: git-hosting_src_unpack
git-hosting_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	case "${GH_FETCH_TYPE}" in
		'live') git-r3_src_unpack ;;
		'snapshot') vcs-snapshot_src_unpack ;;
		*) die ;;
	esac
}


_GH_ECLASS=1
fi
