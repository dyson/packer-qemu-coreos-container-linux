# packer-qemu-coreos-container-linux
Packer QEMU image builder for CoreOS's Container Linux

A basic Packer template, Makefile and cloud config file to get started building QEMU images for CoreOS Container Linux.

# Installation
```
$ git clone https://github.com/dyson/packer-qemu-coreos-container-linux.git .
$ cd packer-qemu-coreos-container-linux
$ cp container-linux-config.yml.example container-linux-config.yml
```

# Installing CT

CoreOS Container Linux is moving away from the cloud-config file format and over to the container linux config and ignition formats. Ignition files use json and are transcompiled from a container linux config yaml file. The `ct` tool is used to do this and the Makefile includes some onvenient targets to install, update and delete this tool for linux hosts. Requires root to install the binary into /usr/local/bin. If you already have ct installed you can skip these steps.

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

# License
See LICENSE file.