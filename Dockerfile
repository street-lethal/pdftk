FROM debian:12-slim

RUN apt update
RUN apt install -y pdftk
