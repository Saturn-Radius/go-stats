FROM golang:1.14-alpine as builder

ENV GO111MODULE=on
ENV CGO_ENABLED=0

WORKDIR /src/git.sfxdx.ru/ssemenov/go-stat

COPY go.mod go.sum ./
# Dowload dependencies
RUN go mod download
# Copy source files and scripts
COPY . .

# Build
RUN ./build.sh


FROM alpine:latest

WORKDIR /srv

RUN apk add --update --no-cache ca-certificates

# Copy binary
COPY --from=builder /src/git.sfxdx.ru/ssemenov/go-stat/go-stat ./go-stat
COPY configs/config.json ./config.json

# Run the application (config must be mounted into file 'configs/config.json')
ENTRYPOINT ["./go-stat", "--config-path", "config.json"]
