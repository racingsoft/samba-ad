#!/bin/sh

set -e

setup_hosts(){
    
    # /etc/hosts
}

setup_samba(){

    # /etc/samba/smb.conf
}

domain_provision(){
    
    samba-tool domain provision --server-role=dc --use-rfc2307 \
        --dns-backend=SAMBA_INTERNAL \
        --realm=${REALM} \
        --domain=${WORKGROUP} \
        --adminpass=${ADMIN_PASSWORD}

    ln -sf /var/lib/samba/private/krb5.conf /etc/krb5.conf
}

setup_resolv_conf(){
    # /etc/resolv.conf
}

setup_supervisor(){
    # /etc/supervisord.conf
    supervisord -c /etc/supervisord.conf
}