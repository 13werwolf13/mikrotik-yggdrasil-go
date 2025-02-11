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
        tcp://s-mow-1.sergeysedoy97.ru:65533\
        tls://s-mow-1.sergeysedoy97.ru:65534\
        tcp://x-mow-1.sergeysedoy97.ru:65533\
        tls://x-mow-1.sergeysedoy97.ru:65534\
        tls://45.147.200.202:443\
        tcp://45.147.200.202:12402\
        tls://ygg-msk-1.averyan.ru:8362\
        tcp://ygg-msk-1.averyan.ru:8363\
        quic://ygg-msk-1.averyan.ru:8364\
        tcp://box.paulll.cc:13337\
        tls://box.paulll.cc:13338\
        tcp://188.225.9.167:18226\
        tls://188.225.9.167:18227\
        tcp://yggno.de:18226\
        tls://yggno.de:18227\
        quic://vix.duckdns.org:36014\
        tls://vix.duckdns.org:36014\
        tcp://94.103.183.125:7676\
        tcp://185.177.216.199:7890\
        tls://185.177.216.199:7891\
        tcp://itcom.multed.com:7991\
        tcp://s-mow-0.sergeysedoy97.ru:65533\
        tls://s-mow-0.sergeysedoy97.ru:65534\
        tcp://x-mow-0.sergeysedoy97.ru:65533\
        tls://x-mow-0.sergeysedoy97.ru:65534\
        quic://x-mow-0.sergeysedoy97.ru:65535\
        quic://x-mow-1.sergeysedoy97.ru:65535\
        tcp://185.44.64.141:7743\
        tcp://107.174.34.109:7743\
        tcp://37.221.65.132:7743\
  ]'
sed -i "s|^  Peers: \[\]|$new_peers_block|g" ${conf_file}

exec /usr/bin/yggdrasil -useconffile ${conf_file}
