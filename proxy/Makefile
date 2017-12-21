IMAGE_NAME=codevalet/proxy

all: check

check: bats container
	docker-compose up --remove-orphans -d
	./test/check-connectivity
	./bats/bin/bats test/*.bats

bats:
	git clone --depth 1 -b v0.4.0 https://github.com/sstephenson/bats.git

container: Dockerfile nginx.conf supervisord.conf
	docker build -t $(IMAGE_NAME):latest .

# Whenever the nginx.conf changes, we should down the docker-compose bits just
# to ensure we come up with something new
nginx.conf:
	docker-compose down

clean:
	docker-compose down
	docker rmi $(shell docker images -q -f "reference=$(IMAGE_NAME)")
	rm -rf bats

.PHONY: all check container clean ensure-down
