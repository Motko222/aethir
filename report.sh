#!/bin/bash

path=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)
folder=$(echo $path | awk -F/ '{print $NF}')
json=~/logs/report-$folder
source ~/.bash_profile

version=$(cat ~/aethir/log/server.log | grep "Initialize Service Version: " | head -1 | awk -F "Initialize Service Version: " '{print $NF}' | awk '{print $1}')
service=$(sudo systemctl status aethir-checker --no-pager | grep "active (running)" | wc -l)
pid=$(pidof AethirCheckerService)
errors=$(cat ~/aethir/log/server.log | grep $(date --utc +%F) | grep -c "rror")

status="ok"
if [ $service -ne 1 ] && status="error";message="service not running"
if [ $service -gt 0 ] && status="warning";message="errors=$errors"

cat >$json << EOF
{
  "updated":"$(date --utc +%FT%TZ)",
  "measurement":"report",
  "tags": {
       "id":"$folder",
       "machine":"$MACHINE",
       "grp":"node",
       "owner":"$OWNER"
  },
  "fields": {
        "chain":"arbitrum one",
        "network":"mainnet",
        "version":"$version",
        "status":"$status",
        "message":"$message",
        "service":$service,
        "errors":$errors,
        "pid":$pid
  }
}
EOF

cat $json
