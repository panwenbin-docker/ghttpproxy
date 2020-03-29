FROM golang:1.14 as builder

ARG GOPROXY
ENV GORPOXY ${GOPROXY}

WORKDIR /builder

RUN git clone https://github.com/panwenbin/greverseproxy.git /builder \
  && go build proxy.go

FROM golang:1.14

COPY --from=builder /builder/proxy /app/greverseproxy

WORKDIR /app

CMD ["./greverseproxy"]

EXPOSE 80
EXPOSE 443
