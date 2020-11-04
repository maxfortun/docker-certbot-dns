#!/bin/ash -e

cd $(dirname $0)
WD=$(pwd)
cd -

certbot renew

