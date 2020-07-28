FROM openjdk:jre-alpine

RUN apk add --update openssl && \
    rm -rf /var/cache/apk/*
    
ADD entrypoint.sh /

ENV CRT_PATH /src/tls.crt
ENV KEY_PATH /src/tls.key

ENV KEYSTORE_NAME keystore
ENV KEYSTORE_ALIAS key

ENTRYPOINT ["/entrypoint.sh"]