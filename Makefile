test:
	goenv exec go test -v ./...

build:
	GOOS=linux GOARCH=amd64 goenv exec go build -trimpath -ldflags '-s -w' -o bin/main_linux
	GOOS=darwin GOARCH=arm64 goenv exec go build -trimpath -ldflags '-s -w' -o bin/main_mac
	GOOS=windows GOARCH=amd64 goenv exec go build -trimpath -ldflags '-s -w' -o bin/main.exe

fmt:
	goenv exec go fmt ./...

lint:
	goenv exec go vet ./...

init-linux:
	if [ -e main ]; then \
		unlink main; \
	fi
	ln -s bin/main_linux main

init-mac:
	if [ -e main ]; then \
		unlink main; \
	fi
	ln -s bin/main_mac main

exec:
	@./main

transfer:
	@./main -transfer

exec-s:
	goenv exec go run page_remover.go

transfer-s:
	goenv exec go run page_remover.go -transfer
