FROM golang:1.12 as builder

ARG GOPROXY
ENV GORPOXY ${GOPROXY}

WORKDIR /builder

RUN git clone https://github.com/panwenbin/ghttpproxy.git /builder \
  && go build proxy.go

FROM golang:1.12

COPY --from=builder /builder/proxy /app/ghttpproxy

WORKDIR /app

CMD ["./ghttpproxy"]

EXPOSE 80
EXPOSE 443
