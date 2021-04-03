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
    samba-ad
```