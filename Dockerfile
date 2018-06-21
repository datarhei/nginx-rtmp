ARG FFMPEG_IMAGE=datarhei/ffmpeg:4
ARG ALPINE_IMAGE=alpine:latest

FROM $FFMPEG_IMAGE as builder

ENV NGINX_VERSION=1.15.0 \
    NGINX_RTMP_VERSION=dev \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    SRC=/usr/local

RUN export buildDeps="autoconf \
        automake \
        bash \
        binutils \
        bzip2 \
        cmake \
        curl \
        coreutils \
        g++ \
        gcc \
        gnupg \
        libtool \
        make \
        python \
        openssl-dev \
        tar \
        xz \
        git \
        pcre-dev \
        zlib-dev" && \
    export MAKEFLAGS="-j$(($(grep -c ^processor /proc/cpuinfo) + 1))" && \
    apk add --update ${buildDeps} libgcc libstdc++ ca-certificates libssl1.0 && \
    DIR="$(mktemp -d)" && cd "${DIR}" && \
    curl -LOks "https://github.com/nginx/nginx/archive/release-${NGINX_VERSION}.tar.gz" && \
    tar xzvf "release-${NGINX_VERSION}.tar.gz" && \
    curl -LOks "https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/archive/${NGINX_RTMP_VERSION}.tar.gz" && \
    tar xzvf "${NGINX_RTMP_VERSION}.tar.gz" && \
    cd "nginx-release-${NGINX_VERSION}" && \
    auto/configure \
        --with-http_ssl_module \
        --add-module="../nginx-rtmp-module-${NGINX_RTMP_VERSION}" --with-http_ssl_module && \
    make && \
    make install && \
    rm -rf "${DIR}" && \
    apk del --purge git && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

ADD nginx.conf /usr/local/nginx/conf/nginx.conf

FROM $ALPINE_IMAGE

MAINTAINER datarhei <info@datarhei.org>

ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    SRC=/usr/local

COPY --from=builder /usr/local/bin/ffmpeg /usr/local/bin/ffmpeg
COPY --from=builder /usr/local/bin/ffprobe /usr/local/bin/ffprobe
COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /usr/local/nginx /usr/local/nginx

RUN apk add --no-cache --update libssl1.0 pcre && \
    ffmpeg -buildconf
    
EXPOSE 1935

CMD ["/usr/local/nginx/sbin/nginx"]