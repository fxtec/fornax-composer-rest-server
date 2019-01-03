#!/bin/bash
mkdir -p $(dirname $1)
curl -Ss $ETCD_ENDPOINT/v2/keys/$1 | jq -r -e '.node.value' | base64 -d > $1
