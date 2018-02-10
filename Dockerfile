FROM elasticsearch:5.6.4

RUN cd /usr/share/elasticsearch && \
    bin/elasticsearch-plugin install \
    https://github.com/couchbaselabs/elasticsearch-transport-couchbase/releases/download/3.0.0-cypress/elasticsearch-transport-couchbase-3.0.0-cypress-es5.6.4.zip