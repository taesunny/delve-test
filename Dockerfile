# build stage
FROM golang:1.13.9 AS build
MAINTAINER Sunny

RUN go get github.com/go-delve/delve/cmd/dlv

ADD . /dockerdev
WORKDIR /dockerdev

RUN go build -gcflags="all=-N -l" -o /server
## -gcflags="all=-N -l" : turn off optimazation build option

# final stage
FROM debian:buster
MAINTAINER Sunny

EXPOSE 5000 4000

WORKDIR /
COPY --from=build /go/bin/dlv /
COPY --from=build /server /

CMD ["/dev", "--listen=:4000", "--headless=true", "--api-version=2", "--accept-multiclient", "exec", "/server", "--continue", "--log"]
## --continue : without it, webserver dosen't work before get debugging request

# docker build -t delve-test:1.0 .
# sudo docker load -i kubevirt-node-fail-controller.tar