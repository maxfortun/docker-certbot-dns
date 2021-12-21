#!/bin/ash -e
echo "$CERTBOT_DOMAIN: Validating"

logFile=$(basename $0)
exec 1> $logFile.$CERTBOT_DOMAIN.out
exec 2> $logFile.$CERTBOT_DOMAIN.err

domain=${CERTBOT_DOMAIN##\*.}
zoneFile=/var/bind/zones/$domain

echo "_acme-challenge		TXT	$CERTBOT_VALIDATION" >> $zoneFile
serial=$(grep '; serial' $zoneFile|awk '{ print $1 }')
nextSerial=$( date +%Y%m%d%S )
sed -i.$serial "s/[0-9]* ; serial/$nextSerial ; serial/" $zoneFile

NS=$(nslookup -q=ns $domain|grep "nameserver"|awk '{ print $4 }'|head -1)

echo "$CERTBOT_DOMAIN@$NS: Waiting for $CERTBOT_VALIDATION"
while true; do
	records=$(nslookup -q=txt _acme-challenge.$domain $NS || true)
	if echo "$records" | grep -- $CERTBOT_VALIDATION; then
		break
	fi
	echo "$CERTBOT_DOMAIN@$NS: Still waiting for $CERTBOT_VALIDATION"
	sleep 5
done
echo "$CERTBOT_DOMAIN@$NS: Found $CERTBOT_VALIDATION"


