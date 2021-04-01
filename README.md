# samba-ad

Samba active directory domain controller in Docker container

## Supported tags and Dockerfile links

-	[`latest` (*Dockerfile*)](https://github.com/racingsoft/samba-ad/blob/main/Dockerfile)

# How to use

### Command Line

```bash
docker build -t samba-ad .
docker run -d \
    -e WORKGROUP=MY-WORKGROUP \
    -e REALM=my-workgroup.com \
    -e ADMIN_PASSWORD=my_admin_password \
    --cap-add SYS_ADMIN \
    --cap-add SYS_NICE \
    --cap-add SYS_TIME \
    --cap-add SYS_RESOURCE \
    -p 123:123/udp \
```