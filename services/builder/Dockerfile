FROM ubuntu:14.04

ENV BOOST_ROOT="/boost_1_61_0"

RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common && \
    add-apt-repository -y ppa:george-edison55/cmake-3.x && \
    apt-get update && \
    apt-get remove -y cmake cmake-data && \
    apt-get install -y curl wget build-essential gcc g++ automake git-core autoconf make patch libmysql++-dev \
                       libtool libssl-dev grep binutils zlibc libc6 libbz2-dev cmake mysql-client && \
    echo "Installing Boost..." && \
    wget --quiet https://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.gz && \
    tar -xzf /boost_1_61_0.tar.gz && \
    rm /boost_1_61_0.tar.gz && \
    cd $BOOST_ROOT && \
    ./bootstrap.sh && \
    (./b2 || true) && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

COPY ./services/builder/bin/* /usr/local/bin/

COPY ./tools/bin/* /usr/local/bin/

WORKDIR /runtime
