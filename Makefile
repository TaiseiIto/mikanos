REPOSITORY=$(shell git config --get remote.origin.url)
PRODUCT=$(shell echo $(REPOSITORY) | awk -F '[./]' '{print $$(NF-1)}')
IMAGE=$(shell echo $(PRODUCT) | awk '{print tolower($$0)}')
CONTAINER=$(IMAGE)
VNC_PORT=5900
TARGET=disk.img

.PHONY: build
build: $(TARGET)

$(TARGET): delete
	./build.sh $(IMAGE) $(CONTAINER) $(VNC_PORT) $(TARGET)

.PHONY: delete
delete:
	rm -f $(TARGET)
	./delete.sh $(IMAGE) $(CONTAINER)

.PHONY: run
run: build
	docker start $(CONTAINER)
	docker exec $(CONTAINER) /bin/bash -c "cd /root/mikanos && ./build.sh run"
	docker stop $(CONTAINER)

