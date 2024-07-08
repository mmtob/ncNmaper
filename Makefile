all : image_check
	@ docker network create network --subnet=192.168.1.0/24
	@ docker build . -tclient -f./Dockerfile.client
	@ docker build . -tserver -f./Dockerfile.server
	@ docker run --name server --network network -v ./server.sh:/volume/server.sh:ro -d server
	@ docker run --name client --network network -v ./client.sh:/volume/client.sh:ro -d client

clean: download_clean
	-docker rm --force client server
	-docker rmi --force client server
	docker network rm --force network

image_check:
	@if docker images inspect nginx:alpine >/dev/null 2>&1; then \
        docker load -i nginx:alpine; \
        docker tag nginx:alpine base:alpaka; \
    fi

download_clean:
	@if docker images inspect base:alpaka >/dev/null 2>&1; then \
        -docker rmi --force base:alpaka nginx:alpine; \
    fi

.PHONY: download_clean image_check
