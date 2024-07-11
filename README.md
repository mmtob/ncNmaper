>
> You can **make** fast start client and after all can **make clean**
>

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

# To verify containers connectivity between containers:
>> 
>>> 3.4
>> You can see that server and client in one network, by this command:
``` bash
docker network inspect network
```
>>
>>> OR
>>
>> You can connect to container's tty
``` bash
docker exec -it client ash
```
>> AND
``` bash
docker exec -it server ash
```
>> Using __ifconfig__ or __ip addr__ you can find container's inner IP
>> and ping IP another container (in __tcpdump__ you can see ICMP requests)
>>

# To verify netcat scripts
>>> 3.5
>> when on client side connect is access, you can see message "You connected to server" from server
>>
>> If you need proof of netcat interaction use command:
``` bash
docker logs server
```
