#!/bin/bash
#etcdctl --endpoints=${ETCD_ENDPOINT} $@
curl -Ss $ETCD_ENDPOINT/v2/keys/$1 | jq -r -e '.node.value'
