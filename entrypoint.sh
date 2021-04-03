#!/bin/sh

set -e

AD_DOMAIN=${AD_DOMAIN:-racingsoft}
AD_REALM=${AD_REALM:-racingsoft.home}

SAMBA_DOMAIN="$(echo $AD_DOMAIN | awk '{print toupper($0)}')"
SAMBA_REALM="$(echo $AD_REALM | awk '{print toupper($0)}')"
SAMBA_HOSTNAME="$(hostname -s | awk '{print toupper($0)}')"

PROVISION_DOMAIN="$(echo $AD_DOMAIN | awk '{print toupper($0)}')"
PROVISION_REALM="$(echo $AD_REALM | awk '{print toupper($0)}')"
PROVISION_ADMIN_PASSWORD=${AD_ADMIN_PASSWORD:-$(pwgen -cnys 30 1)}

setup_samba(){

    if [ ! -f "/etc/samba/smb.conf" ]; then
        sed -e "s:{{ DOMAIN }}:$SAMBA_DOMAIN:" \
            -e "s:{{ REALM }}:$SAMBA_REALM:" \
            -e "s:{{ HOSTNAME }}:$SAMBA_HOSTNAME:" \
            ./smb.conf.j2 > /etc/samba/smb.conf
    fi
}

domain_provision(){
    
    if [ ! -f "/var/lib/samba/.provision.${PROVISION_REALM}.done" ]; then

        samba-tool domain provision --server-role=dc --use-rfc2307 \
            --dns-backend=SAMBA_INTERNAL \
            --realm=${PROVISION_REALM} \
            --domain=${PROVISION_DOMAIN} \
            --adminpass=${PROVISION_ADMIN_PASSWORD}

        ln -sf /var/lib/samba/private/krb5.conf /etc/krb5.conf
    
        touch "/var/lib/samba/.provision.${PROVISION_REALM}.done"

        echo -e "\n====================================================\n"
        echo -e "Provision ${PROVISION_DOMAIN} done\nAdministrator password: ${PROVISION_ADMIN_PASSWORD}"
        echo -e "\n====================================================\n"
    fi
}

setup_supervisor(){
    
    if [ ! -f "/etc/supervisord.conf" ]; then
        cp ./supervisord.conf /etc/supervisord.conf
    fi
}

config(){
    setup_samba
    domain_provision
    setup_supervisor
}

start(){
    config
    supervisord -c /etc/supervisord.conf
}

case "$1" in

    start)

        start
        ;;

    config)

        config
        tail -f /dev/null
        ;;

    *)
        exec "$@"
        ;;
esac