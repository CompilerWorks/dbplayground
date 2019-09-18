FROM phusion/baseimage:0.9.22
MAINTAINER Karl Stenerud <kstenerud@gmail.com>

ENV PRESTO_VERSION 0.225
ENV POSTGRESQL_VERSION 9.5
ENV PRESTO_HOME /opt/presto

RUN curl -O https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz && \
    tar xzf presto-server-${PRESTO_VERSION}.tar.gz && \
    mv presto-server-${PRESTO_VERSION} ${PRESTO_HOME} && \
    rm -f presto-server-${PRESTO_VERSION}.tar.gz

RUN curl -o ${PRESTO_HOME}/bin/presto https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/${PRESTO_VERSION}/presto-cli-${PRESTO_VERSION}-executable.jar &&\
    chmod a+x ${PRESTO_HOME}/bin/presto

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
