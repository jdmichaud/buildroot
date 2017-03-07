#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

# Dropbear files
mkdir -p ${TARGET_DIR}/etc/default/
echo DROPBEAR_ARGS=-B >${TARGET_DIR}/etc/default/dropbear
if [ -L "${TARGET_DIR}/etc/dropbear" ]; then
	rm ${TARGET_DIR}/etc/dropbear
	mkdir -p ${TARGET_DIR}/etc/dropbear/
fi
cp ${0%/*}/dropbear_ecdsa_host_key ${TARGET_DIR}/etc/dropbear/
