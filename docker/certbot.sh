#!/bin/ash -ex

cd $(dirname $0)
WD=$(pwd)
cd -

DOMAIN_PARAMS=""

domains=$($WD/getDomains.sh /var/bind/zones|tr '\n' ','|sed 's/,$//g')

certbot certonly -n --manual --text --agree-tos --preferred-challenges dns \
	--manual-auth-hook $WD/certbot-auth.sh \
	--manual-cleanup-hook $WD/certbot-cleanup.sh \
	--email $EMAIL \
	-d $domains \
	"$@"


