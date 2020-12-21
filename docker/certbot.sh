#!/bin/ash -ex

cd $(dirname $0)
WD=$(pwd)
cd -

DOMAIN_PARAMS=""

domains=$(ls -1 /var/bind/zones|grep -v '[0-9]$'|tr '\n' ','|sed 's/,$//g')
wild_domains=*.${domains//,/,*.}

certbot certonly -n --manual --text --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns \
	--manual-auth-hook $WD/certbot-auth.sh \
	--manual-cleanup-hook $WD/certbot-cleanup.sh \
	--email $EMAIL \
	-d $domains,$wild_domains \
	"$@"


