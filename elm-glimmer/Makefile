default:
	mkdir -p dist
	rm -rf dist/*
	cd model-display && ember build && cd - && cp -pr model-display/dist/* dist/
	elm-make elm/Main.elm --output dist/main.js
	cp -pr assets/* dist/
