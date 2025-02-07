.PHONY:	all clean code-vet code-fmt test

DEPS := $(shell find . -type f -name "*.go" -printf "%p ")

all: code-vet code-fmt test build/argocd-vault-replacer

clean:
	$(RM) -rf build

test:
	go test ./...

build/argocd-vault-replacer: $(DEPS)
	mkdir -p build
	go build -o build ./...

code-vet: $(DEPS)
## Run go vet for this project. More info: https://golang.org/cmd/vet/
	@echo go vet
	go vet $$(go list ./... )

code-fmt: $(DEPS)
## Run go fmt for this project
	@echo go fmt
	go fmt $$(go list ./... )

lint: $(DEPS)
## Run golint for this project
	@echo golint
	golint $$(go list ./... )
