# FROM openjdk:17-bullseye
FROM docker.io/library/eclipse-temurin:17-jre

ARG KAFKA_VERSION_NR=3.6.1

ENV KAFKA_VERSION=${KAFKA_VERSION_NR}
ENV SCALA_VERSION=2.13
ENV KAFKA_HOME=/opt/kafka
ENV PATH=${PATH}:${KAFKA_HOME}/bin

LABEL name="kafka" version=${KAFKA_VERSION}

RUN wget -O /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz
RUN tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt
RUN rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz
RUN ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME}
RUN rm -rf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

COPY ./entrypoint.sh /
RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]