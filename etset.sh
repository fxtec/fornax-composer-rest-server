#!/bin/bash
curl -Ss $ETCD_ENDPOINT/v2/keys/$1 -XPUT -d value=$2 | jq -r -e '.action'
