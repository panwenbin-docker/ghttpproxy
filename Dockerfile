FROM golang:latest as builder

ARG GOPROXY
ENV GORPOXY ${GOPROXY}

WORKDIR /builder

RUN git clone https://github.com/panwenbin/greverseproxy.git /builder \
  && go build proxy.go

FROM panwenbin/alpinetz:latest

COPY --from=builder /builder/proxy /app/greverseproxy

WORKDIR /app

CMD ["./greverseproxy"]

EXPOSE 80
EXPOSE 443
