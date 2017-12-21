IMAGE_NAME=codevalet/proxy
COMPOSE=build/docker-compose

all: check

check: bats container $(COMPOSE)
	$(COMPOSE) up --remove-orphans -d
	./test/check-connectivity
	./bats/bin/bats test/*.bats

container: Dockerfile nginx.conf supervisord.conf
	docker build -t $(IMAGE_NAME):latest .

clean: $(COMPOSE)
	$(COMPOSE) down
	docker rmi $(shell docker images -q -f "reference=$(IMAGE_NAME)")
	rm -rf bats
	rm -rf build


bats:
	git clone --depth 1 -b v0.4.0 https://github.com/sstephenson/bats.git

# Whenever the nginx.conf changes, we should down the docker-compose bits just
# to ensure we come up with something new
nginx.conf: $(COMPOSE)
	$(COMPOSE) down

build:
	mkdir -p build
build/docker-compose: build
	(cd build && \
	curl -sL https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o docker-compose && \
	chmod +x docker-compose)

.PHONY: all check container clean
