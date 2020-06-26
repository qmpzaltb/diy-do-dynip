#!/bin/bash -e

### VARIABLES ###
# Your DigitalOcean API key
DO_API_KEY="API_KEY_GOES_HERE"

# The domain name you're working with
DOMAIN="domain.example"

# The subdomain you want to edit. E.g., "home" for home.domain.example
# "@" will update the domain itself.
SUBDOMAIN="@"

# The IDs of your A (IPv4) and AAAA (IPv6) records.
# You can get these by running:
# curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer ${DO_API_KEY}" "https://api.digitalocean.com/v2/domains/${DOMAIN}/records"
# If left blank, they will not be updated.
A_RECORD_ID=""
AAAA_RECORD_ID=""

# Time-to-live of the updated record(s), in seconds.
TTL=3600

### ACTUAL CODE ###
if [[ $A_RECORD_ID ]]
then
    IPv4=$(dig +short myip.opendns.com @resolver1.opendns.com)
    curl -X PUT \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${DO_API_KEY}" \
        -d '{"type":"A","name":"'${SUBDOMAIN}'","data":"'${IPv4}'", "ttl":'${TTL}'}' \
        "https://api.digitalocean.com/v2/domains/${DOMAIN}/records/${A_RECORD_ID}"
fi

if [[ $AAAA_RECORD_ID ]]
then
    IPv6=$(dig +short -6 myip.opendns.com aaaa @resolver1.ipv6-sandbox.opendns.com)
    curl -X PUT \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${DO_API_KEY}" \
        -d '{"type":"AAAA","name":"'${SUBDOMAIN}'","data":"'${IPv6}'", "ttl":'${TTL}'}' \
        "https://api.digitalocean.com/v2/domains/${DOMAIN}/records/${AAAA_RECORD_ID}"
fi
