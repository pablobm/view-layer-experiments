.PHONY: default build

default:
	(export SRC=`pwd` && make build && cd dist && python -mSimpleHTTPServer; cd "${SRC}")

build:
	mkdir -p dist
	rm -rf dist/*
	cd model-display && ember build && cd - && cp -pr model-display/dist/* dist/
	elm-make elm/Main.elm --output dist/elm.js
	cp -pr assets/* dist/
