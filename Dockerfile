FROM akamalov/centos7-java:8u111 
MAINTAINER Alex Kamalov <akamalov@gmail.com> 

# Download Yelp Dumb-Init - https://github.com/Yelp/dumb-init

RUN curl -fLsS -o /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.0.2/dumb-init_1.0.2_amd64 && chmod +x /usr/local/bin/dumb-init

# Download Apache ZooKeeper -  https://www.apache.org/mirrors/dist.html

RUN curl -fL http://archive.apache.org/dist/zookeeper/zookeeper-3.4.8/zookeeper-3.4.8.tar.gz | tar xzf - -C /opt && \
mv /opt/zookeeper-3.4.8 /opt/zookeeper

VOLUME /tmp/zookeeper

COPY entrypoint.sh /

ENTRYPOINT ["/usr/local/bin/dumb-init", "/entrypoint.sh"]

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/zookeeper/bin

CMD ["zkServer.sh", "start-foreground"]
