#!/bin/bash

#set -euxo pipefail

conf_file=/config/yggdrasil.conf

[ -f "${conf_file}" ] || yggdrasil -genconf >${conf_file}

sed -i 's/IfName: auto/IfName: none/g' ${conf_file}
sed -i 's/AdminListen: unix:\/\/\/var\/run\/yggdrasil.sock/AdminListen: none/g' ${conf_file}
sed -i 's/Listen: \[\]/Listen: \[ "tcp:\/\/0.0.0.0:3434" \]/g' ${conf_file}

new_peers_block=$'  Peers: [\n\
        tcp://ekb.itrus.su:7991\n\
        tcp://srv.itrus.su:7991\n\
        tcp://vpn.itrus.su:7991\n\
        # russia\n\
        tcp://s-mow-1.sergeysedoy97.ru:65533\n\
        tls://s-mow-1.sergeysedoy97.ru:65534\n\
        tcp://x-mow-1.sergeysedoy97.ru:65533\n\
        tls://x-mow-1.sergeysedoy97.ru:65534\n\
        tls://[2a09:5302:ffff::992]:443\n\
        tcp://[2a09:5302:ffff::992]:12403\n\
        tls://45.147.200.202:443\n\
        tcp://45.147.200.202:12402\n\
        tls://ygg-msk-1.averyan.ru:8362\n\
        tcp://ygg-msk-1.averyan.ru:8363\n\
        quic://ygg-msk-1.averyan.ru:8364\n\
        tcp://box.paulll.cc:13337\n\
        tls://box.paulll.cc:13338\n\
        tcp://188.225.9.167:18226\n\
        tls://188.225.9.167:18227\n\
        tcp://yggno.de:18226\n\
        tls://yggno.de:18227\n\
        quic://vix.duckdns.org:36014\n\
        tls://vix.duckdns.org:36014\n\
        tcp://94.103.183.125:7676\n\
        tcp://185.177.216.199:7890\n\
        tls://185.177.216.199:7891\n\
        tcp://itcom.multed.com:7991\n\
        tcp://s-mow-0.sergeysedoy97.ru:65533\n\
        tls://s-mow-0.sergeysedoy97.ru:65534\n\
        tcp://x-mow-0.sergeysedoy97.ru:65533\n\
        tls://x-mow-0.sergeysedoy97.ru:65534\n\
        quic://x-mow-0.sergeysedoy97.ru:65535\n\
        quic://x-mow-1.sergeysedoy97.ru:65535\n\
        tcp://185.44.64.141:7743\n\
        tcp://107.174.34.109:7743\n\
        tcp://37.221.65.132:7743\n\
  ]\n'
sed -i '/^ *Peers: \[\]$/c\'"$'\n'"$new_peers_block" ${conf_file}

exec /usr/bin/yggdrasil -useconffile ${conf_file}
