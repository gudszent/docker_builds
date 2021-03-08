ARG BASEIMAGE=alpine:latest
FROM ${BASEIMAGE}
ENV USERID=0 GROUPID=0
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="Samba" 

RUN apk update && apk upgrade && apk add bash samba-common-tools samba tzdata && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

EXPOSE 137/udp 138/udp 139 445

HEALTHCHECK --interval=60s --timeout=15s CMD smbclient -L \\localhost -U % -m SMB3

ENTRYPOINT ["/samba-adduser/entrypoint.sh"]
CMD ["-h"]


