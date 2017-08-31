# nginx-rtmp

NGINX + RTMP-Module Image for H.264-Processing (e.g. RTMP, HLS)

* Alipne Linux (3.6)
* FFmpeg 3.1
* Docker-Images for AMD64, ARMHF (e.g. Raspberry-Pi) and ARM64 (e.g. Pine64)

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

* `1.13.4-dev` (docker pull `datarhei/nginx-rtmp:1.13.4-dev`)
* `1.13.4-dev-armhf` (docker pull `datarhei/nginx-rtmp:1.13.4-dev-armhf`)
* `1.13.4-dev-arm64` (docker pull `datarhei/nginx-rtmp:1.13.4-dev-arm64`)

## Example

* Start the image:  
  `docker run -d -p 1935:1935 datarhei/nginx-rtmp:1.13.4-dev` for AMD64   
  `docker run -d -p 1935:1935 datarhei/nginx-rtmp:1.13.4-dev-armhf` for ARMHF
  `docker run -d -p 1935:1935 datarhei/nginx-rtmp:1.13.4-dev-arm64` for ARM64
* Send a stream:  
  `ffmpeg -i input -c copy -f flv rtmp://localhost:1935/live/input`
* Receive a stream:  
  `ffmpeg -i rtmp://localhost:1935/live/input -c copy -f flv output`

