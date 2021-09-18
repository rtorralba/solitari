FROM debian:stable-slim

ARG UID 
# Add user to execute all as a local user
RUN adduser -u ${UID} --disabled-password --gecos "" appuser

RUN apt-get update && apt-get install -y fp-compiler

WORKDIR /app