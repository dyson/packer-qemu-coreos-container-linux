# packer-qemu-coreos-container-linux
Packer QEMU image builder for CoreOS's Container Linux

A basic Packer template, Makefile and cloud config file to get started building QEMU images for CoreOS Container Linux.

# Installation
```
$ git clone https://github.com/dyson/packer-qemu-coreos-container-linux.git .
$ cd packer-qemu-coreos-container-linux
$ cp container-linux-config.yml.example container-linux-config.yml
```

## Installing ct

CoreOS Container Linux is moving away from the cloud-config file format and over to the [container linux config](https://coreos.com/os/docs/latest/configuration.html) and [ignition](https://coreos.com/ignition/docs/latest/what-is-ignition.html) formats. Ignition files use JSON and are transpiled from a container linux config YAML file. The [ct](https://github.com/coreos/container-linux-config-transpiler/) tool is used to do this and the Makefile includes some convenient targets to install, update, and delete this tool for linux hosts. Requires root to install the binary into /usr/local/bin. If you already have ct installed you can skip these steps.

Install:
```
$ make ct
```

Update:
```
$ make ct-update
```

Delete:
```
$ make ct-clean
```

# Usage
Populate your [container linux config](https://coreos.com/os/docs/latest/configuration.html) YAML file with all configuration you want apply in the installed image.

## With Makefile

### Makefile variables
```make
PACKER_CMD ?= packer
RELEASE ?= alpha
DIGEST_URL ?= https://$(RELEASE).release.core-os.net/amd64-usr/current/coreos_production_iso_image.iso.DIGESTS
CONFIG ?= container-linux-config.yml
DISK_SIZE ?= 40000
MEMORY ?= 2048M
BOOT_WAIT ?= 45s
```
### Basic example using defaults
```
$ make container-linux
```
### Building the alpha release
```
$ make container-linux RELEASE=alpha
```
### Other make targets
Delete builds:
```
$ make clean
```
Delete the packer cache (making packer download the latest iso image on next build):
```
$ make cache-clean
```

## Without Makefile
Without buidling from the Makefile you will neet to obtain the iso checksum manually (or not varify it) and also transpile the container linux config into the ignition format before building.

### Packer variables
```make
"release": "stable",
"iso_checksum": "",
"iso_checksum_type": "none",
"disk_size": "40000",
"memory": "2048M",
"boot_wait": "45s",
"ignition": "ignition.json"
```
### Basic example using defaults
```
$ packer build -force container-linux.json
```
### Building the alpha release
```
$ packer build -force -var 'release=alpha' container-linux.json
```
# License
See LICENSE file.
