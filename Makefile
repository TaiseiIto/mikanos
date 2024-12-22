REPOSITORY=$(shell git config --get remote.origin.url)
PRODUCT=$(shell echo $(REPOSITORY) | awk -F '[./]' '{print $$(NF-1)}')
IMAGE=$(shell echo $(PRODUCT) | awk '{print tolower($$0)}')
CONTAINER=$(IMAGE)

.PHONY: build
build:
	./build.sh $(IMAGE) $(CONTAINER)

.PHONY: delete
delete:
	./delete.sh $(IMAGE) $(CONTAINER)

.PHONY: rebuild
rebuild:
	make delete
	make build

