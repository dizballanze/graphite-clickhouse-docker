all: build

build: graphite-clickhouse
	docker build -t dizballanze/graphite-clickhouse .

graphite-clickhouse: build-image
	docker run -t --rm -v $(shell pwd):/go/bin graphite-clickhouse-builder:latest \
		/bin/sh -c "\
		mkdir -p /go/src/github.com/lomik/graphite-clickhouse; \
		cd /go/src/github.com/lomik/graphite-clickhouse; \
		git clone https://github.com/dizballanze/graphite-clickhouse.git .; \
		export GOPATH=/go; \
		go build -o /go/bin/graphite-clickhouse -ldflags '-extldflags "-static"' \
			github.com/lomik/graphite-clickhouse \
		"

build-image:
	docker build -t graphite-clickhouse-builder:latest -f Dockerfile.build .
