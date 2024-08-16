.PHONY: all clean run

all: web_fibo app_fibo

# This is the standalone app that imports and run fibo.zig
app_fibo: app_fibo.zig
	zig build-exe app_fibo.zig

# This is our wasm module produced from fibo.zig
fibo.wasm: fibo.zig
	zig build-exe \
		-target wasm32-freestanding \
		-fno-entry --export=fibo \
		-O ReleaseFast \
		fibo.zig

# WIP: This is our HTTP server that will load the fibo.wasm
# and run it...
web_fibo: web_fibo.zig web_pages/ fibo.wasm
	zig build-exe web_fibo.zig

run: all
	./app_fibo          # Standalone app that can runs alone
	node ./node_fibo.js # Use node to run our JS that loads & run fibo.wasm
	./web_fibo          # Start our web server

clean:
	rm -f *.o app_fibo fibo.wasm web_fibo
