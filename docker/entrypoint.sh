#!/bin/ash -e

cd $(dirname $0)
WD=$(pwd)
cd -

[ ! -e /etc/letsencrypt/archive ] && $WD/certbot.sh || certbot renew || true

crond -f -d 8

