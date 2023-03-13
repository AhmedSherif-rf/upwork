# syntax=docker/dockerfile:experimental
FROM docker:dind

ENV DOMAIN=smarthosting.com \
    DB_PASSWORD=insecure

RUN apk add --no-cache bash gawk \
 && mkdir /custom

COPY index.html entrypoint.sh website.sh /custom 
WORKDIR /custom

EXPOSE 80
EXPOSE 53

ENTRYPOINT /custom/entrypoint.sh
