FROM golang:1.14-alpine as builder
ENV GO111MODULE=on
ENV CGO_ENABLED=0
RUN apk add --update --no-cache ca-certificates git openssl
WORKDIR /src/go-stat
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN ./build.sh

FROM alpine:3.13.2
WORKDIR /build
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /src/go-stat/go-stat .
COPY --from=builder /src/go-stat/configs/config-docker.json config.json
ENTRYPOINT ["./go-stat", "--config-path", "config.json"]
