FROM phusion/baseimage:0.9.22
MAINTAINER Karl Stenerud <kstenerud@gmail.com>

ENV POSTGRESQL_VERSION 9.5
ENV POSTGRESQL_DB_HOME /var/local/db/data

RUN apt update && \
    apt install -y postgresql-${POSTGRESQL_VERSION} && \
    rm -rf /var/lib/apt/lists/*

RUN cd /usr/lib/postgresql && \
	ln -s ${POSTGRESQL_VERSION} current && \
	cd -

RUN mkdir -p ${POSTGRESQL_DB_HOME} && \
    chown postgres:postgres ${POSTGRESQL_DB_HOME} && \
    su - postgres -c "/usr/lib/postgresql/current/bin/initdb -D ${POSTGRESQL_DB_HOME}"

RUN echo "host all  all    0.0.0.0/0  trust" >> ${POSTGRESQL_DB_HOME}/pg_hba.conf && \
    echo "listen_addresses='*'" >> ${POSTGRESQL_DB_HOME}/postgresql.conf

COPY src/ /

EXPOSE 5432
