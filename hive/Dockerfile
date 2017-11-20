FROM phusion/baseimage
MAINTAINER Karl Stenerud <kstenerud@gmail.com>

ARG HIVE_VERSION
ENV POSTGRESQL_VERSION 9.5
ENV HADOOP_VERSION 2.8.2

RUN curl -O http://artfiles.org/apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz &&\
    tar xzf apache-hive-${HIVE_VERSION}-bin.tar.gz &&\
    mv apache-hive-${HIVE_VERSION}-bin /opt/hive &&\
    rm -f apache-hive-${HIVE_VERSION}-bin.tar.gz

RUN curl -O http://artfiles.org/apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz &&\
    tar xzf hadoop-${HADOOP_VERSION}.tar.gz &&\
    mv hadoop-${HADOOP_VERSION} /opt/hadoop &&\
    rm -f hadoop-${HADOOP_VERSION}.tar.gz

RUN apt update && \
    apt install -y default-jre net-tools ssh pdsh && \
    rm -rf /var/lib/apt/lists/*

COPY src/ /

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre
ENV HADOOP_HOME /opt/hadoop
ENV HIVE_HOME /opt/hive

RUN rm -f /etc/service/sshd/down

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    ssh-keygen -f /root/.ssh/id_rsa -q && \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

RUN echo "export JAVA_HOME=/usr/lib/jvm/default-java" >> /opt/hadoop/etc/hadoop/hadoop-env.sh

RUN echo "HADOOP_HOME=${HADOOP_HOME}" >> ${HIVE_HOME}/conf/hive_env.sh && \
    echo "HADOOP_HEAPSIZE=512" >> ${HIVE_HOME}/conf/hive_env.sh

RUN /opt/hadoop/bin/hadoop namenode -format

RUN /opt/hive/bin/schematool -initSchema -dbType derby && \
    rm /opt/hive/metastore_db/*.lck

EXPOSE 10000

# Hadoop http://localhost:50070/dfshealth.html
EXPOSE 50070
