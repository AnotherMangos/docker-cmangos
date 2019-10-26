FROM ubuntu:14.04

RUN apt-get update && \
    apt-get install -y libmysql++-dev mysql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

WORKDIR /runtime/bin

COPY ./data/builder/data/run/bin/realmd ./

COPY ./services/realmd/bin/* ./

COPY ./tools/bin/* /usr/bin/

CMD ["./realmd.sh"]