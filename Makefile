PACKER_CMD ?= packer
CONTAINER_LINUX_RELEASE ?= stable
CONTAINER_LINUX_IMAGE_DIGEST_URL ?= https://$(CONTAINER_LINUX_RELEASE).release.core-os.net/amd64-usr/current/coreos_production_iso_image.iso.DIGESTS
CONTAINER_LINUX_CONFIG ?= container-linux-config.yml
DISK_SIZE ?= 40000
MEMORY ?= 1024M
BOOT_WAIT ?= 45s

container-linux: builds/container-linux-$(CONTAINER_LINUX_RELEASE).qcow2

builds/container-linux-$(CONTAINER_LINUX_RELEASE).qcow2:
	$(eval CONTAINER_LINUX_IMAGE_ISO_CHECKSUM := $(shell curl -s "$(CONTAINER_LINUX_IMAGE_DIGEST_URL)" | grep "coreos_production_iso_image.iso" | awk '{ print length, $$1 | "sort -rg"}' | awk 'NR == 1 { print $$2 }'))

	$(PACKER_CMD) build -force \
		-var 'release=$(CONTAINER_LINUX_RELEASE)' \
		-var 'iso_checksum=$(CONTAINER_LINUX_IMAGE_ISO_CHECKSUM)' \
		-var 'iso_checksum_type=sha512' \
		-var 'disk_size=$(DISK_SIZE)' \
		-var 'memory=$(MEMORY)' \
		-var 'boot_wait=$(BOOT_WAIT)' \
		-var 'config=$(CONTAINER_LINUX_CONFIG)' \
		container-linux.json

clean:
	rm -rf builds packer_cache

.PHONY: clean
