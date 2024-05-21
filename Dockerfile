FROM alpine:latest

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && mkdir -m 777 /myv2bin \ 
 && cd /myv2bin \
 && curl -L -H "Cache-Control: no-cache" -o myv2.zip https://github.com/XTLS/Xray-core/latest/download/Xray-linux-64.zip \
 && unzip myv2.zip \
 && chmod +x /myv2bin/xray \
 && rm -rf myv2.zip \
 && chgrp -R 0 /myv2bin \
 && chmod -R g+rwX /myv2bin \
 && mv /myv2bin/xray /myv2bin/myv2
 
COPY config.json /myv2bin 
ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh 

ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
