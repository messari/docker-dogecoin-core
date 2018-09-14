FROM debian:stable-slim

RUN useradd -r dogecoin \
  && apt-get update -y \
  && apt-get install -y curl gnupg \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && set -ex \
  && for key in \
    B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    FE3348877809386C \
  ; do \
    gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
    gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ; \
  done

ENV GOSU_VERSION=1.10

RUN curl -o /usr/local/bin/gosu -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture) \
  && curl -o /usr/local/bin/gosu.asc -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture).asc \
  && gpg --verify /usr/local/bin/gosu.asc \
  && rm /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu

ENV DOGECOIN_VERSION=1.10.0
ENV DOGECOIN_DATA=/home/dogecoin/.dogecoin
ENV DOGECOIN_SHASUM="6c396daf99fbc0134c30aa12c8f72346f19ebd38727d2f669ef96ba554aefc94  dogecoin-${DOGECOIN_VERSION}-linux64.tar.gz"

RUN curl -LO https://github.com/dogecoin/dogecoin/releases/download/v${DOGECOIN_VERSION}-dogeparty/dogecoin-${DOGECOIN_VERSION}-linux64.tar.gz \
  && echo "${DOGECOIN_SHASUM}" | sha256sum -c \
  && tar --strip=2 -xzf *.tar.gz -C /usr/local/bin \
  && rm *.tar.gz

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/home/dogecoin/.dogecoin"]

EXPOSE 22555 22556 44555 44556 18444

ENTRYPOINT ["/entrypoint.sh"]

CMD ["dogecoind"]
