FROM alpine:3.9

ENV VER=4.20.0

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && mkdir -m 777 /myv2bin \ 
 && cd /myv2bin \
 && curl -L -H "Cache-Control: no-cache" -o myv2.zip https://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip \
 && unzip myv2.zip \
 && chmod +x /myv2bin/v2ray \
 && rm -rf myv2.zip \
 && rm -rf config.json \
 && chgrp -R 0 /myv2bin \
 && chmod -R g+rwX /myv2bin \
 && mv /myv2bin/v2ray /myv2bin/myv2
 
COPY config.json /myv2bin 
ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh 

ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
