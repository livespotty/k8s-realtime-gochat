FROM golang:1.13.5-alpine3.11 as builder
RUN apk add --no-cache git make bash
ADD . /app/
# setup the working directory
WORKDIR /app
RUN make build

# use a minimal alpine image
FROM alpine:3.11
# add ca-certificates in case you need them
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
# set working directory
RUN mkdir -p /app
WORKDIR /app
# copy the binary from builder
COPY --from=builder /app/resources resources
COPY --from=builder /app/realtimechat .
EXPOSE 8090
# run the binary
CMD ["./realtimechat"]
