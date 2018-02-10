#!/bin/bash

wait_for_start() {
    "$@"
    while [ $? -ne 0 ]
    do
        echo 'waiting for elastic to start'
        sleep 1
        "$@"
    done
}

init_couchbase_template() {
curl -u elastic:changeme -XPUT http://localhost:9200/_template/couchbase -d  @plugins/transport-couchbase/couchbase_template.json
}

create_data_index() {
curl -u elastic:changeme -XPUT http://localhost:9200/dxplogging
}

echo "launch elastic"
/usr/share/elasticsearch/bin/elasticsearch &
cd /elasticsearch

echo "create couchbase template"
wait_for_start init_couchbase_template

if [ "$INIT_CLUSTER" = "1" ]; then
    echo "create data index"
    wait_for_start create_data_index
fi

wait