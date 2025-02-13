FROM ubuntu:20.04

# Don't ask stdin anything to install software automatically.
ENV DEBIAN_FRONTEND=noninteractive

# Install softwares.
RUN apt-get update && apt-get upgrade -y && apt-get install -y ansible
RUN apt-get update && apt-get upgrade -y && apt-get install -y dosfstools
RUN apt-get update && apt-get upgrade -y && apt-get install -y git
RUN apt-get update && apt-get upgrade -y && apt-get install -y vim

# Build MikanOS.
WORKDIR /root
COPY osbook.patch /root/osbook.patch
RUN git clone https://github.com/uchan-nos/mikanos-build.git osbook
WORKDIR /root/osbook
RUN git checkout 8d4882122ec548ef680b6b5a2ae841a0fd4d07a1
RUN git apply ../osbook.patch
WORKDIR /root/osbook/devenv
RUN ansible-playbook -i ansible_inventory ansible_provision.yml
WORKDIR /root
RUN git clone https://github.com/uchan-nos/mikanos.git
WORKDIR /root/mikanos
RUN git checkout b5f7740c04002e67a95af16a5c6e073b664bf3f5
WORKDIR /root/edk2
RUN ln -s /root/mikanos/MikanLoaderPkg .
COPY build_boot_loader.sh /root/edk2/build_boot_loader.sh
COPY build_mikanos.sh /root/mikanos/build_mikanos.sh
WORKDIR /root

# Set
ENV APPS_DIR apps
ENV RESOURCE_DIR resource

# Expose VNC port.
ARG vnc_port
EXPOSE $vnc_port

