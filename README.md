# nginx-rtmp

NGINX + RTMP-Module Image for H.264-Processing (e.g. RTMP, HLS)

* Alipne Linux (3.6)
* FFmpeg 3.1
* Docker-Images for AMD64 and ARMHF (e.g. Raspberry-Pi)

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

* `1.9.9-1.1.7.10` (docker pull `datarhei/nginx-rtmp:1.9.9-1.1.7.10`)
* `1.9.9-1.1.7.10-armhf` (docker pull `datarhei/nginx-rtmp:1.9.9-1.1.7.10-armhf`)

## Example

* Start the image:  
  `docker run -d -p 1935:1935 datarhei/nginx-rtmp:1.9.9-1.1.7.10` for AMD64 or   
  `docker run -d -p 1935:1935 datarhei/nginx-rtmp:1.9.9-1.1.7.10-armhf` for ARMHF
* Send a stream:  
  `ffmpeg -i input -c copy -f flv rtmp://localhost:1935/live/input`
* Receive a stream:  
  `ffmpeg -i rtmp://localhost:1935/live/input -c copy -f flv output`

