FROM phusion/baseimage:0.9.22
MAINTAINER Karl Stenerud <kstenerud@gmail.com>

ENV HIVE_VERSION 2.3.2
ENV POSTGRESQL_VERSION 9.5
ENV HADOOP_VERSION 2.8.2

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre
ENV HADOOP_HOME /opt/hadoop
ENV HIVE_HOME /opt/hive

RUN curl -O http://artfiles.org/apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz &&\
    tar xzf apache-hive-${HIVE_VERSION}-bin.tar.gz &&\
    mv apache-hive-${HIVE_VERSION}-bin ${HIVE_HOME} &&\
    rm -f apache-hive-${HIVE_VERSION}-bin.tar.gz

RUN curl -O http://artfiles.org/apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz &&\
    tar xzf hadoop-${HADOOP_VERSION}.tar.gz &&\
    mv hadoop-${HADOOP_VERSION} ${HADOOP_HOME} &&\
    rm -f hadoop-${HADOOP_VERSION}.tar.gz

RUN apt update && \
    apt install -y default-jre net-tools ssh pdsh telnet && \
    rm -rf /var/lib/apt/lists/*

RUN rm -f /etc/service/sshd/down && \
    /etc/my_init.d/00_regen_ssh_host_keys.sh && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    ssh-keygen -f /root/.ssh/id_rsa -q && \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

COPY src/ /

RUN echo "export JAVA_HOME=/usr/lib/jvm/default-java" >> ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh && \
    echo "HADOOP_HOME=${HADOOP_HOME}" >> ${HIVE_HOME}/conf/hive_env.sh && \
    echo "HADOOP_HEAPSIZE=512" >> ${HIVE_HOME}/conf/hive_env.sh

RUN ${HADOOP_HOME}/bin/hadoop namenode -format

RUN ${HIVE_HOME}/bin/schematool -initSchema -dbType derby && \
    rm ${HIVE_HOME}/metastore_db/*.lck

EXPOSE 10000

# Hadoop http://localhost:50070/dfshealth.html
EXPOSE 50070
