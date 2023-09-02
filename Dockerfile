FROM ubuntu:22.04

# run curl healthcheck every 5 seconds
HEALTHCHECK --interval=5s --timeout=3s CMD curl -X POST ${HEALTHCHECK_WEBHOOK} -H "Content-Type: application/json" -d '{"text":"Bitcoin coverage build is running"}' || exit 1

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y git python3-zmq libevent-dev libboost-dev libdb5.3++-dev libsqlite3-dev libminiupnpc-dev libzmq3-dev libtool autotools-dev automake pkg-config bsdmainutils bsdextrautils curl wget lsb-release software-properties-common build-essential jq

RUN git config --global user.email "bitcoin-coverage@aureleoules.com"
RUN git config --global user.name "bitcoin-coverage"

RUN git clone https://github.com/bitcoin/bitcoin.git /tmp/bitcoin
WORKDIR /tmp/bitcoin
RUN make -C depends NO_BOOST=1 NO_LIBEVENT=1 NO_QT=1 NO_SQLITE=1 NO_NATPMP=1 NO_UPNP=1 NO_ZMQ=1 NO_USDT=1
ENV BDB_PREFIX=/tmp/bitcoin/depends/x86_64-pc-linux-gnu
RUN mkdir -p /tmp/bitcoin/releases && ./test/get_previous_releases.py -b

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]