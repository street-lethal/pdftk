FROM ubuntu:24.04

RUN apt update
RUN apt install -y pdftk

RUN mkdir /root/tmp

