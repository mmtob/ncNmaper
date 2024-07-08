> You can **make** fast start and after all **make clean**

# Preparation
## Download alpaka image
### At first need basic image you can download from **Docker Hub** by:
``` sh
docker pull nginx:alpine
```
#### **or take it from this folder by:**
``` sh
docker load --input nginx:alpine
```


# Images build
## Build **server** Image
``` sh
docker build . \
    --tag server \
    --file ./Dockerfile.server
```
## Build **client** Image
``` sh
docker build . \
    --tag client \
    --file ./Dockerfile.client
```


# Network build
## Create our network
``` sh
docker network create network \
    --subnet=192.168.1.0/24
```


# Start containers
## Up **server** container
``` sh
docker run \
    --name server \
    --volume ./server.sh:/volume/server.sh:ro \
    --network network \
    --detach \
    server
```
## Up **client** container
``` sh
docker run \
    --name client \
    --volume ./client.sh:/volume/client.sh:ro \
    --network network \
    --detach \
    client
```
