FROM elasticsearch:5.6.4

USER root

ADD elasticsearch.yml /usr/share/elasticsearch/config/
ADD java.policy /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/java.policy
ADD elasticsearch.yml /usr/share/elasticsearch
ADD couchbase_template.json /elasticsearch/couchbase_template.json
RUN chown elasticsearch.elasticsearch /usr/share/elasticsearch/data

RUN chown elasticsearch:elasticsearch config/elasticsearch.yml
RUN chown elasticsearch:elasticsearch /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/java.policy
RUN chown elasticsearch.elasticsearch /usr/share/elasticsearch/data

RUN rm -f /var/run/elasticsearch/elasticsearch.pid

RUN ["/usr/share/elasticsearch/bin/elasticsearch-plugin", "install", "https://github.com/couchbaselabs/elasticsearch-transport-couchbase/releases/download/3.0.0-cypress/elasticsearch-transport-couchbase-3.0.0-cypress-es5.6.4.zip"]

ADD ./init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

USER elasticsearch

EXPOSE 9200 9300 9091

CMD [ "/usr/local/bin/init.sh" ]