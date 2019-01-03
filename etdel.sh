#!/bin/bash
curl -Ss $ETCD_ENDPOINT/v2/keys/$1?recursive=true -XDELETE | jq -r -e '.action'
