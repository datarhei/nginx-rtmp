# nginx-rtmp

NGINX + RTMP-Module Image for H.264-Processing (e.g. RTMP, HLS)

* Alipne Linux (3.7)
* FFmpeg 4.0
* NGINX 1.15.0
* [RTMP-Module](https://github.com/sergey-dryabzhinsky/nginx-rtmp-module) Dev-Branche
* Docker-Images for AMD64/X86, ARMHF (e.g. Raspberry-Pi) and AARCH64 (e.g. Pine64)

**Config:**
```sh
error_log stderr;
worker_processes 1;
events {
     worker_connections 1024;
}
rtmp {
     server {
          listen 1935;
          application live {
               live on;
          }
     }
}
daemon off;
```

## Published Images

* `1.15.0-dev` (docker pull `datarhei/nginx-rtmp:1.15.0-dev`)
* `1.15.0-dev-armhf` (docker pull `datarhei/nginx-rtmp:1.15.0-dev-armhf`)
* `1.15.0-dev-arm64` (docker pull `datarhei/nginx-rtmp:1.15.0-dev-aarch64`)

## FFmpeg Example

* Start the image:  
  `docker run -d -p 1935:1935 datarhei/nginx-rtmp:1.15.0-dev` for AMD64/X86   
  `docker run -d -p 1935:1935 datarhei/nginx-rtmp:1.15.0-dev-armhf` for ARMHF   
  `docker run -d -p 1935:1935 datarhei/nginx-rtmp:1.15.0-dev-aarch64` for ARM64   
* Send a stream:  
  `ffmpeg -i input -c copy -f flv rtmp://localhost:1935/live/input`
* Receive a stream:  
  `ffmpeg -i rtmp://localhost:1935/live/input -c copy -f flv output`

## Build your own Image

```sh
docker build -t nginx-rtmp:dev \
              --build-arg FFMPEG_IMAGE=datarhei/ffmpeg:4 \
              --build-arg ALPINE_IMAGE=alpine:latest . 
             
docker build -t nginx-rtmp:armhf \
              --build-arg FFMPEG_IMAGE=datarhei/ffmpeg:4-armhf \
              --build-arg ALPINE_IMAGE=resin/armhf-alpine:latest . 
             
docker build -t nginx-rtmp:aarch64 \
              --build-arg FFMPEG_IMAGE=datarhei/ffmpeg:4-aarch64 \
              --build-arg ALPINE_IMAGE=resin/aarch64-alpine:latest .
```
