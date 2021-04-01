FROM alpine:3.13

LABEL es.racingsoft RACINGSOFT
LABEL maintainer Ruben Castro <racingsoft@gmail.com>
LABEL version v1.0.0
LABEL description Samba Active Directory

RUN pkg add --no-cache chrony chrony-doc samba-dc krb5 && \
    rm -f /etc/samba/smb.conf

WORKDIR /app
COPY [ "./entrypoint.sh", "./" ]

VOLUME [ "/etc/samba", "/var/lib/samba" ]

ENTRYPOINT [ "/app/entrypoint.sh" ]
CMD [ ]