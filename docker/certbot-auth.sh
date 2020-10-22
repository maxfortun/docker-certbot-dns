#!/bin/ash -ex
zoneFile=/var/bind/zones/$CERTBOT_DOMAIN

echo "_acme-challenge		TXT	$CERTBOT_VALIDATION" >> $zoneFile
serial=$(grep '; serial' $zoneFile|awk '{ print $1 }')
nextSerial=$(( serial + 1 ))
sed -i.$serial "s/[0-9]* ; serial/$nextSerial ; serial/" $zoneFile

