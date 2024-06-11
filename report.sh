#!/bin/bash

source ~/scripts/aethir/cfg

version=$(cat ~/aethir/log/server.log | grep "\"ver\" : " | head -1 | awk '{print $3}' | sed 's/\"\|,//g')
service=$(sudo systemctl status aethir-checker --no-pager | grep "active (running)" | wc -l)
pid=$(pidof AethirCheckerService)
chain=$AETHIR_CHAIN
network=$AETHIR_NETWORK
type=$AETHIR_TYPE

if [ $service -ne 1 ]
then
  status="error";
  message="service not running"
else
  status="ok";
fi

#if [ -z $pid ]
#then
#  status="error";
#  message="process not running"
#else
#  status="ok";
#fi

cat << EOF
{
  "id":"$id",
  "machine":"$MACHINE",
  "chain":"$chain",
  "network":"$network",
  "type":"$type",
  "version":"$version",
  "status":"$status",
  "message":"$message",
  "service":$service,
  "pid":$pid,
  "updated":"$(date --utc +%FT%TZ)"
}
EOF

# send data to influxdb
if [ ! -z $INFLUX_HOST ]
then
 curl --request POST \
 "$INFLUX_HOST/api/v2/write?org=$INFLUX_ORG&bucket=$INFLUX_BUCKET&precision=ns" \
  --header "Authorization: Token $INFLUX_TOKEN" \
  --header "Content-Type: text/plain; charset=utf-8" \
  --header "Accept: application/json" \
  --data-binary "
    report,id=$ID,machine=$MACHINE,owner=$OWNER,grp=$GROUP status=\"$status\",message=\"$message\",version=\"$version\",url=\"$url\",chain=\"$CHAIN\",network=\"$NETWORK\",type=\"$TYPE\" $(date +%s%N)
    "
fi
