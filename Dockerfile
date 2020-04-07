FROM golang:1.14 as builder

ARG GOPROXY
ENV GORPOXY ${GOPROXY}

WORKDIR /builder

RUN git clone https://github.com/panwenbin/greverseproxy.git /builder \
  && go build proxy.go

FROM alpine:latest

RUN mkdir /lib64 \
  && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY --from=builder /builder/proxy /app/greverseproxy

WORKDIR /app

CMD ["./greverseproxy"]

EXPOSE 80
EXPOSE 443
