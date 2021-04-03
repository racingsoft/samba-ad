# samba-ad

Samba active directory domain controller in Docker container

## Supported tags and Dockerfile links

-	[`latest` (*Dockerfile*)](https://github.com/racingsoft/samba-ad/blob/main/Dockerfile)

# How to use

## Environment variables

| **Variable** | **Description** | **Required** |
|-|-|-|
| **AD_DOMAIN** | NetBIOS Domain | True|
| **AD_REALM** | DNS Domain | True |
| **AD_ADMIN_PASSWORD** | AD Administrator password | False |

### Command Line

```bash
docker build -t samba-ad .
docker run -d \
    -e AD_DOMAIN=racingsoft \
    -e AD_REALM=racingsoft.home \
    -e AD_ADMIN_PASSWORD=my_admin_password \
    --hostname ad-server.racingsoft.home \
    --dns-search racingsoft.home \
    --dns 127.0.0.1 \
    --cap-add SYS_RESOURCE \
    --cap-add SYS_ADMIN \
    -p "53:53" -p "53:53/udp" \
    -p "88:88" -p "88:88/udp" \
    -p "123:123/udp" \
    -p "135:135" \
    -p "137:137/udp" \
    -p "138:138/udp" \
    -p "139:139" \
    -p "389:389" -p "389:389/udp" \
    -p "445:445" \
    -p "464:464" -p "464:464/udp" \
    -p "636:636" \
    -p "3268:3268" \
    -p "3269:3269" \
    -p "49152-65535:49152-65535" \
    samba-ad
```