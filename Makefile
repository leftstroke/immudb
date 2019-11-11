export GO111MODULE=on

SHELL=/bin/bash -o pipefail
PWD = $(shell pwd)
GO ?= go
PROTOC ?= protoc

.PHONY: immu
immu: build/codegen
	$(GO) build ./cmd/immu

.PHONY: immud
immud: build/codegen
	$(GO) build ./cmd/immud

.PHONY: vendor
vendor:
	$(GO) mod vendor

.PHONY: test
test:
	$(GO) vet ./...
	$(GO) test ${TEST_FLAGS} ./...

build/codegen: pkg/proto/schema.proto
	$(PROTOC) pkg/proto/schema.proto --go_out .

.PHONY: clean
clean:
	rm -f immu immud
