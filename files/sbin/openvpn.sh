#!/bin/sh

set -e

### usage: Help
usage() {

echo "Usage: ${0##*/} [-opt] [command]:

    -h 			Help
    -t 			Specify tunnel config to use e.g. tun0 (REQUIRED)

"
exit 0
}

while getopts ":ht:" opt; do
    case "$opt" in
        h) usage ;;
		t) tun="$OPTARG" ;;
    esac
done

if ps -ef | egrep -v 'grep|openvpn.sh' | grep -q openvpn; then
    echo "Service already running, please restart container to apply changes"
else	
	# OpenVPN brings up the tunnel
    /usr/sbin/openvpn --config /etc/openvpn/$tun.conf
fi