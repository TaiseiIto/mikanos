FROM ubuntu:20.04

# Don't ask stdin anything to install software automatically.
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt upgrade -y
RUN apt install -y build-essential

