.PHONY: all clean run

all: web_server app_fibo fibo.wasm

web_server: web_server.zig web_pages/
	zig build-exe web_server.zig

app_fibo: app_fibo.zig
	zig build-exe app_fibo.zig

fibo.wasm: fibo.zig
	zig build-exe \
		-target wasm32-freestanding \
		-fno-entry --export=fibo \
		-O ReleaseFast \
		fibo.zig

run: all
	./app_fibo
	node ./node_fibo.js
	./web_server

clean:
	rm -f *.o app_fibo fibo.wasm web_server
