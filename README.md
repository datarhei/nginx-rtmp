# nginx-rtmp
simple nginx-based rtmp-server

* Start the Docker-Application:

 ```sh
docker run -d -p 1935:1935 datarhei/nginx-rtmp
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
