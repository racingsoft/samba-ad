FROM alpine:3.13

LABEL es.racingsoft RACINGSOFT
LABEL maintainer Ruben Castro <racingsoft@gmail.com>
LABEL version v1.0.0
LABEL description Samba Active Directory

RUN apk add --no-cache chrony chrony-doc pwgen samba-dc krb5 supervisor && \
    rm -f /etc/samba/smb.conf && \
    rm -f /etc/supervisord.conf

EXPOSE 53 88 135 139 389 445 464 636 3268 3269 49152-65535
EXPOSE 53/udp 88/udp 123/udp 137/udp 138/udp 389/udp 464/udp

WORKDIR /opt/samba-ad
COPY [ "./entrypoint.sh", "./smb.conf.j2", "./supervisord.conf", "./" ]

VOLUME [ "/var/lib/samba" ]

ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "start" ]