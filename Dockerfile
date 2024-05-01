FROM alpine:latest
LABEL MAINTAINER="https://github.com/ultr303/srsu"
WORKDIR /srsu/
ADD . /srsu
RUN apk add --no-cache bash ncurses curl unzip wget php 
CMD "./srsu.sh"
