#!/bin/ash -ex
echo "Validating $CERTBOT_DOMAIN"       
zoneFile=/var/bind/zones/$CERTBOT_DOMAIN

echo "_acme-challenge		TXT	$CERTBOT_VALIDATION" >> $zoneFile
serial=$(grep '; serial' $zoneFile|awk '{ print $1 }')
nextSerial=$(( serial + 1 ))
sed -i.$serial "s/[0-9]* ; serial/$nextSerial ; serial/" $zoneFile

echo "Waiting for $CERTBOT_VALIDATION"
while true; do
	records=$(nslookup -q=txt _acme-challenge.$CERTBOT_DOMAIN)
	if echo "$records" | grep $CERTBOT_VALIDATION; then
		break
	fi
	echo "Still waiting for $CERTBOT_VALIDATION"
	sleep 5
done
echo "Found $CERTBOT_VALIDATION"


