all: build

build: graphite-clickhouse
	docker build -t mosquito/graphite-clickhouse .	

graphite-clickhouse: build-image
	docker run -t --rm -v $(shell pwd):/go/bin graphite-clickhouse-builder:latest \
		/usr/local/go/bin/go get github.com/lomik/graphite-clickhouse

build-image:
	docker build -t graphite-clickhouse-builder:latest -f Dockerfile.build .
