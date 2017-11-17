FROM phusion/baseimage
MAINTAINER Karl Stenerud <kstenerud@gmail.com>

ARG PRESTO_VERSION
ENV POSTGRESQL_VERSION 9.5

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

RUN curl -O https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz &&\
    tar xzf presto-server-${PRESTO_VERSION}.tar.gz &&\
    mv presto-server-${PRESTO_VERSION} /opt/presto &&\
    rm -f presto-server-${PRESTO_VERSION}.tar.gz

RUN curl -o /opt/presto/bin/prestoclient https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/${PRESTO_VERSION}/presto-cli-${PRESTO_VERSION}-executable.jar &&\
    chmod a+x /opt/presto/bin/prestoclient

COPY src/ /

EXPOSE 8080
