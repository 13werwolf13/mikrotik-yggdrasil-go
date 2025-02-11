#!/bin/bash

#set -euxo pipefail

conf_file=/config/yggdrasil.conf

[ -f "${conf_file}" ] || yggdrasil -genconf >${conf_file}

sed -i 's/IfName: auto/IfName: none/g' ${conf_file}
sed -i 's/AdminListen: unix:\/\/\/var\/run\/yggdrasil.sock/AdminListen: none/g' ${conf_file}
sed -i 's/Listen: \[\]/Listen: \[ "tcp:\/\/0.0.0.0:7991" \]/g' ${conf_file}

new_peers_block='  Peers: [\
        tcp://ekb.itrus.su:7991\
        tcp://srv.itrus.su:7991\
        tcp://vpn.itrus.su:7991\
  ]'
sed -i "s|^  Peers: \[\]|$new_peers_block|g" ${conf_file}

exec /usr/bin/yggdrasil -useconffile ${conf_file}
