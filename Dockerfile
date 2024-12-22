FROM ubuntu:20.04

# Don't ask stdin anything to install software automatically.
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt upgrade -y
RUN apt install -y ansible
RUN apt install -y git

WORKDIR /root
RUN git clone https://github.com/uchan-nos/mikanos-build.git osbook
WORKDIR /root/osbook
RUN git checkout 8d4882122ec548ef680b6b5a2ae841a0fd4d07a1
WORKDIR /root/osbook/devenv
RUN ansible-playbook -i ansible_inventory ansible_provision.yml

