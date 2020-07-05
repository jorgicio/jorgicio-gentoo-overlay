#!/sbin/openrc-run

command="env python3 -u /usr/bin/optimus-manager-daemon"
pidfile=${pidfile-/var/run/optimus-manager.pid}
description="Optimus Manager Commands daemon"
command_background=true

depend() {
    before xdm
}

start_pre() {
    /usr/sbin/prime-switch-boot || return $?
}

