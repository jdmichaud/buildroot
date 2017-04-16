#!/bin/bash

die() {
  echo "Error: $@" >&2
  exit 1
}

GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

shift
while getopts :c: OPT ; do
	case "${OPT}" in
	c) GENIMAGE_CFG="${OPTARG}";;
	:) die "option '${OPTARG}' expects a mandatory argument";;
	\?) die "unknown option '${OPTARG}'";;
	esac
done

[ -n "${GENIMAGE_CFG}" ] || die "Missing argument"

rm -rf "${GENIMAGE_TMP}"

set -- "${@:$OPTIND}"

exec genimage \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}" \
	"${@}"
