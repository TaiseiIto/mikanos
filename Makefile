REPOSITORY=$(shell git config --get remote.origin.url)
PRODUCT=$(shell echo $(REPOSITORY) | awk -F '[./]' '{print $$(NF-1)}')
IMAGE=$(shell echo $(PRODUCT) | awk '{print tolower($$0)}')
CONTAINER=$(IMAGE)
VNC_PORT=5900
MOUNT=disk
TARGET=$(MOUNT).img

.PHONY: build
build: $(MOUNT)

.PHONY: delete
delete:
	delete.sh $(IMAGE) $(CONTAINER) $(TARGET) $(MOUNT)

.PHONY: image
image: $(TARGET)

.PHONY: run
run: build
	docker start $(CONTAINER)
	docker exec $(CONTAINER) /bin/bash -c "cd /root/mikanos && ./build.sh run"
	docker stop $(CONTAINER)

$(MOUNT): $(TARGET)
	mkdir $@
	sudo mount -o loop $^ $@

$(TARGET):
	./build.sh $(IMAGE) $(CONTAINER) $(VNC_PORT) $(TARGET)

