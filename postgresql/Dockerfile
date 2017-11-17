FROM phusion/baseimage
MAINTAINER Karl Stenerud <kstenerud@gmail.com>

ARG POSTGRESQL_VERSION

RUN apt update && \
    apt install -y postgresql-${POSTGRESQL_VERSION} && \
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

EXPOSE 5432
