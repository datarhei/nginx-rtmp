# nginx-rtmp
A simple NGINX-based RTMP-Server

[![dockeri.co](http://dockeri.co/image/datarhei/nginx-rtmp)](https://registry.hub.docker.com/u/datarhei/nginx-rtmp/)

## Start the Docker-Application:

* amd64:

 ```sh
docker run -d -p 1935:1935 datarhei/nginx-rtmp
 ```
 
* armhf:

 ```sh
docker run -d -p 1935:1935 datarhei/nginx-rtmp:armhf
 ```

## Streaming-Example

* Send a stream:

 ```sh
ffmpeg -i input -c copy -f flv rtmp://localhost:1935/live/input
 ```
 
* Receive a stream:
 
 ```sh
ffmpeg -i rtmp://localhost:1935/live/input -c copy -f flv output
 ```
