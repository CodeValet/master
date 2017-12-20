IMAGE_PREFIX=rtyler/codevalet

all: check plugins master

check: agent-templates validate-plugins

validate-plugins: plugins.yml
	./scripts/ruby ./scripts/plugins-from-yaml plugins.yml > /dev/null

clean:
	rm -rf build/

## Build the Jenkins master image
###############################################################
builder: Dockerfile.builder
	docker build -t ${IMAGE_PREFIX}-$@ -f Dockerfile.$@ .

master: Dockerfile build/git-refs.txt agent-templates
	docker build -t ${IMAGE_PREFIX}-$@  .

plugins: ./scripts/build-plugins plugins.txt builder
	./scripts/build-plugins

build/git-refs.txt: plugins
	./scripts/record-sha1sums
###############################################################


## Handling for agent-templates which is an external repository
###############################################################
agent-templates: build/agent-templates
	./scripts/ruby ./scripts/render-agent-templates build/agent-templates

build/agent-templates:
	git clone --depth 1 https://github.com/codevalet/agent-templates.git build/agent-templates
###############################################################

.PHONY: clean plugins master builder all check
