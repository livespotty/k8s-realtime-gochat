all: deps build

.PHONY: deps
deps:
	go get -d -v github.com/dustin/go-broadcast/...
	go get -d -v github.com/manucorporat/stats/...
	go get -d -v github.com/gin-gonic/gin

.PHONY: build
build: deps
	go build -o realtimechat main.go rooms.go routes.go stats.go
