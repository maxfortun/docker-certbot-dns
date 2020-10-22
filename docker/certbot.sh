#!/bin/ash -ex

cd $(dirname $0)
WD=$(pwd)
cd -

DOMAIN_PARAMS=""

domains=$(ls -1 /var/bind/zones|tr '\n' ','|sed 's/,$//g')

certbot certonly -n --manual --text --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns \
	--manual-auth-hook $WD/certbot-auth.sh \
	--manual-cleanup-hook $WD/certbot-auth.sh \
	--email $EMAIL \
	--test-cert \
	-d $domains


