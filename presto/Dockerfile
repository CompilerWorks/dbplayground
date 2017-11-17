FROM phusion/baseimage
MAINTAINER Karl Stenerud <kstenerud@gmail.com>

ARG PRESTO_VERSION
ENV POSTGRESQL_VERSION 9.5

ADD https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.189/presto-server-0.189.tar.gz /opt/
RUN cd /opt && \
    tar xzf presto-server-0.189.tar.gz && \
    mv presto-server-0.189 presto && \
    rm presto-server-0.189.tar.gz

ADD https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/0.189/presto-cli-0.189-executable.jar /opt/presto/bin/prestoclient
RUN chmod a+x /opt/presto/bin/prestoclient

RUN apt update && \
    apt install -y default-jre net-tools python postgresql-${POSTGRESQL_VERSION} && \
    rm -rf /var/lib/apt/lists/*

RUN cd /usr/lib/postgresql && \
	ln -s ${POSTGRESQL_VERSION} current && \
	cd -

RUN mkdir -p /var/local/db/data && \
    chown postgres:postgres /var/local/db/data && \
    su - postgres -c '/usr/lib/postgresql/current/bin/initdb -D /var/local/db/data/'

RUN echo "host all  all    0.0.0.0/0  trust" >> /var/local/db/data/pg_hba.conf && \
    echo "listen_addresses='*'" >> /var/local/db/data/postgresql.conf

COPY src/ /

EXPOSE 8080
